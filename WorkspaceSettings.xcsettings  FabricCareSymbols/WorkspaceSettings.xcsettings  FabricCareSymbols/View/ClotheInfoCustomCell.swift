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
  let imgView: UIImageView = {
    let img = UIImageView()
    img.frame = CGRect(x: 0, y: 0, width: 150, height: 150)
    img.layer.cornerRadius = img.frame.width / 2
    img.layer.masksToBounds = true
    return img
  }()
  
  let label: UILabel = {
    let label = UILabel()
    label.textAlignment = .center
    label.layer.borderWidth = 2
    label.layer.borderColor = CGColor(srgbRed: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    label.layer.cornerRadius = 7
    return label
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    contentView.addSubview(imgView)
    contentView.addSubview(label)
    
    imgView.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      imgView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 5),
      imgView.topAnchor.constraint(greaterThanOrEqualTo: contentView.topAnchor, constant: 25),
      imgView.heightAnchor.constraint(equalToConstant: 150),
      imgView.widthAnchor.constraint(equalToConstant: 150)
    ])
    
    label.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      label.leadingAnchor.constraint(equalTo: imgView.trailingAnchor, constant: 10),
      label.trailingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 360),
      label.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 75),
      label.heightAnchor.constraint(equalToConstant: 50),
      label.widthAnchor.constraint(equalToConstant: 200)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
