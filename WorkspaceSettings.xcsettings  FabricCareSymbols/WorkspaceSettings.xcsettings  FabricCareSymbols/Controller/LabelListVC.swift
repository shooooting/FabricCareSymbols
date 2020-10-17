//
//  LabelListVC.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class LabelListVC: UIViewController  {
  
  //MARK: - Properties
  let tableView = UITableView()
  let laundryData = LaundryData()
  var dataList:[String] = []
  
  fileprivate func extractedFunc() {
    tableView.frame = CGRect(x: 0, y: 0, width: view.frame.size.width, height: view.frame.size.height)
    tableView.rowHeight = 120
    tableView.dataSource = self
    tableView.delegate = self
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "Lundry Label List"
    view.backgroundColor = .white
    
    fetchData()
    extractedFunc()
  
    view.addSubview(tableView)
  }
  
  func fetchData() {
    for category in laundryData.labelCategoryData {
      for labelString in laundryData.labelData[category]!.keys {
        dataList.append(labelString)
      }
    }
  }
}

extension LabelListVC: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    let category = laundryData.labelCategoryData[section]
    return laundryData.labelData[category]!.keys.sorted().count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellId")
//    let cell = tableView.dequeueReusableCell(withIdentifier: "CellId", for: indexPath)
    let category = laundryData.labelCategoryData[indexPath.section]
    let labelName = laundryData.labelData[category]!.keys.sorted()[indexPath.row]
    cell.imageView?.image = UIImage(named: labelName)
    cell.textLabel?.text = labelName
    cell.detailTextLabel?.text = laundryData.getProductDetailInfo(labelName: labelName)
    return cell
  }
  
  
  func numberOfSections(in tableView: UITableView) -> Int {
    return laundryData.labelCategoryData.count
   }
  
}

extension LabelListVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
    let headerView = UILabel()
    headerView.text = laundryData.labelCategoryData[section]
    headerView.textColor = .white
    headerView.font = .boldSystemFont(ofSize: 20)
    headerView.backgroundColor = UIColor(red: 17/255, green: 154/255, blue: 237/255, alpha: 1)
    return headerView
  }
  
  func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
    return 40
  }
  
  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    return 120
  }
}
