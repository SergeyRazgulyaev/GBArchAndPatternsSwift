//
//  AppDetailDescriptionView.swift
//  iOSArchitecturesDemo
//
//  Created by Sergey Razgulyaev on 23.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class AppDetailDescriptionView: UIView {
    
    //MARK: - Subviews
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 1
        label.text = "What's new"
        return label
    }()
    
    private(set) lazy var historyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .blue
        button.setTitle("Versions history", for: .normal)
        return button
    }()
    
    private(set) lazy var versionNumberLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var descriptionOfVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14.0)
        label.numberOfLines = 5
        return label
    }()
    
    private(set) lazy var moreButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.tintColor = .blue
        button.setTitle("more", for: .normal)
        return button
    }()
    
    //MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //MARK: - UI
    func setupLayout() {
        self.addSubview(self.titleLabel)
        self.addSubview(self.historyButton)
        self.addSubview(self.versionNumberLabel)
        self.addSubview(self.releaseDateLabel)
        self.addSubview(self.descriptionOfVersionLabel)
        self.addSubview(self.moreButton)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 22.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            
            historyButton.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor),
            historyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            versionNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            versionNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),

            releaseDateLabel.lastBaselineAnchor.constraint(equalTo: versionNumberLabel.lastBaselineAnchor),
            releaseDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),

            descriptionOfVersionLabel.topAnchor.constraint(equalTo: versionNumberLabel.bottomAnchor, constant: 12.0),
            descriptionOfVersionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            descriptionOfVersionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            moreButton.topAnchor.constraint(equalTo: descriptionOfVersionLabel.bottomAnchor),
            moreButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0)
        ])
    }
}
