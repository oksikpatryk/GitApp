//
//  GitRepositoryDetalisViewModel.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import RxSwift
import RxCocoa

class GitRepositoryDetalisViewModel {
    let image : BehaviorRelay<UIImage?> = BehaviorRelay(value: nil)
    let client = GithubServicesClient()
    let commtis : BehaviorRelay<[CommitResponse]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    func downloadImage(url: URL) {
        URLSession.shared.dataTask( with: url, completionHandler: { (data, _, _) -> Void in
            DispatchQueue.main.async {
                if let data = data {
                    self.image.accept(UIImage(data: data))
                }
            }
        }
        ).resume()
    }

    func getCommitsFor(repoName: String, ownerName: String) {
        guard !repoName.isEmpty || !ownerName.isEmpty else {
            self.commtis.accept([]);
            return
        }
        client.getCommitsFor(repoName: repoName, ownerName: ownerName)
            .subscribe(
                onNext: { [weak self] commits in
                    self?.commtis.accept(commits)
                },
                onError: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
    }
}
