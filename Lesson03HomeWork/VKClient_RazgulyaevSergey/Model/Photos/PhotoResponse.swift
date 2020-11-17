//
//  PhotoResponse.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 25.08.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import Foundation
import RealmSwift

class PhotoResponse: Object, Decodable {
    @objc dynamic var count: Int = 0
    var items = List<PhotoItems>()
    
    enum CodingKeys: String, CodingKey {
        case count
        case items 
    }
    
    override class func primaryKey() -> String? {
        return "count"
    }
}
