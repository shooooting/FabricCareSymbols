//
//  SelectLabel.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class SelectLabelVC: UIViewController {
  
  //MARK: - Passed Properties
  var laundryData: LaundryData?
  var userSelectIndex:Int? {
    didSet {
      guard let userSelectIndex = userSelectIndex,
        let laundryData = laundryData else { return }
        userSelectLabelData = laundryData.fetchUserLabelData(index: userSelectIndex)
      print(userSelectLabelData)
    }
  }
  
  //MARK: - Local Properties
  var userSelectLabelData:[String] = []
  
  var padding: CGFloat = 10
  
  var labelHeight:CGFloat = 0
  var stackHeight:CGFloat = 0
  
  var oneButtonArray:[UIButton] = []
  var twoButtonArray:[UIButton] = []
  var threeButtonArray:[UIButton] = []
  var fourbuttonArray:[UIButton] = []
  var fivebuttonArray:[UIButton] = []
  
  var oneStackView = UIStackView()
  var twoStackView = UIStackView()
  var threetackView = UIStackView()
  var fourStackView = UIStackView()
  var fiveStackView = UIStackView()
  
  var labelArray:[UILabel] = []
  
  lazy var buttonArrayArray = [oneButtonArray,twoButtonArray,threeButtonArray,fourbuttonArray,fivebuttonArray]
  
  lazy var stackViewArray:[UIStackView] = [oneStackView,twoStackView,threetackView,fourStackView,fiveStackView]
  
  
  //MARK: - init
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    
    
    configureNavigation()
    
    // 버튼 및 라벨 생성
    makeProperties()
    
    // 생성된 프로퍼티 오토 레이아웃 적용
    makeAutoLayout()
  }
  
  //MARK: - Configure
  fileprivate func configureNavigation() {
    navigationItem.title = "라벨을 선택하세요"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tabCompleteButton(_:)))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tabCompleteButton(_:)))
  }
  
  //MARK: - Make Properties
  // 버튼 및 라벨 생성
  func makeProperties() {
    guard let laundryData = laundryData else { return }
    for count in 0..<laundryData.labelCategoryData.count {
      //라벨 만들기 이름
      let topLabel = laundryData.labelCategoryData[count]
      print(topLabel)
      labelArray.append(makeLabel(topLabel))
      
      guard (laundryData.labelData[topLabel]?.count) != nil else { return }
      let temp = laundryData.labelData[topLabel]!.keys.sorted()
      for labelString in temp {
        guard let button = makeButton(labelString) else { return }
        buttonArrayArray[count].append(button)
      }
    }
  }
  
  //MARK: - AutoLayout
  // 오토 레이아웃
  func makeAutoLayout() {
    let window = UIApplication.shared.windows[0]
    let topPadding = window.safeAreaInsets.top
    let bottomPadding = window.safeAreaInsets.bottom
    
    labelHeight = (window.frame.size.height-topPadding-bottomPadding)/5/10*1.8
    stackHeight = (window.frame.size.height-topPadding-bottomPadding)/5/10*6.7
    
    //최종 스택 뷰를 위한 Array
    var viewArray:[UIView] = []
    for i in 0..<5 {
      stackViewArray[i] = UIStackView(arrangedSubviews: buttonArrayArray[i])
      stackViewArray[i].distribution = .fillEqually
      stackViewArray[i].axis = .horizontal
      stackViewArray[i].spacing = 10
      let stackViewHeightConstraint = NSLayoutConstraint(item: stackViewArray[i], attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: stackHeight)
      
      stackViewArray[i].addConstraints([stackViewHeightConstraint])
      
      //라벨, 버튼 스택 뷰 추가
      viewArray.append(labelArray[i])
      viewArray.append(stackViewArray[i])
      
      let imageViewHeightConstraint = NSLayoutConstraint(item: labelArray[i], attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: labelHeight)
      
      labelArray[i].addConstraints([imageViewHeightConstraint])
    }
    
    let newStackview = UIStackView(arrangedSubviews: viewArray)
    newStackview.distribution = .fillProportionally
    newStackview.axis = .vertical
    newStackview.spacing = 0
    
    view.addSubview(newStackview)
    
    newStackview.translatesAutoresizingMaskIntoConstraints = false
    NSLayoutConstraint.activate([
      newStackview.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
      newStackview.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor),
      newStackview.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
      newStackview.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor)
    ])
  }
  
  //MARK: - Action
  
  // 버튼 생성 함수
  func makeButton(_ buttonName:String) -> UIButton? {
    let bt = UIButton()
    bt.setTitle(buttonName, for: .normal)
    bt.setImage(UIImage(named: buttonName), for: .normal)
    bt.setImage(UIImage(named: "\(buttonName)_sel"), for: .selected)
    
    bt.isSelected = userSelectLabelData.contains(buttonName) ? true : false
    
    bt.addTarget(self, action: #selector(tabeButtonAction), for: .touchUpInside)
    return bt
  }
  // 라벨 생성 함수
  func makeLabel(_ labelName:String) -> UILabel {
    let tl = UILabel()
    tl.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    tl.text = labelName
    tl.textAlignment = .justified
    tl.font = .boldSystemFont(ofSize: 20)
    tl.textColor = .white
    return tl
  }
  //MARK: - Button Action
  @objc func tabCompleteButton(_ sender:UIBarButtonItem) {
    guard let buttonTitle = sender.title,
     let laundryData = laundryData,
    let userSelectIndex = userSelectIndex else { return }
    if buttonTitle == "완료" {
      laundryData.saveUSerLabelData(index: userSelectIndex, labelList: userSelectLabelData)
    }
    navigationController?.popViewController(animated: true)
  }
  
  @objc func tabeButtonAction(_ sender:UIButton) {
    // 사용자가 선택한 라벨 저장
    guard let selectLabelName = sender.currentTitle else { return }
    if !userSelectLabelData.contains(selectLabelName) {
      // 배열에 없는 경우 추가
      userSelectLabelData.append(selectLabelName)
      
    } else {
      // 이미 포함된 경우
      if let deleteLabelIndex = userSelectLabelData.firstIndex(of: selectLabelName) {
        userSelectLabelData.remove(at: deleteLabelIndex)
      }
    }
    print(userSelectLabelData)
    sender.isSelected.toggle()
  }
}
