//
//  NewSelectLabelVC.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/21.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class NewSelectLabelVC: UIViewController {
  
  //MARK: - Passed Properties
  var laundryData: LaundryData?
  var userSelectIndex:Int?
  
  
  //MARK: - Local Properties
  var tableView = UITableView()
  var sectionTitle:[String] = []
  var labelData:[[String]] = []
  var userSelectLabel:[String] = []     // 사용자가 선택한 라벨 데이터
  var tempUserSelectLabel:[String] = [] // 사용자가 SelectLabel 화면에서 선택한 데이터
  
  lazy var titleHeight:CGFloat = view.frame.height/5/5
  lazy var cellHeigh:CGFloat = view.frame.height/5/5*3
  
  fileprivate func configureNavBar() {
    navigationItem.title = "라벨을 선택하세요"
    navigationItem.rightBarButtonItem = UIBarButtonItem(title: "완료", style: .plain, target: self, action: #selector(tabCompleteButton(_:)))
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(tabCompleteButton(_:)))
  }
  
  //MARK: - Init
  fileprivate func configureTableView() {
    // configure TableView
    tableView.frame = view.frame
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(SelectLabelCell.self, forCellReuseIdentifier: SelectLabelCell.identifier)
    
    view.addSubview(tableView)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    
    view.backgroundColor = .blue
    
    // User seleced Label data Load
    fetchData()

    // configure navbar
    configureNavBar()
    
    
    // configure TableView
    configureTableView()
    
  }
  
  
  //MARK: - API
  
  //tabbar 엑션 처리
  @objc func tabCompleteButton(_ sender:UIBarButtonItem) {
    
    guard let buttonTitle = sender.title,
          let userSelectIndex = userSelectIndex else { return }
    if buttonTitle == "완료" {
      laundryData?.saveUSerLabelData(index: userSelectIndex, labelList: tempUserSelectLabel)
    }
    navigationController?.popViewController(animated: true)
  }
  
  // 데이터 불러오기
  func fetchData() {
    guard let laundryData = laundryData,
          let userSelectIndex = userSelectIndex else { return }
    sectionTitle = laundryData.labelCategoryData
    userSelectLabel = laundryData.fetchUserLabelData(index: userSelectIndex)
    
    for keyString in sectionTitle {
      labelData.append(laundryData.fetchLabelArray(category: keyString))
    }
  }
}

//MARK: - UITableViewDataSource
extension NewSelectLabelVC: UITableViewDataSource {
  
  // secton configure
  func numberOfSections(in tableView: UITableView) -> Int {
    return sectionTitle.count
  }
  
  // cell configure
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: SelectLabelCell.identifier, for: indexPath) as! SelectLabelCell
    // 라벨데이터 전달
    cell.delegate = self
    cell.userSelctLabelArray = userSelectLabel
    cell.labelDataArray = labelData[indexPath.section]
    
    return cell
  }
}

//MARK: - UITableViewDelegate

extension NewSelectLabelVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return titleHeight
  }
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let label = UILabel()
    label.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    label.text = sectionTitle[section]
    label.font = .boldSystemFont(ofSize: 20)
    label.textColor = .white
    return label
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return cellHeigh
  }
  
}

//MARK: - Protocol

extension NewSelectLabelVC: SelectLabelDelegate {
  
  //사용자가 선택한 버튼 임시저장
  func tabLabelButtonDelegate(labelName name: String) {
    if tempUserSelectLabel.contains(name) {
      // 이미 선택한 버튼 삭제(체크 해제)
      guard let index = tempUserSelectLabel.firstIndex(of: name) else { return }
      tempUserSelectLabel.remove(at: index)
    } else {
      // 선택한 버튼 추가
      tempUserSelectLabel.append(name)
    }
  }
}
