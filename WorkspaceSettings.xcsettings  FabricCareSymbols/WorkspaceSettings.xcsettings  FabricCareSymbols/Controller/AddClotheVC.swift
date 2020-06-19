//
//  AddClotheVC.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Foundation

class AddClotheVC: UIViewController  {
  
  //MARK: - Passed Properties
  
  // 이전 화면에서 받아오는 값들 didselectRowAt
  var userSelectIndex:Int?
  var newClothe:Bool?
  var laundryData: LaundryData?

  
  //MARK: - Using Properties
  
  let tableView = UITableView()
  
  var userClothName:String = ""
  var userSelectLabelData:[String] = []
  
  
  //MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    
    view.backgroundColor = .systemBackground
    
    guard let newClothe = newClothe else {return}
    
    if newClothe {
      // 신규 등록인 경우
      print("new Clothe")
      title = "Add Clothe"
      
    } else {
      // 기존 등록된 옷을 선택한 경우
      print("Not new Clothe")
      title = "<clothename>"
      fetchUserData()
    }
    

    //talbeView Configure
    tableView.dataSource = self
    tableView.frame = view.frame
    
    tableView.register(PlusClotheCell.self, forCellReuseIdentifier: PlusClotheCell.identifier)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    
    let headerView = ClotheInfoCustomCell()
    
    tableView.tableHeaderView = headerView
    headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
    tableView.rowHeight = 120
    view.addSubview(tableView)
    
  }
  
  func fetchUserData() {
    guard let userSelectIndex = userSelectIndex,
          let laundryData = laundryData else { return }
    userSelectLabelData = laundryData.fetchUserLabelData(index: userSelectIndex)
    userClothName = laundryData.clotheName[userSelectIndex]
  }
  
}

extension AddClotheVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userSelectLabelData.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    
    if indexPath.row < userSelectLabelData.count {
      let userClothCell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellId")
      
      let clothName = userSelectLabelData[indexPath.row]
      
      userClothCell.textLabel?.text = clothName
      userClothCell.detailTextLabel?.text = laundryData?.getProductDetailInfo(labelName: clothName)
      userClothCell.imageView?.image = UIImage(named: clothName)
      
      cell = userClothCell

    } else if userSelectLabelData.count == 0 {
      print("plus")
      let plusCell = tableView.dequeueReusableCell(withIdentifier: PlusClotheCell.identifier, for: indexPath) as! PlusClotheCell
      cell = plusCell
    }
    
    return cell
  }
}
