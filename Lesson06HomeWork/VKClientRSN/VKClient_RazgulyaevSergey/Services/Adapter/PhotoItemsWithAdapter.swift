//
//  PhotoItemsWithAdapter.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 07.11.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import Foundation

struct PhotoItemsWithAdapter {
    var albumID: Int
    var date: Double
    var id: Int
    var likes: PhotoLikes?
    var ownerID: Int
    var sizes = [PhotoSizes]()
}
