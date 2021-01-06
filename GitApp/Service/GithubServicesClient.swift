//
//  GithubServicesClient.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import RxSwift

class GithubServicesClient {
    
    func search(query: String) -> Observable<[Repository]> {
        return Observable.create { observer -> Disposable in
            if let url = URL(string: "https://api.github.com/search/repositories?q=\(query)") {
                
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
            let url = URL(string: "https://api.github.com/repos/\(ownerName)/\(repoName)/commits")
            
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
