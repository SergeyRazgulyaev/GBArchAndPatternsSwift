//
//  NetworkProxyWithAdapter.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 20.11.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import Foundation

protocol NetworkServiceWithAdapterInterface {
    func getPhotos(token: String, ownerID: Int, albumID: AlbumID, photoCount: Int, then completion: @escaping ([PhotoItemsWithAdapter]) -> Void)
}

class NetworkServiceWithAdapterProxy: NetworkServiceWithAdapterInterface {
    let networkServiceWithAdapter: PhotoItemsAdapter
    
    init(networkServiceWithAdapter: PhotoItemsAdapter) {
        self.networkServiceWithAdapter = networkServiceWithAdapter
    }
    
    func getPhotos(token: String, ownerID: Int, albumID: AlbumID, photoCount: Int, then completion: @escaping ([PhotoItemsWithAdapter]) -> Void) {
        self.networkServiceWithAdapter.getPhotos(token: token, ownerID: ownerID, albumID: PhotoItemsAdapter.AlbumID(rawValue: albumID.rawValue) ?? .profile, photoCount: photoCount, then: completion)
        print("Called function loadPhotosForAdapter")
    }
}
