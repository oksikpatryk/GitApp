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
}
