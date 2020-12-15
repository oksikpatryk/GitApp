//
//  CommitCell.swift
//  GitApp
//
//  Created by patryk.oksik on 15/12/2020.
//
import Foundation
import UIKit
import RxSwift
import RxCocoa

class CommitCell: UITableViewCell {
    let viewModel: RepositoryCellViewModel = RepositoryCellViewModel()
    let disposeBag = DisposeBag()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let labelPosition: UILabel = {
        let label = UILabel()
        label.text = "1"
        label.backgroundColor = .systemGray5
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.clipsToBounds = true

        return label
    }()
    
    let labelCommitAuthorName: UILabel = {
        let label = UILabel()
        label.text = "Author Name"
        label.textColor = .systemBlue
        label.font = UIFont.systemFont(ofSize: 11)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelCommitAuthorEmail: UILabel = {
        let label = UILabel()
        label.text = "email@email.com"
        label.font = UIFont.systemFont(ofSize: 17)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let labelCommitMessage: UILabel = {
        let label = UILabel()
        label.text = "message"
        label.font = UIFont.systemFont(ofSize: 17)
        label.textColor = UIColor(red: 158/255, green: 158/255, blue: 158/255, alpha: 1.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 0

        return label
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 4.5, left: 16, bottom: 4.5, right: 16))
    }
    
    func setupCell(model: CommitResponse, position: Int) {
        labelPosition.text = String(position + 1)
        labelCommitAuthorEmail.text = model.commit.author.email
        labelCommitMessage.text = model.commit.message
    }
    
    func setupViews() {
        let stac = UIStackView(arrangedSubviews: [labelCommitAuthorName, labelCommitAuthorEmail, labelCommitMessage])
        stac.axis = .vertical
        stac.distribution = .fillProportionally
        addSubview(stac)
        addSubview(labelPosition)
        stac.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            labelPosition.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelPosition.leftAnchor.constraint(equalTo: leftAnchor, constant: 20),
            labelPosition.trailingAnchor.constraint(equalTo: leadingAnchor, constant: 36),
            labelPosition.bottomAnchor.constraint(greaterThanOrEqualTo: bottomAnchor, constant: -26),
            
            stac.topAnchor.constraint(equalTo: topAnchor, constant: 16),
            stac.leftAnchor.constraint(equalTo: labelPosition.rightAnchor, constant: 20),
            stac.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            stac.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -11.5)
        ])
    }
}
