//
//  ImageCVCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import UIKit
import SDWebImage

class ImageCVCell: CollectionCell {
    
    private let imageView = UIImageView(contentMode: .scaleAspectFill)
    
    override func setupView() {
        super.setupView()
        contentView.addSubview(imageView)
        imageView.fillSuperView()
        imageView.backgroundColor = .random
    }
    
    func bind(with movie: Movie) {
        let urlString = "http://image.tmdb.org/t/p/w500/"+(movie.poster_path ?? "-")
        guard let url = URL(string: urlString) else { return }
        imageView.sd_setImage(with: url)
    }
    func bind(with path: String) {
        let urlString = "http://image.tmdb.org/t/p/w500/"+(path)
        guard let url = URL(string: urlString) else { return }
        imageView.sd_setImage(with: url)
    }
}
