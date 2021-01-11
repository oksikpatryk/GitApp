//
//  GithubRepositoriesViewModel.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import RxSwift
import RxRelay

class GithubRepositoriesViewModel {
    let client = GithubServiceClient()
    let repositories : BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()
    
    private var PAGE_NUMBER = 1

    func search(repoName: String, nextPage: Bool = false) {
        PAGE_NUMBER = nextPage ? PAGE_NUMBER + 1 : 1
        guard !repoName.isEmpty else {
            repositories.accept([]);
            return
        }
        
        client.searchRepository(by: repoName, page: PAGE_NUMBER)
            .subscribe(
                onNext: { [weak self] repositories in
                    var newValue: [Repository]
                    if nextPage {
                        newValue = (self?.repositories.value)! + repositories
                    }
                    else {
                        newValue = repositories
                    }
                    self?.repositories.accept(newValue)
                },
                onError: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
    }

}
