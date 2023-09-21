//
//  DetailReviewItemCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit
class DetailReviewFooterView: UICollectionReusableView {
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    func setupView() {
        backgroundColor = .black
    }
}
class DetailReviewHeaderView: UICollectionReusableView {
    
    override init(frame: CGRect) {
        
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .black
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.horizontalSuperview()
        label.verticalSuperview(space: 8)
        label.text = "Reviews"
        label.font = .systemFont(ofSize: 24, weight: .bold)
    }
    
}
class DetailReviewItemCell: CollectionCell {
    
    let imageViewAvatar = UIImageView()
    let labelName = UILabel()
    let labelComment = UILabel()
    
    override func setupView() {
        super.setupView()
        contentView.addSubview(imageViewAvatar)
        imageViewAvatar.translatesAutoresizingMaskIntoConstraints = false
        imageViewAvatar.square(edge: 24)
        imageViewAvatar.setCorner(radius: 12)
        imageViewAvatar.leftToSuperview(space: 16)
        imageViewAvatar.topToSuperview(space: 8)
        imageViewAvatar.backgroundColor = .random
        
        contentView.addSubview(labelName)
        labelName.translatesAutoresizingMaskIntoConstraints = false
        labelName.left(toAnchor: imageViewAvatar.rightAnchor, space: 16)
        labelName.topToSuperview(space: 8)
        labelName.rightToSuperview(space: -16)
        
        contentView.addSubview(labelComment)
        labelComment.translatesAutoresizingMaskIntoConstraints = false
        labelComment.numberOfLines = 0
        labelComment.top(toAnchor: imageViewAvatar.bottomAnchor, space: 8)
        labelComment.horizontalSuperview(space: 16)
        labelComment.bottomToSuperview(space: -8)
        
        contentView.setCorner(radius: 16)
        contentView.backgroundColor = .gray
    }
    
    func bind(with review: MovieReview) {
        labelName.text = review.author
        labelComment.text = review.content
    }
}
