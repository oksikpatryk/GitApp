//
//  GithubServicesClient.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import RxSwift

class GithubServiceClient {
    
    private let GITHUB_BASE_URL = "https://api.github.com/"
    
    func searchRepository(by name: String, page: Int = 1) -> Observable<[Repository]> {
        return Observable.create { observer -> Disposable in
            if let url = URL(string: self.GITHUB_BASE_URL + "search/repositories?q=\(name)&per_page=20&page=\(page)") {
                
                let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
                    guard let data = data else { return }
                    
                    DispatchQueue.main.async {
                        do {
                            let decoder = JSONDecoder()
                            let response = try decoder.decode(SearchRepositoryResponse.self, from: data)
                            observer.onNext(response.items)
                        } catch let err {
                            observer.onError(err)
                        }
                    }
                }
                task.resume();
            }
            return Disposables.create()
        }
    }
    
    func getCommitsFor(repoName: String, ownerName: String) -> Observable<[CommitResponse]> {
        return Observable.create { observer -> Disposable in
            let url = URL(string:  self.GITHUB_BASE_URL + "repos/\(ownerName)/\(repoName)/commits")
            
            let task = URLSession.shared.dataTask(with: url!) { (data, response, error) in
                guard let data = data else { return }
                
                DispatchQueue.main.async {
                    do {
                        let decoder = JSONDecoder()
                        let response = try decoder.decode([CommitResponse].self, from: data)
                        observer.onNext(response)
                    } catch let err {
                         observer.onError(err)
                    }
                }
            }
            task.resume();
        
            return Disposables.create()
        }
    }
}
