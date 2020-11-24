//
//  AppDetailDescriptionViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Sergey Razgulyaev on 22.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionViewController: UIViewController {
    
    //MARK: - Properties
    private let app: ITunesApp
    private var appDetailDescriptionView: AppDetailDescriptionView {
        return self.view as! AppDetailDescriptionView
    }
    private var releaseDate: String = "0"
    
    //MARK: - Init
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailDescriptionView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    private func fillData() {
        appDetailDescriptionView.versionNumberLabel.text = "Version " + (app.version ?? "")
        
        appDetailDescriptionView.descriptionOfVersionLabel.text = app.releaseNotes
        
        appDetailDescriptionView.releaseDateLabel.text = showDate(timeToTranslate: app.currentVersionReleaseDate ?? "0")
    }
    
    private func showDate(timeToTranslate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        
        let receivedReleaseDate = dateFormatter.date(from: timeToTranslate) ?? Date(timeIntervalSinceNow: 0)
        let daysSinceRelease = (Double(-receivedReleaseDate.timeIntervalSinceNow) / 86400).rounded()
        
        if daysSinceRelease > 1, daysSinceRelease < 14  {
            return NSString(format: "%.0f", daysSinceRelease) as String + " days ago"
        } else if daysSinceRelease >= 14, daysSinceRelease < 30 {
            return NSString(format: "%.0f", daysSinceRelease/7) as String + " weeks ago"
        } else if daysSinceRelease >= 30, daysSinceRelease < 365 {
            return NSString(format: "%.0f", daysSinceRelease/30) as String + " months ago"
        } else if daysSinceRelease >= 365, daysSinceRelease < 36500 {
            return NSString(format: "%.0f", daysSinceRelease/365) as String + " years ago"
        } else {
            dateFormatter.dateFormat = "dd/MM/yyyy HH:mm"
            return dateFormatter.string(from: receivedReleaseDate)
        }
    }
}
