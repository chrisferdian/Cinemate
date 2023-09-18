//
//  UIEdgeInsets+Extension.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 18/09/23.
//

import UIKit

extension UIEdgeInsets {
    init(space: CGFloat) {
        self.init(top: space, left: space, bottom: space, right: space)
    }

    init(top: CGFloat = 0, left: CGFloat = 0, bottom: CGFloat = 0, right: CGFloat = 0) {
        self.init()
        self.top = top
        self.left = left
        self.bottom = bottom
        self.right = right
    }
}
