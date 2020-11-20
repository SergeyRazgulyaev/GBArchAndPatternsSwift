//
//  PhotosViewController.swift
//  VKClient_RazgulyaevSergey
//
//  Created by Sergey Razgulyaev on 09.07.2020.
//  Copyright © 2020 Sergey Razgulyaev. All rights reserved.
//

import UIKit
import RealmSwift

class PhotosViewController: UIViewController {
    @IBOutlet private weak var collectionView: UICollectionView!
    @IBOutlet private weak var friendsNameLabel: UILabel!
    
    //MARK: - Base properties
    var name: String?
    var friendID: Int?
    private var photosNumbersCount: Int = 1
    private var timeSortedArray: [String] = []
    private var photoNumbersArray: [Int] = []
    private let interactiveTransition = InteractiveTransition()
    private var dateTextCache: [IndexPath : String] = [:]
    
    private var photosWithAdapter: [PhotoItemsWithAdapter] = []
    private let viewModelFactory = PhotoViewModelFactory()
    private var viewModels: [PhotoViewModel] = []

    //MARK: - Properties for Interaction with Network
    private let networkServiceWithAdapter = PhotoItemsAdapter()
    private lazy var networkServiceWithAdapterProxy = NetworkServiceWithAdapterProxy(networkServiceWithAdapter: networkServiceWithAdapter)

    //MARK: - ViewController Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        configurePhotosViewController()
        loadPhotosFromNetWork()
    }
    
    //MARK: - Configuration Methods
    func configurePhotosViewController() {
        collectionView.dataSource = self
        collectionView.delegate = self
        friendsNameLabel.text = name
        friendsNameLabel.font = UIFont.friendsNameLabelFont
        if let layout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout {
            layout.itemSize = CGSize(width: 200, height: 230)
        }
    }
}

//MARK: - Interaction with Network
extension PhotosViewController {
    func loadPhotosFromNetWork() {
        networkServiceWithAdapterProxy.getPhotos(token: Session.instance.token, ownerID: friendID!, albumID: .profile, photoCount: 10) { [weak self] results in
            self?.photosWithAdapter = results
            self?.viewModels = self?.viewModelFactory.constructViewModel(from: results) as! [PhotoViewModel]
            self?.collectionView.reloadData()
        }
    }
}

//MARK: - Collection Data Source Methods
extension PhotosViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        configureCell(indexPath: indexPath)
    }

    func configureCell(indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "PhotoCell", for: indexPath) as? PhotoCell else { return UICollectionViewCell() }
        let photoNumber = String("\(viewModels.count - indexPath.row)")
        cell.configureCellPhotoNumberText(photoNumberLabelText: photoNumber)
        cell.userID = friendID
        cell.configureCellUIByFactory(with: viewModels[indexPath.row])
        return cell
    }
}

//MARK: - Collection Delegate Methods
extension PhotosViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        //        print(indexPath)
    }
}

//MARK: - Animation of View Controller Transitioning
extension PhotosViewController: UIViewControllerTransitioningDelegate {
    func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PushAnimator()
    }
    
    func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        return PopAnimator()
    }
}

extension PhotosViewController: UINavigationControllerDelegate {
    func navigationController(_ navigationController: UINavigationController, animationControllerFor operation: UINavigationController.Operation, from fromVC: UIViewController, to toVC: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        if operation == .pop {
            if navigationController.viewControllers.first != toVC {
                interactiveTransition.viewController = toVC
                return PopAnimator()
            }
            return nil
        } else {
            if navigationController.viewControllers.first != fromVC {
                interactiveTransition.viewController = toVC
                return PushAnimator()
            }
            return nil
        }
    }
    
    func navigationController(_ navigationController: UINavigationController, interactionControllerFor animationController: UIViewControllerAnimatedTransitioning) -> UIViewControllerInteractiveTransitioning? {
        return interactiveTransition.hasStarted ? interactiveTransition : nil
    }
}

//MARK: - Alert
extension PhotosViewController {
    private func showAlert(title: String? = nil,
                           message: String? = nil,
                           handler: ((UIAlertAction) -> ())? = nil,
                           completion: (() -> Void)? = nil) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default, handler: handler)
        alertController.addAction(okAction)
        present(alertController, animated: true, completion: completion)
    }
}
