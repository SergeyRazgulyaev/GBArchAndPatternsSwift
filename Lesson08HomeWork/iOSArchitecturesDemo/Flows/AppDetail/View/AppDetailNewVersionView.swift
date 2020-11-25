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
        return label
    }()
    
    private(set) lazy var releaseDateLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    private(set) lazy var discriptionOfVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
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
        self.addSubview(self.discriptionOfVersionLabel)

        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            titleLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            
            historyButton.lastBaselineAnchor.constraint(equalTo: titleLabel.lastBaselineAnchor),
            historyButton.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            versionNumberLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 12.0),
            versionNumberLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),

            releaseDateLabel.topAnchor.constraint(equalTo: historyButton.bottomAnchor, constant: 12.0),
            releaseDateLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),

            discriptionOfVersionLabel.topAnchor.constraint(equalTo: versionNumberLabel.bottomAnchor, constant: 12.0),
            discriptionOfVersionLabel.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            discriptionOfVersionLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0)
        ])
    }
}
