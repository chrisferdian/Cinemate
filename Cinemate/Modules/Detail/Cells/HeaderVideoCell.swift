//
//  HeaderVideoCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit

class HeaderVideoCell: CollectionCell {
    
    let buttonPlay = UIButton(image: .init(systemName: "play.fill"))
    var onTapPlay: (()->Void)?
    
    override func setupView() {
        super.setupView()
        
        contentView.addSubview(buttonPlay)
        buttonPlay.horizontalSuperview(space: 16)
        buttonPlay.verticalSuperview(space: 12)
        buttonPlay.backgroundColor = .white
        buttonPlay.isEnabled = false
        buttonPlay.setCorner(radius: 16)
        buttonPlay.height(44)
        buttonPlay.addTarget(self, action: #selector(didTapPlay), for: .touchUpInside)
    }
    
    func bind(with video: MovieVideo) {
        if let _ = video.key {
            buttonPlay.isEnabled = true
        }
    }
    
    @objc func didTapPlay() {
        onTapPlay?()
    }
}
