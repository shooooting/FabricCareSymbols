//
//  PlusClotheCell.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class PlusClotheCell: UITableViewCell {
  static var identifier = "PlucClotheCell"
  
  let plusImage: UIImageView = {
    let img = UIImageView(image: UIImage(named: "plus_photo-1"))
    return img
  }()
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    
    plusImage.center = contentView.center
//    plusImage.frame.size = CGSize(width: 120, height: 120)
    
    let width = contentView.frame.width / 2
    
    contentView.addSubview(plusImage)
    plusImage.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      plusImage.centerXAnchor.constraint(equalTo: contentView.centerXAnchor),
      plusImage.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
      plusImage.widthAnchor.constraint(equalToConstant: width),
      plusImage.heightAnchor.constraint(equalToConstant: width)
    ])
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
}
