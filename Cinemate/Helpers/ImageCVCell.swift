//
//  ImageCVCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import UIKit

class ImageCVCell: CollectionCell {
    
    private let imageView = UIImageView(contentMode: .scaleAspectFill)
    
    override func setupView() {
        super.setupView()
        contentView.addSubview(imageView)
        imageView.fillSuperView()
        imageView.backgroundColor = .random
    }
}
