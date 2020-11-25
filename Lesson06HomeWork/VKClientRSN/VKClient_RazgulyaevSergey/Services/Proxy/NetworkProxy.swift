//
//  NetworkProxy.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 20.11.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import Foundation

enum AlbumID: String {
    case wall = "wall"
    case profile = "profile"
    case saved = "saved"
}

enum typeOfNews: String {
    case post = "post"
    case photo = "photo,wall_photo"
}

protocol NetworkServiceInterface {
    func loadFriends(token: String, completion: ((Result<[UserItems], Error>) -> Void)?)
    func loadPhotos(token: String, ownerID: Int, albumID: AlbumID, photoCount: Int, completion: ((Result<[PhotoItems], Error>) -> Void)?)
    func loadGroups(token: String, completion: ((Result<[GroupItems], Error>) -> Void)?)
    func loadNews(token: String, typeOfNews: typeOfNews, startTime: Double?, startFrom: String, completion: ((Result<NewsResponse, Error>) -> Void)?)
    func loadSearchedGroups(token: String, searchedGroupName: String, completion: ((Result<[GroupItems], Error>) -> Void)?)
}

class NetworkServiceProxy: NetworkServiceInterface {
    let networkService: NetworkService

    init(networkService: NetworkService) {
        self.networkService = networkService
    }
    
    func loadFriends(token: String, completion: ((Result<[UserItems], Error>) -> Void)?) {
        self.networkService.loadFriends(token: token, completion: completion)
        print("Called function loadFriends")
    }
    
    func loadPhotos(token: String, ownerID: Int, albumID: AlbumID, photoCount: Int, completion: ((Result<[PhotoItems], Error>) -> Void)?) {
        self.networkService.loadPhotos(token: token, ownerID: ownerID, albumID: NetworkService.AlbumID(rawValue: albumID.rawValue) ?? .profile, photoCount: photoCount, completion: completion)
        print("Called function loadPhotos")
    }
    
    func loadGroups(token: String, completion: ((Result<[GroupItems], Error>) -> Void)?) {
        self.networkService.loadGroups(token: token, completion: completion)
        print("Called function loadGroups")
    }
    
    func loadNews(token: String, typeOfNews: typeOfNews, startTime: Double?, startFrom: String, completion: ((Result<NewsResponse, Error>) -> Void)?) {
        self.networkService.loadNews(token: token, typeOfNews: NetworkService.typeOfNews(rawValue: typeOfNews.rawValue) ?? .post, startTime: startTime, startFrom: startFrom, completion: completion)
        print("Called function loadNews")
    }
    
    func loadSearchedGroups(token: String, searchedGroupName: String, completion: ((Result<[GroupItems], Error>) -> Void)?) {
        self.networkService.loadSearchedGroups(token: token, searchedGroupName: searchedGroupName, completion: completion)
        print("Called function loadSearchedGroups")
    }
}
