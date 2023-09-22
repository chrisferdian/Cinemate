//
//  ImageCVCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import UIKit
import SDWebImage
enum ImageSize: String {
    case w45 = "w45"
    case w500 = "w500"
    case w780 = "w780"
    case original = "original"
}
class ImageCVCell: CollectionCell {
    
    private let imageView = UIImageView(contentMode: .scaleAspectFill)
    
    override func setupView() {
        super.setupView()
        contentView.addSubview(imageView)
        imageView.fillSuperView()
        imageView.backgroundColor = .random
    }
    
    func bind(with movie: Movie, size: ImageSize = .w500) {
        let urlString = "http://image.tmdb.org/t/p/\(size.rawValue)/"+(movie.poster_path ?? "-")
        guard let url = URL(string: urlString) else { return }
        imageView.sd_setImage(with: url)
    }
    func bind(with path: String, size: ImageSize = .w500) {
        let urlString = "http://image.tmdb.org/t/p/\(size.rawValue)/"+(path)
        guard let url = URL(string: urlString) else { return }
        imageView.sd_setImage(with: url)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
    }
}
