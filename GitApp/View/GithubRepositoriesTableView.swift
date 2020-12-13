//
//  GithubRepositoriesTableViewController.swift
//  GitApp
//
//  Created by patryk.oksik on 12/12/2020.
//

import UIKit

class GithubRepositoriesTableView: UITableViewController, UISearchBarDelegate {
    let searchController = UISearchController(searchResultsController: nil)

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationItem.title = "Search"
        searchController.searchBar.delegate = self
        self.navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(MyCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        self.tableView.separatorColor = .clear;

    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        print(searchText)
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 5
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerId")
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)

        return cell
    }
}

class Header: UITableViewHeaderFooterView {
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let headerLabel: UILabel = {
        let label = UILabel()
        label.text = "Repositories"
        label.font = UIFont.boldSystemFont(ofSize: 24)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        contentView.backgroundColor = .white
        addSubview(headerLabel)
        headerLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        headerLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        bottomAnchor.constraint(equalTo: headerLabel.bottomAnchor, constant: 18).isActive = true
        
    }
}

class MyCell: UITableViewCell {
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
        label.text = "Repo Title"
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
        imageV.contentMode = .scaleAspectFit
        return imageV
    }()

    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.frame = contentView.frame.inset(by: UIEdgeInsets(top: 9, left: 16, bottom: 9, right: 16))
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
        ownerImage.topAnchor.constraint(equalTo: topAnchor, constant: 27).isActive = true
        ownerImage.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -27).isActive = true
        ownerImage.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 32).isActive = true
        
        stac.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        stac.heightAnchor.constraint(equalToConstant: 40).isActive = true
        stac.leftAnchor.constraint(equalTo: ownerImage.rightAnchor, constant: 8).isActive = true
    }
}
