//
//  ViewController.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit

class MainVC: UIViewController {

  //MARK: - Properties
  let mainTableView = UITableView()
  var laundryData = LaundryData()
  
  
  //MARK: - Init
  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .systemBackground
    
    title = "My Clothe"
    
    configureTableView()
  }
  
  //MARK: - TableView Configure
  fileprivate func configureTableView() {
    mainTableView.frame = view.frame
    
    mainTableView.register(ClotheInfoCustomCell.self, forCellReuseIdentifier:ClotheInfoCustomCell.identifier)
    mainTableView.register(PlusClotheCell.self, forCellReuseIdentifier:PlusClotheCell.identifier)
    
    mainTableView.rowHeight = 200
    
    mainTableView.delegate = self
    mainTableView.dataSource = self
    
    view.addSubview(mainTableView)
  }

}

//MARK: - UITableVeiwDataSource, UITalbeViewDelegate
extension MainVC: UITableViewDataSource, UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return laundryData.clotheName.count + 1
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    if indexPath.row < laundryData.clotheName.count {
      let clotheCell = mainTableView.dequeueReusableCell(withIdentifier: ClotheInfoCustomCell.identifier, for: indexPath) as! ClotheInfoCustomCell
      cell = clotheCell
    } else {
      let plusCell = mainTableView.dequeueReusableCell(withIdentifier: PlusClotheCell.identifier, for: indexPath) as! PlusClotheCell
      
      cell = plusCell
    }
    
    return cell
  }
  
  // 사용자가 옷을 신규로 등록 or 등록한 옷에 대한 디테일 뷰 이동
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    let addClotheVC = AddClotheVC()
    addClotheVC.laundryData = laundryData
    
    // 신등록인 경우 ture , 기등록인 경우 false
    addClotheVC.newClothe = (tableView.cellForRow(at: indexPath) as? ClotheInfoCustomCell) == nil ? true : false
    addClotheVC.userSelectIndex = indexPath.row
    navigationController?.pushViewController(addClotheVC, animated: true)
  }
}


