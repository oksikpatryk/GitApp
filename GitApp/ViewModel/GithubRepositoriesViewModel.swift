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
    let client = GithubServicesClient()
    let repositories : BehaviorRelay<[Repository]> = BehaviorRelay(value: [])
    let disposeBag = DisposeBag()

    func search(query:String) {
        guard !query.isEmpty else {
            self.repositories.accept([]);
            return
        }
        client.search(query: query)
            .subscribe(
                onNext: { [weak self] repositories in
                    self?.repositories.accept(repositories)
                },
                onError: { error in
                    print(error)
                }
            )
            .disposed(by: disposeBag)
    }

}
