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
    private var appDetailNewVersionView: AppDetailDescriptionView {
        return self.view as! AppDetailDescriptionView
    }
    
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
        appDetailNewVersionView.versionNumberLabel.text = "Version " + "123"
        appDetailNewVersionView.releaseDateLabel.text = "456" + " days ago"
        appDetailNewVersionView.discriptionOfVersionLabel.text = "789"
    }
}
