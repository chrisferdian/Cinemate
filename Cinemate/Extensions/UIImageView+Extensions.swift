//
//  UIImageView+Extensions.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 19/09/23.
//

import UIKit

extension UIImageView {
    convenience init(image: UIImage? = nil,
                     contentMode: UIView.ContentMode = .scaleAspectFit) {
        self.init(image: image)
        translatesAutoresizingMaskIntoConstraints = false
        self.contentMode = contentMode
        clipsToBounds = true
    }
    convenience init(imageName: String,
                     contentMode: UIView.ContentMode = .scaleAspectFit) {
        let image = UIImage(named: imageName)
        self.init(image: image)
        self.contentMode = contentMode
        translatesAutoresizingMaskIntoConstraints = false
    }
}
