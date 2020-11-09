//
//  PhotoViewModelFactory.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 09.11.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import UIKit

class PhotoViewModelFactory {
    func constructViewModel(from photos: [PhotoItemsWithAdapter]) -> [PhotoViewModel] {
        return photos.compactMap(self.getViewModel)
    }
    
    private func getViewModel(from photo: PhotoItemsWithAdapter) -> PhotoViewModel {
        guard let url = URL(string: ((photo.sizes.last?.url)!)), let data = try? Data(contentsOf: url) else { return PhotoViewModel(photoCardImage: UIImage(systemName: "tortoise.fill")!, photoDateText: "", likeCount: "")}
        let photoCardImage = UIImage(data: data) ?? UIImage(systemName: "tortoise.fill")!
        let photoDateText = PhotoViewModelFactory.formateDate(timeToTranslate: photo.date)
        let likeCount = String(photo.likes!.count)
        return PhotoViewModel(photoCardImage: photoCardImage, photoDateText: photoDateText, likeCount: likeCount)
    }
    
    private static func formateDate(timeToTranslate: Double) -> String {
        let formatter = DateFormatter()
        formatter.dateStyle = DateFormatter.Style.long
        let date = Date(timeIntervalSince1970: timeToTranslate)
        return formatter.string(from: date)
    }
}
