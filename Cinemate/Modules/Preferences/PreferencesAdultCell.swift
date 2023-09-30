//
//  PreferencesAdultCell.swift
//  Cinemate
//
//  Created by Indo Teknologi Utama on 23/09/23.
//

import UIKit

class PreferencesAdultCell: CollectionCell {
    
    private let labelTitle = UILabel()
    private let switchView = UISwitch()
    
    override func setupView() {
        super.setupView()
        
        contentView.addSubview(switchView)
        switchView.translatesAutoresizingMaskIntoConstraints = false
        switchView.rightToSuperview(space: -16)
        switchView.verticalSuperview(space: 8)
        
        contentView.addSubview(labelTitle)
        labelTitle.translatesAutoresizingMaskIntoConstraints = false
        labelTitle.leftToSuperview(space: 16)
        labelTitle.centerY(toView: switchView)
        labelTitle.font = .systemFont(ofSize: 14, weight: .semibold)
        labelTitle.textColor = .white
        switchView.addTarget(self, action: #selector(didSwitch(control:)), for: .valueChanged)
    }
    @objc func didSwitch(control: UISwitch) {
        UserPreference.isAdult = control.isOn
    }
    func setValue(with isOn: Bool) {
        switchView.isOn = isOn
        labelTitle.text = UserPreferenceSettings.isAdultContent.title
    }
}
