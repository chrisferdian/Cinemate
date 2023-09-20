//
//  LoadingCVCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import UIKit

class LoadingCVCell: CollectionCell {
    
    private let activityIndicator = UIActivityIndicatorView(style: .medium)
    
    override func setupView() {
        super.setupView()
        backgroundColor = .black
        contentView.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        activityIndicator.centerXToSuperview()
        activityIndicator.centerYToSuperview()
        activityIndicator.tintColor = .white
        activityIndicator.startAnimating()
    }
    
    func start() {
        activityIndicator.startAnimating()
    }
}
