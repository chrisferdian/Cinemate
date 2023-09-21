//
//  DetailOverviewCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

class DetailOverviewCell: CollectionCell {
    let labelTitle = UILabel()

    override func setupView() {
        super.setupView()
        backgroundColor = .black
        contentView.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.fillSuperView(space: .init(space: 16))
        labelTitle.font = .systemFont(ofSize: 14, weight: .regular)
        labelTitle.textColor = .white
        labelTitle.numberOfLines = 0
    }
    
    func bind(with model: MovieOverview) {
        labelTitle.text = model.text
    }
}
