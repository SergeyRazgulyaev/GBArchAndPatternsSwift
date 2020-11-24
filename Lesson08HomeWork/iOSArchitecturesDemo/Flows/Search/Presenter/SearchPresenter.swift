//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 17.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit
import Alamofire

protocol SearchViewInput: AnyObject {
    var searchAppsResults: [ITunesApp] { get set }
    var searchSongsResults: [ITunesSong] { get set }
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidSearchApps(with query: String)
    func viewDidSearchSongs(with query: String)
    func viewDidSelectApp(_ app: ITunesApp)
    func viewDidSelectSong(_ song: ITunesSong)
}

class SearchPresenter {
    private let searchService = ITunesSearchService()
    private let interactor: SearchInteractorInput
    private let router: SearchRouterInput
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    
    init(interactor: SearchInteractorInput, router: SearchRouterInput) {
        self.interactor = interactor
        self.router = router
    }
    
    private func openAppDetails(with app: ITunesApp) {
        router.openAppDetails(for: app)
    }
    
    private func openSongDetails(with song: ITunesSong) {
        router.openSongDetails(for: song)
    }
}

extension SearchPresenter: SearchViewOutput {
    func viewDidSearchApps(with query: String) {
        interactor.requestApps(with: query) { [weak self] (result) in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result.withValue { (apps) in
                guard !apps.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchAppsResults = apps
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    func viewDidSelectApp(_ app: ITunesApp) {
        openAppDetails(with: app)
    }
    
    func viewDidSearchSongs(with query: String) {
        interactor.requestSongs(with: query) { [weak self] (result) in
            guard let self = self else { return }
            self.viewInput?.throbber(show: false)
            result.withValue { (songs) in
                guard !songs.isEmpty else {
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchSongsResults = songs
            }.withError { (error) in
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    func viewDidSelectSong(_ song: ITunesSong) {
        openSongDetails(with: song)
    }
    
}
