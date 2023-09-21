//
//  DetailTitleCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

class DetailTitleCell: CollectionCell {
    
    let labelTitle = UILabel()
    let labelRelease = UILabel()

    override func setupView() {
        super.setupView()
        contentView.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.topLeftToSuperView(topSpace: 8, leftSpace: 16)
        labelTitle.rightToSuperview(space: -16)
        labelTitle.font = .systemFont(ofSize: 24, weight: .semibold)
        labelTitle.textColor = .white
        
        contentView.addSubview(labelRelease)
        labelRelease.translatesAutoresizingMaskIntoConstraints = false
        labelRelease.top(toAnchor: labelTitle.bottomAnchor, space: 8)
        labelRelease.bottomToSuperview(space: -8)
        labelRelease.leftToSuperview(space: 16)
        labelRelease.font = .systemFont(ofSize: 12, weight: .thin)
        labelRelease.textColor = .white
    }
    
    func bind(with model: MovieTitles) {
        labelTitle.text = model.title
        labelRelease.text = "\(model.release_date) • \(model.vote_average)"
    }
}
