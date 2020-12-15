//
//  HelloCoordinator.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import UIKit

class GitRepositoreisCoordinator: Coordinator {

    // MARK: - Properties

    var navigationController: UINavigationController

    // MARK: - Init

    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }

    // MARK: - Methods

    func start() {
        let gitRepositoriesView = GithubRepositoriesView()
        navigationController.pushViewController(gitRepositoriesView, animated: true)
    }
    
    
    func showDetails(repository: Repository) {
        let vc = GitRepositoryDetailsView()
        vc.repository = repository
        navigationController.pushViewController(vc, animated: true)
    }
    
    func openBrowser(url: URL) {
        UIApplication.shared.open(url)
    }
}
