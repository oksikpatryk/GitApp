//
//  GithubRepositoriesTableViewController.swift
//  GitApp
//
//  Created by patryk.oksik on 12/12/2020.
//

import UIKit
import RxSwift
import RxCocoa

class GithubRepositoriesView: UIViewController, UISearchBarDelegate {
    let searchController = UISearchController(searchResultsController: nil)
    let disposeBag = DisposeBag()
    let viewModel: GithubRepositoriesViewModel = GithubRepositoriesViewModel()
    
    let tableView = UITableView()
    private var coordinator: GitRepositoreisCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        overrideUserInterfaceStyle = .light

        coordinator = GitRepositoreisCoordinator(navigationController: self.navigationController!)
        view.backgroundColor = .white
        navigationItem.title = "Search"
        searchController.obscuresBackgroundDuringPresentation = false;
        searchController.searchBar.delegate = self
        navigationItem.searchController = searchController
        navigationController?.navigationBar.prefersLargeTitles = true
        tableView.register(GitRepositoryCell.self, forCellReuseIdentifier: "cellId")
        tableView.register(Header.self, forHeaderFooterViewReuseIdentifier: "headerId")
        tableView.separatorColor = .clear;
        view.addSubview(tableView)
        tableView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0.0),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0.0),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0.0),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0.0)
        ])
        
        self.setupBinding()
    }
    
    private func setupBinding() {
        
        searchController.searchBar.rx.text
            .orEmpty
            .throttle(.seconds(2), scheduler: MainScheduler.instance)
            .distinctUntilChanged()
            .subscribe(onNext: { query in
                self.viewModel.search(repoName: query, nextPage: false)
            }, onError: { error in
                print(error)
            }, onCompleted: {
                print("done")
            }, onDisposed:  {
                print("on disposed")
            }).disposed(by: disposeBag)
 

        viewModel.repositories.asObservable().bind(to: tableView.rx.items(cellIdentifier: "cellId", cellType: GitRepositoryCell.self)) { index, model, cell in
            cell.setupCell(model: model)
        }.disposed(by: disposeBag)
        
        tableView.rx.modelSelected(Repository.self)
            .subscribe(onNext: { repository in
                self.coordinator?.showDetails(repository: repository)
                
                if let selectedRowIndexPath = self.tableView.indexPathForSelectedRow {
                    self.tableView.deselectRow(at: selectedRowIndexPath, animated: true)
                }
            })
            .disposed(by: disposeBag)
        
        tableView
            .rx
            .willDisplayCell
            .subscribe(onNext: {
                cell, indexPath in
                let lastItem = self.viewModel.repositories.value.count - 1
                if indexPath.row == lastItem {
                    self.viewModel.search(repoName: self.searchController.searchBar.text ?? "", nextPage: true)
                }
            })
            .disposed(by: disposeBag)
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
