//
//  DetailTableViewCell.swift
//  CurrencyRates
//
//  Created by Maksim on 28/04/2020.
//  Copyright © 2020 Maksim. All rights reserved.
//

import UIKit

class DetailTableViewCell: UITableViewCell {

    var titleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    var subTitleLabel: UILabel = {
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = .secondaryLabel
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupTitleLabel()
        setupSubTitleLabel()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupTitleLabel() {
        contentView.addSubview(titleLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 12),
            titleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            titleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 16)
        ])
    }
    
    func setupSubTitleLabel() {
        contentView.addSubview(subTitleLabel)
        NSLayoutConstraint.activate([
            subTitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subTitleLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
            subTitleLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
            subTitleLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -12),
            subTitleLabel.heightAnchor.constraint(greaterThanOrEqualToConstant: 18)
        ])
    }
}
