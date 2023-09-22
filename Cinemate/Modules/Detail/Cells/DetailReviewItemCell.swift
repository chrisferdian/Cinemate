//
//  DetailReviewItemCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 21/09/23.
//

import UIKit
import SDWebImage

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
        let divider = UIView()
        divider.backgroundColor = .gray
        divider.translatesAutoresizingMaskIntoConstraints = false
        addSubview(divider)
        divider.rightToSuperview()
        divider.leftToSuperview(space: 32)
        divider.verticalSuperview(space: 14)
        divider.height(1)
    }
}
class DetailReviewHeaderView: UICollectionReusableView {
    
    var onTappedSeeAll: (()-> Void)?
    let label = UILabel()
    let buttonSeeAll = UIButton()

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
        buttonSeeAll.translatesAutoresizingMaskIntoConstraints = false
        buttonSeeAll.setTitle("See All", for: .normal)
        
        label.translatesAutoresizingMaskIntoConstraints = false
        addSubview(label)
        label.verticalSuperview()
        label.leftToSuperview()
        label.text = ""
        label.font = .systemFont(ofSize: 24, weight: .bold)
        
        addSubview(buttonSeeAll)
        buttonSeeAll.rightToSuperview(space: -16)
        buttonSeeAll.centerY(toView: label)
        buttonSeeAll.addTarget(self, action: #selector(didTapSeeAll), for: .touchUpInside)
    }
    func setSeeAllVisibility(isHidden: Bool) {
        self.buttonSeeAll.isHidden = isHidden
    }
    func setTitle(with text: String) {
        label.text = text
    }
    @objc func didTapSeeAll() {
        onTappedSeeAll?()
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
        if let path = review.authorDetails?.avatarPath,
        let url = URL(string: "https://image.tmdb.org/t/p/w200/\(path)") {
            imageViewAvatar.sd_setImage(with: url)
        }
    }
}
