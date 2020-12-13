//
//  MainCoordinator.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation

import UIKit

class MainCoordinator: Coordinator {
    
    var navigationController: UINavigationController

    // MARK: - Private properties

    private let window: UIWindow

    // MARK: - Init

    init(window: UIWindow) {
        self.navigationController = UINavigationController()
        self.window = window
    }

    // MARK: - Methods

    func start() {
        window.rootViewController = navigationController
        window.makeKeyAndVisible()

        let gitRepositoriesCoordintor = GitRepositoreisCoordinator(navigationController: navigationController)
        gitRepositoriesCoordintor.start()
    }

}
