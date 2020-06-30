//
//  ClotheInfoCustomCell.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class ClotheInfoCustomCell: UITableViewCell {
  static var identifier = "ClotheInfoCustomCell"
  
  lazy var imgButton: UIButton = {
    let imgButton = UIButton()
    imgButton.backgroundColor = .red
    imgButton.setImage(UIImage(named: "plus_photo-1"), for: .normal)
    imgButton.layer.cornerRadius = imgButton.frame.width / 2
    return imgButton
  }()
  
  let textField: UITextField = {
    let text = UITextField()
    text.placeholder = " 이름을 적어주세요."
    text.textAlignment = .center
    text.keyboardType = .emailAddress
    text.layer.borderWidth = 2
    text.layer.borderColor = CGColor(srgbRed: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    text.layer.cornerRadius = 7
    text.clearButtonMode = .whileEditing
    return text
  }()
  
  let view: UIView = {
    let view = UIView()
    return view
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    let width: CGFloat = contentView.frame.width / 2
    let height: CGFloat = contentView.frame.height
    let ui = [imgButton, textField, view]
    ui.forEach { contentView.addSubview($0) }
    ui.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
    
    NSLayoutConstraint.activate([
      imgButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
      imgButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
      imgButton.widthAnchor.constraint(equalToConstant: width),
      imgButton.heightAnchor.constraint(equalToConstant: width)
    ])
    
    NSLayoutConstraint.activate([
      textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
      textField.leadingAnchor.constraint(equalTo: imgButton.trailingAnchor, constant: 10),
      textField.heightAnchor.constraint(equalToConstant: height),
      textField.widthAnchor.constraint(equalToConstant: width)
    ])
    
    NSLayoutConstraint.activate([
      view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
      view.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
      view.leadingAnchor.constraint(equalTo: imgButton.trailingAnchor, constant: 10),
      view.heightAnchor.constraint(equalToConstant: height),
      view.widthAnchor.constraint(equalToConstant: width)
    ])
    
    imgButton.layer.cornerRadius = (contentView.frame.width / 2) / 2
    
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}

