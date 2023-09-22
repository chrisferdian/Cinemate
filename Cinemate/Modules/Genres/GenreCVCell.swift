//
//  GenreCVCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

class GenreCVCell: CollectionCell {
    
    private let labelName = UILabel()
    
    override func setupView() {
        super.setupView()
        
        contentView.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.fillSuperView(space: .init(space: 8))
        labelName.textColor = .white
    }
    
    func bind(with genre: GenreInfo) {
        labelName.text = genre.name
    }
}
