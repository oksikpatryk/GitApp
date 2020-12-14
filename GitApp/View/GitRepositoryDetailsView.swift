//
//  GitRepositoryDetailsViewController.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import UIKit
import RxSwift
import RxCocoa

class GitRepositoryDetailsView: UIViewController {
    var repository: Repository?
    let viewModel: GitRepositoryDetalisViewModel = GitRepositoryDetalisViewModel()
    let disposeBag = DisposeBag()

    let tableView = UITableView()
    let ownerImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "user")
        imageV.contentMode = .scaleAspectFill
        imageV.clipsToBounds = true
        return imageV
    }()
    
    let labelRepoBy: UILabel = {
        let label = UILabel()
        label.text = "REPO BY"
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 15)
        label.alpha = 0.5
        return label
    }()
    
    let labelOwnerName: UILabel = {
        let label = UILabel()
        label.text = "Owner"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 28)
        return label
    }()
    
    let labelNumberOfStars: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 13)
        label.alpha = 0.5
        label.text = "Number of stars (0)"
        return label
    }()
    
    let labelRepoTitle: UILabel = {
        let label = UILabel()
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 17)
        label.text = "Repo Title"
        return label
    }()
    
    let buttonViewOnline: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        button.setTitle("VIEW ONLINE", for: .normal)
        button.widthAnchor.constraint(equalToConstant: button.titleLabel!.intrinsicContentSize.width + 20).isActive = true
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 15
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        button.addTarget(self, action: #selector(buttonViewOnlinePressed), for: .touchUpInside)
        return button
    }()
    
    let buttonShareRepo: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system) as UIButton
        button.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        button.imageEdgeInsets = UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 10)
        button.setTitle("Share Repo", for: .normal)
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        button.backgroundColor = .systemGray5
        button.layer.cornerRadius = 10
        button.clipsToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.addTarget(self, action: #selector(buttonShareRepoPressed), for: .touchUpInside)
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        guard repository != nil else { return }
        view.backgroundColor = .white
        
        let stack = UIStackView(arrangedSubviews: [labelRepoBy, labelOwnerName, labelNumberOfStars])
        stack.axis = .vertical
        stack.distribution = .fill
        view.addSubview(stack)
        view.addSubview(ownerImage)
        view.addSubview(labelRepoTitle)
        view.addSubview(buttonViewOnline)
        view.addSubview(tableView)
        view.addSubview(buttonShareRepo)
        ownerImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            ownerImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            ownerImage.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 263),
            ownerImage.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            ownerImage.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0)
        ])
        view.sendSubviewToBack(ownerImage)
        stack.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            stack.bottomAnchor.constraint(equalTo: ownerImage.bottomAnchor, constant: -22.0),
            stack.leftAnchor.constraint(equalTo: ownerImage.leftAnchor, constant: 16.0),
            stack.rightAnchor.constraint(equalTo: ownerImage.rightAnchor, constant: 16.0)
        ])
        labelRepoTitle.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            labelRepoTitle.topAnchor.constraint(equalTo: ownerImage.bottomAnchor, constant: 21.0),
            labelRepoTitle.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 20.0),
            labelRepoTitle.rightAnchor.constraint(equalTo: view.centerXAnchor)
        ])
        buttonViewOnline.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonViewOnline.centerYAnchor.constraint(equalTo: labelRepoTitle.centerYAnchor),
            buttonViewOnline.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0)
        ])
        buttonShareRepo.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            buttonShareRepo.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -44),
            buttonShareRepo.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -16.0),
            buttonShareRepo.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 16.0)
        ])
        
        viewModel.downloadImage(url: repository!.owner.avatar_url)
        viewModel.image.asObservable().bind(to: ownerImage.rx.image).disposed(by: self.disposeBag)
    }
    
    @objc
     func buttonViewOnlinePressed() {
         print("Button pressed")
     }
    
    @objc
     func buttonShareRepoPressed() {
         print("Button pressed")
     }
}
