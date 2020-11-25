//
//  SongDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Sergey Razgulyaev on 24.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

class SongDetailHeaderView: UIView {
        
    private(set) lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 30.0
        imageView.layer.masksToBounds = true
        return imageView
    }()
    
    private(set) lazy var trackNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.numberOfLines = 2
        return label
    }()
    
    private(set) lazy var artistNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.systemFont(ofSize: 17.0)
        return label
    }()
    
    private(set) lazy var collectionNameLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14.0)
        return label
    }()
    
    private(set) lazy var playButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Add to Playlist", for: .normal)
        button.backgroundColor = UIColor.greenSoft
        button.layer.cornerRadius = 16.0
        button.layer.masksToBounds = true
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    private func setUI() {
        self.addSubview(imageView)
        self.addSubview(trackNameLabel)
        self.addSubview(artistNameLabel)
        self.addSubview(collectionNameLabel)
        self.addSubview(playButton)
        
        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            imageView.leftAnchor.constraint(equalTo: leftAnchor, constant: 16.0),
            imageView.heightAnchor.constraint(equalToConstant: 120.0),
            imageView.widthAnchor.constraint(equalToConstant: 120.0),
            
            trackNameLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12.0),
            trackNameLabel.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16.0),
            trackNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -16.0),
            
            artistNameLabel.topAnchor.constraint(equalTo: trackNameLabel.bottomAnchor, constant: 16.0),
            artistNameLabel.leftAnchor.constraint(equalTo: trackNameLabel.leftAnchor),
            artistNameLabel.rightAnchor.constraint(equalTo: trackNameLabel.rightAnchor),
            
            collectionNameLabel.topAnchor.constraint(equalTo: artistNameLabel.bottomAnchor, constant: 16.0),
            collectionNameLabel.leftAnchor.constraint(equalTo: artistNameLabel.leftAnchor),
            collectionNameLabel.rightAnchor.constraint(equalTo: artistNameLabel.rightAnchor),
            
            playButton.leftAnchor.constraint(equalTo: imageView.rightAnchor, constant: 16.0),
            playButton.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 12.0),
            playButton.widthAnchor.constraint(equalToConstant: 150.0),
            playButton.heightAnchor.constraint(equalToConstant: 32.0)
        ])
        
    }
    
    
    
}
