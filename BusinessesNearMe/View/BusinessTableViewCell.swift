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
      return
    }
    
    businessNameLabel.text = searchBusinessInfoVM.name
   
  }
}

// MARK: - Setup UI elements
extension BusinessTableViewCell {
  func addUIElements() {
    contentView.addSubview(labelContainer)
    labelContainer.addSubview(businessNameLabel)
    setBusinessNameLabelConstraints()
  }
  
  func setBusinessNameLabelConstraints() {
    labelContainer.translatesAutoresizingMaskIntoConstraints = false
    businessNameLabel.translatesAutoresizingMaskIntoConstraints = false
    
    NSLayoutConstraint.activate([
      // Set constraints for Business Name Label
      businessNameLabel.leadingAnchor.constraint(equalTo: labelContainer.leadingAnchor, constant: 0),
      businessNameLabel.trailingAnchor.constraint(equalTo: labelContainer.trailingAnchor, constant: 0),
      businessNameLabel.topAnchor.constraint(equalTo: labelContainer.topAnchor, constant: 0),
      
      // Set Label Container Constraints
      labelContainer.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
      labelContainer.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
      labelContainer.centerYAnchor.constraint(equalTo: contentView.centerYAnchor)
    ])
  }
}
