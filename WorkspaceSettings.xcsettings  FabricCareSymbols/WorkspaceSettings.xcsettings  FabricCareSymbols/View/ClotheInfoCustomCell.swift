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

    let imgButton: UIButton = {
        let imgButton = UIButton()
        imgButton.backgroundColor = .systemGray2
        imgButton.setImage(UIImage(named: "plus_photo"), for: .normal)
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
        view.backgroundColor = .systemGreen
        return view
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let width: CGFloat = contentView.frame.width / 2 - 10
        let ui = [imgButton, textField, view]
        ui.forEach { contentView.addSubview($0) }
        ui.forEach { $0.translatesAutoresizingMaskIntoConstraints = false }
        
        imgButton.layer.cornerRadius = width / 2

        NSLayoutConstraint.activate([
            imgButton.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 10),
            imgButton.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 20),
            imgButton.widthAnchor.constraint(equalToConstant: width),
            imgButton.heightAnchor.constraint(equalToConstant: width)
        ])
        
        NSLayoutConstraint.activate([
            textField.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            textField.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 50),
            textField.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            textField.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
        
        NSLayoutConstraint.activate([
            view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -10),
            view.topAnchor.constraint(equalTo: textField.bottomAnchor, constant: 20),
            view.heightAnchor.constraint(equalTo: contentView.heightAnchor, multiplier: 0.2),
            view.widthAnchor.constraint(equalTo: contentView.widthAnchor, multiplier: 0.5)
        ])
        

    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

