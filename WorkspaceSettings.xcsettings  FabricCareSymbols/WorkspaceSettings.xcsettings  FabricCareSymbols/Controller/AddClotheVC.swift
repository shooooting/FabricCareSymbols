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

  
  //MARK: - Using VC Properties
  
  
  
  
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
      
    }
    
    
  }
}
