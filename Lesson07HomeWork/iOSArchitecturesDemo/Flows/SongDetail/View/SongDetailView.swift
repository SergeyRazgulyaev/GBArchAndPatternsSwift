//
//  SongDetailView.swift
//  iOSArchitecturesDemo
//
//  Created by Sergey Razgulyaev on 24.11.2020.
//  Copyright © 2020 ekireev. All rights reserved.
//

import UIKit

final class SongDetailView: UIView {
    
    // MARK: - Subviews
        let throbber = UIActivityIndicatorView(style: .gray)
    
    // MARK: - Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.configureUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.configureUI()
    }
    
    // MARK: - UI
    private func configureUI() {
        self.backgroundColor = .white
        self.addImageViewThrobber()
    }
    
    private func addImageViewThrobber() {
        self.throbber.translatesAutoresizingMaskIntoConstraints = false

    }
}
