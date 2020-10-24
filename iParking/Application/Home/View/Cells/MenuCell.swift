//
//  MenuCell.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import UIKit

class MenuCell: BaseCollectionViewCell {
    //MARK: - Variables
     static let reuseIdentifier: String="menuCell"
     var wrapperCell: UIStackView = UIStackView()
     var menuIcon: UIImageView = UIImageView()
     var titleLabel: UILabel = UILabel()
     
    
     //MARK: - Override Functions
     override func setup() {
        
        removeAutoConstraintsFromView(vs: [contentView,wrapperCell, menuIcon, titleLabel])
        backgroundColor = .clear
        
        contentView.layer.cornerRadius = 20
        contentView.backgroundColor = Colors.primary()
        contentView.layer.masksToBounds = false
        contentView.layer.shadowColor = UIColor.init(red: 0, green: 0, blue: 0, alpha: 0.5).cgColor
        contentView.layer.shadowOffset = CGSize(width: 0, height: 1)
        contentView.layer.shadowRadius =  3
        contentView.layer.shadowOpacity = 0.4
        
        addSubview(wrapperCell)
        wrapperCell.axis = .vertical
        wrapperCell.spacing = 10
        wrapperCell.distribution = .fill
        wrapperCell.alignment = .center
        wrapperCell.topAnchor.constraint(equalTo: topAnchor, constant: 10).isActive = true
        wrapperCell.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        wrapperCell.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        
        wrapperCell.addArrangedSubview(menuIcon)
        menuIcon.contentMode = .scaleAspectFill
        menuIcon.widthAnchor.constraint(equalToConstant: 80).isActive = true
        menuIcon.heightAnchor.constraint(equalToConstant: 80).isActive = true

        wrapperCell.addArrangedSubview(titleLabel)
        titleLabel.textColor = Colors.primaryText()
        titleLabel.numberOfLines = 0
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.systemFont(ofSize: 18)
        titleLabel.heightAnchor.constraint(equalToConstant: 50).isActive = true
     }
    
    func config(withViewModel viewModel: MenuPresentable) {
        titleLabel.text = viewModel.title
        menuIcon.image = UIImage(named: viewModel.icon ?? "")
    }
}
