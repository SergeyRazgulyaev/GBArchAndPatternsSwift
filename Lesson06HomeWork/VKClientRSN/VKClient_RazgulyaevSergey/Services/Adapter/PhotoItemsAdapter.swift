//
//  PhotoItemsAdapter.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 07.11.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoItemsAdapter {
    enum AlbumID: String {
        case wall = "wall"
        case profile = "profile"
        case saved = "saved"
    }
    
    private let photoItemsService = NetworkService()
    private var realmNotificationToken: [Int: NotificationToken] = [:]
    private let realmManagerPhotos = RealmManager.instance
    
    func getPhotos(token: String, ownerID: Int, albumID: AlbumID, photoCount: Int, then completion: @escaping ([PhotoItemsWithAdapter]) -> Void) {
        var photosFromRealm: Results<PhotoItems>? {
            let photosFromRealm: Results<PhotoItems>? = realmManagerPhotos?.getObjects().filter("ownerID = \(ownerID)")
            return photosFromRealm
        }
        guard let realmPhotos = photosFromRealm else {
                print("No realmPhoto")
                return
        }
        realmNotificationToken[ownerID]?.invalidate()
        
        let token = realmPhotos.observe() {[weak self] (changes) in
            guard let self = self else { return }
            switch changes {
            case .initial:
                break

            case .update(let realmPhotos, _, _, _):
                var photos: [PhotoItemsWithAdapter] = []
                realmPhotos.forEach { (realmPhoto) in
                    photos.append(self.getPhotoFromRealm(from: realmPhoto))
                }
                self.realmNotificationToken[ownerID]?.invalidate()
                completion(photos)

            case .error(let error):
                print(error.localizedDescription)
            }
        }

        self.realmNotificationToken[ownerID] = token
        photoItemsService.loadPhotosForAdapter(token: Session.instance.token, ownerID: ownerID, albumID: .profile, photoCount: 10)
    }
    
    private func getPhotoFromRealm(from realmPhoto: PhotoItems) -> PhotoItemsWithAdapter {
        return PhotoItemsWithAdapter(albumID: realmPhoto.albumID,
                                     date: realmPhoto.date,
                                     id: realmPhoto.id,
                                     likes: realmPhoto.likes,
                                     ownerID: realmPhoto.ownerID,
                                     sizes: Array(realmPhoto.sizes))
    }
}
