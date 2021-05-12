//
//  BusinessTableViewCell.swift
//  BusinessesNearMe
//
//  Created by Cong Le on 5/11/21.
//

import UIKit

class BusinessTableViewCell: UITableViewCell {
  lazy var businessNameLabel: UILabel = {
    let label = UILabel()
    label.numberOfLines = 0
    label.adjustsFontSizeToFitWidth = true
    label.textAlignment = .left
    label.font = UIFont.boldSystemFont(ofSize: 18)
    label.text = "Business name"
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String? ) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    addUIElements()
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  override func layoutSubviews() {
    contentView.backgroundColor = UIColor.clear
  }
}

// MARK: - Setup UI elements
extension BusinessTableViewCell {
  func addUIElements() {
    contentView.addSubview(businessNameLabel)
    setBusinessNameLabelConstraints()
  }
  
  func setBusinessNameLabelConstraints() {
    businessNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      businessNameLabel.leadingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
      businessNameLabel.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 0),
      businessNameLabel.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      businessNameLabel.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
