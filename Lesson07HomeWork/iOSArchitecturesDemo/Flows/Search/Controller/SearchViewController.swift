//
//  SearchViewController.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 14.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit

final class SearchViewController: UIViewController {
    
    // MARK: - Private Properties
    
    private var searchView: SearchView {
        return self.view as! SearchView
    }
    
    private let searchService = ITunesSearchService()
    var searchAppsResults = [ITunesApp]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    var searchSongsResults = [ITunesSong]() {
        didSet {
            searchView.tableView.isHidden = false
            searchView.tableView.reloadData()
            searchView.searchBar.resignFirstResponder()
        }
    }
    
    private struct Constants {
        static let reuseIdentifierApps = "reuseIDApps"
        static let reuseIdentifierSongs = "reuseIDSongs"
    }
    
    private let presenter: SearchViewOutput
    
    init(presenter: SearchViewOutput) {
        self.presenter = presenter
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // MARK: - Lifecycle
    
    override func loadView() {
        super.loadView()
        self.view = SearchView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.searchView.searchBar.delegate = self
        self.searchView.tableView.register(AppCell.self, forCellReuseIdentifier: Constants.reuseIdentifierApps)
        self.searchView.tableView.register(SongCell.self, forCellReuseIdentifier: Constants.reuseIdentifierSongs)
        
        self.searchView.tableView.delegate = self
        self.searchView.tableView.dataSource = self
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.throbber(show: false)
    }
}

//MARK: - UITableViewDataSource
extension SearchViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch tabBarItem.title {
        case "Apps":
            return searchAppsResults.count
        case "Songs":
            return searchSongsResults.count
        default:
            print("Error")
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        switch tabBarItem.title {
        case "Apps":
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierApps, for: indexPath)
            guard let cell = dequeuedCell as? AppCell else {
                return dequeuedCell
            }
            let app = self.searchAppsResults[indexPath.row]
            let cellModel = AppCellModelFactory.cellModel(from: app)
            cell.configure(with: cellModel)
            return cell
        case "Songs":
            let dequeuedCell = tableView.dequeueReusableCell(withIdentifier: Constants.reuseIdentifierSongs, for: indexPath)
            guard let cell = dequeuedCell as? SongCell else {
                return dequeuedCell
            }
            let song = self.searchSongsResults[indexPath.row]
            let cellModel = SongCellModelFactory.cellModel(from: song)
            cell.configure(with: cellModel)
            return cell
        default:
            print("Error")
            return UITableViewCell()
        }
    }
}

//MARK: - UITableViewDelegate
extension SearchViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        switch tabBarItem.title {
        case "Apps":
            let app = searchAppsResults[indexPath.row]
            let appDetaillViewController = AppDetailViewController(app: app)
            appDetaillViewController.app = app
            presenter.viewDidSelectApp(app)
        case "Songs":
            let song = searchSongsResults[indexPath.row]
            let songDetaillViewController = SongDetailViewController(song: song)
            songDetaillViewController.song = song
            presenter.viewDidSelectSong(song)
        default:
            print("Error")
        }
    }
}

//MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let query = searchBar.text else {
            searchBar.resignFirstResponder()
            return
        }
        if query.count == 0 {
            searchBar.resignFirstResponder()
            return
        }
        switch tabBarItem.title {
        case "Apps":
            presenter.viewDidSearchApps(with: query)
        case "Songs":
            presenter.viewDidSearchSongs(with: query)
        default:
            print("Error")
        }
    }
}

extension SearchViewController: SearchViewInput {
    // MARK: - Private
    
    func throbber(show: Bool) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = show
    }
    
    func showError(error: Error) {
        let alert = UIAlertController(title: "Error", message: "\(error.localizedDescription)", preferredStyle: .alert)
        let actionOk = UIAlertAction(title: "OK", style: .cancel, handler: nil)
        alert.addAction(actionOk)
        self.present(alert, animated: true, completion: nil)
    }
    
    func showNoResults() {
        self.searchView.emptyResultView.isHidden = false
    }
    
    func hideNoResults() {
        self.searchView.emptyResultView.isHidden = true
    }
}
