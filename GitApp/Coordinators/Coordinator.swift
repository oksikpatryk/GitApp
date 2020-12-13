//
//  File.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import UIKit

protocol Coordinator {
    var navigationController: UINavigationController { get set }
    
    func start()
}
