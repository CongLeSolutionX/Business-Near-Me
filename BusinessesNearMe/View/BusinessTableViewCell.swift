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
    label.textColor = .black
    label.font = UIFont.boldSystemFont(ofSize: 18)
    return label
  }()
  
  lazy var addressLabel: UILabel = {
    let label = UILabel()
    label.textColor = .black
    label.font = UIFont.italicSystemFont(ofSize: 12)
    return label
  }()
  
  lazy var labelContainer: UIView = {
    return UIView()
  }()
  
  var searchBusinessInfoViewModel: BusinessInfoViewModel? {
    didSet {
      searchBusinessInfoViewModel?.updateView = bindData
      bindData()
    }
  }
  
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
  
  func bindData() {
    guard let searchBusinessInfoVM = searchBusinessInfoViewModel else {
      businessNameLabel.text = nil
      addressLabel.text = nil
      return
    }
    businessNameLabel.text = searchBusinessInfoVM.name
    addressLabel.text = searchBusinessInfoVM.address
  }
}

// MARK: - Setup UI elements
extension BusinessTableViewCell {
  func addUIElements() {
    contentView.addSubview(labelContainer)
    labelContainer.addSubview(businessNameLabel)
    labelContainer.addSubview(addressLabel)
    
    setBusinessNameLabelConstraints()
  }
  
  func setBusinessNameLabelConstraints() {
    labelContainer.translatesAutoresizingMaskIntoConstraints = false
    businessNameLabel.translatesAutoresizingMaskIntoConstraints = false
    addressLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      // Set constraints for business name Label
      businessNameLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor),
      businessNameLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor),
      businessNameLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor),
      
      // Set constraints for address label
      addressLabel.topAnchor.constraint(equalTo: businessNameLabel.bottomAnchor),
      addressLabel.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 15),
      addressLabel.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -15),
      
      // Set Label Container Constraints
      labelContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      labelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: -10),
      labelContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
