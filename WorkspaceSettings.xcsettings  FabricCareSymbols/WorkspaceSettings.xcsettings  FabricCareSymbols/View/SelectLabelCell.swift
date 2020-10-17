//
//  SelectLabelCell.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SelectLabelCell: UITableViewCell {
  
  //MARK: - Passed Properties
  var labelDataArray:[String]? { // UI 구성
    didSet {
      guard let labelDataArray = labelDataArray else { print("data Error"); return }
      var buttonArray:[UIView] = []
        
      for labelName in labelDataArray {
          buttonArray.append(makeButton(labelName))
        }
        
        let stackView = UIStackView(arrangedSubviews: buttonArray)
        stackView.distribution = .fillEqually
        stackView.axis = .horizontal
        
        addSubview(stackView)
        stackView.frame = contentView.frame
    }
  }
  var userSelctLabelArray:[String]?  // 사용자가 기존에 선택한 라벨 정보
  var delegate:SelectLabelDelegate?
  
  //MARK: - Properties
  static let identifier = "SelectLabelCell"
  
  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
  
  }
  
  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
  
  func makeButton(_ buttonName:String) -> UIButton {
    let bt = UIButton()
    bt.setTitle(buttonName, for: .normal)
    bt.setImage(UIImage(named: buttonName), for: .normal)
    bt.setImage(UIImage(named: "\(buttonName)_sel"), for: .selected)
    bt.contentMode = .scaleToFill
    // 사용자가 선택했던 항목 다시 체크 적용
    if let userSelctLabel = userSelctLabelArray {
      if userSelctLabel.contains(buttonName) {
        bt.isSelected = true
        delegate?.tabLabelButtonDelegate(labelName: buttonName)
      }
    }
    bt.addTarget(self, action: #selector(tabeLabelButtonAction), for: .touchUpInside)
    return bt
  }
  
  // 버튼 액션 처리
  @objc func tabeLabelButtonAction(_ sender:UIButton) {
    guard let selectLabelName = sender.currentTitle else { return }
    delegate?.tabLabelButtonDelegate(labelName: selectLabelName)
    sender.isSelected.toggle()
  }
}
