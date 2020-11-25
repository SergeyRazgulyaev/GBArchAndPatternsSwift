//
//  PhotoCell.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 09.07.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import UIKit

class PhotoCell: UICollectionViewCell {
    @IBOutlet private weak var photosViewController: UIViewController!
    @IBOutlet private weak var photoCardImageView: UIImageView!
    @IBOutlet private weak var photoLabel: UILabel!
    @IBOutlet private weak var photoNumberLabel: UILabel!
    @IBOutlet private weak var photoDateLabel: UILabel!
    @IBOutlet private weak var friendNameLabel: UILabel!
    @IBOutlet private weak var heartView: HeartView!
    
    //MARK: - Base properties
    var userID: Int?
    var interactiveAnimator: UIViewPropertyAnimator!
    
    //MARK: - Lifecycle
    override func awakeFromNib() {
        super.awakeFromNib()
        configureFonts()
        configurePhotoCell()
        configureGestureRecognizer()
    }
    
    override func prepareForInterfaceBuilder() {
        super.prepareForInterfaceBuilder()
        configurePhotoCell()
    }
    
    //MARK: - Configuration Methods
    func configureFonts() {
        photoLabel.font = UIFont.mainTextFont
        photoNumberLabel.font = UIFont.mainTextFont
        photoDateLabel.font = UIFont.reducedMainTextFont
        
    }
    
    func configurePhotoCell() {
        photoCardImageView.isUserInteractionEnabled = true
    }
    
    func configureGestureRecognizer() {
        let photoCardImageViewTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(onTap(_:)))
        addGestureRecognizer(photoCardImageViewTapRecognizer)
    }

    @objc func onTap(_ sender: Any?) {
        photosViewController.shouldPerformSegue(withIdentifier: "zoomPhotoSegue", sender: Any?.self)
        let vc = photosViewController.storyboard?.instantiateViewController(withIdentifier: "ZoomPhotoVC") as! ZoomPhotoViewController
        vc.friendZoomPhotoNumber = Int(photoNumberLabel.text!)
        vc.friendID = userID
        vc.transitioningDelegate = photosViewController as? UIViewControllerTransitioningDelegate
        photosViewController.navigationController?.delegate = photosViewController as? UINavigationControllerDelegate
        photosViewController.navigationController?.pushViewController(vc, animated: true)
    }
    
    func configureCellPhotoNumberText(photoNumberLabelText: String) {
        photoNumberLabel.text = photoNumberLabelText
    }
    
    func configureCellUIByFactory(with photoViewModel: PhotoViewModel) {
        photoDateLabel.text = photoViewModel.photoDateText
        photoCardImageView.image = photoViewModel.photoCardImage
        getHeartView().configureheartLabel(heartLabelNumber: photoViewModel.likeCount)
    }
    
    //MARK: - Access Methods
    func getHeartView() -> HeartView {
        return heartView
    }
}
