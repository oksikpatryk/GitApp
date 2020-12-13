//
//  GitRepositoryCell.swift
//  GitApp
//
//  Created by patryk.oksik on 13/12/2020.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class GitRepositoryCell: UITableViewCell {
    let viewModel: RepositoryCellViewModel = RepositoryCellViewModel()
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.backgroundColor = UIColor(red: 245/255, green: 245/255, blue: 245/255, alpha: 1.0)
        contentView.layer.cornerRadius = 13
        
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let repositoryNameLabel: UILabel = {
        let label = UILabel()
        label.text = "model.name"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let numberOfStars: UILabel = {
        let label = UILabel()
        label.text = "333"
        label.textColor = .gray
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let ownerImage: UIImageView = {
        let imageV = UIImageView()
        imageV.image = UIImage(named: "user")
        imageV.layer.cornerRadius = 10.0;
        imageV.contentMode = .scaleToFill
        imageV.clipsToBounds = true
        return imageV
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4.5, left: 16, bottom: 4.5, right: 16))
    }
    
    func setupCell(model: Repository) {
        repositoryNameLabel.text = model.name
        numberOfStars.text = "\(model.stargazers_count)"
        ownerImage.image = UIImage(named: "user")
        viewModel.downloadImage(url: model.owner.avatar_url)
        viewModel.image.asObservable().bind(to: ownerImage.rx.image).disposed(by: self.disposeBag)

    }
    
    func setupViews() {
        let stac = UIStackView(arrangedSubviews: [repositoryNameLabel, numberOfStars])
        stac.axis = .vertical
        stac.distribution = .fillProportionally
        addSubview(stac)
        addSubview(ownerImage)
        
        stac.translatesAutoresizingMaskIntoConstraints = false
        repositoryNameLabel.translatesAutoresizingMaskIntoConstraints = false
        numberOfStars.translatesAutoresizingMaskIntoConstraints = false
        ownerImage.translatesAutoresizingMaskIntoConstraints = false
        ownerImage.topAnchor.constraint(equalTo: topAnchor, constant: 16).isActive = true
        ownerImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -16).isActive = true
        ownerImage.heightAnchor.constraint(equalToConstant: 60).isActive = true
        ownerImage.widthAnchor.constraint(equalToConstant: 60).isActive = true
        ownerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        stac.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stac.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stac.leftAnchor.constraint(equalTo: ownerImage.rightAnchor, constant: 8).isActive = true
    }
}
