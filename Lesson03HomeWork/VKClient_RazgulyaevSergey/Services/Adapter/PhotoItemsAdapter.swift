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
    
    func getPhotos(token: String, ownerID: Int, albumID: AlbumID, photoCount: Int, then completion: @escaping ([PhotoItemsWithAdapter]) -> Void) {
        guard let realm = try? Realm(),
            let realmPhoto = realm.object(ofType: PhotoItems.self, forPrimaryKey: ownerID) else { return }
        
        realmNotificationToken[ownerID]?.invalidate()
        
        let token = realmPhoto.observe() {[weak self] (changes) in
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
        
        realmNotificationToken[ownerID] = token
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
