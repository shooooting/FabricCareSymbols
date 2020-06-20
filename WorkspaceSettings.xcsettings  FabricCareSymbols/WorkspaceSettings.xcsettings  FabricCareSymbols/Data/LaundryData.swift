//
//  LaundryData.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/18.
//  Copyright © 2020 김광수. All rights reserved.
//

import Foundation

class LaundryData {
  
  var labelCategoryData:[String] = ["물세탁 부호","산소 염색 표백 부호","다림질 부호","드라이클리닝 부호","건조 부호"]
  
  var labelData:[String:[String:String]] =
    ["물세탁 부호":
      ["30도 손세탁 중성":"30도 중성 물에 손세탁 필요",
       "약 40도 물세탁":"30도 물에 물세탁 가능",
       "40도 물세탁":"40도 물에 물세탁 가능",
       "60도 물세탁":"60도 물에 물세탁 가능",
       "95도 물세탁":"95도 물에 물세탁 가능"],
     "산소 염색 표백 부호":
      ["산소 염소 표백 불가":"산소 염소 표백 불가",
       "산소 표백 가능":"산소 표백 가능",
       "산소 표백 불가":"산소 표백 불가",
       "염소 표백 가능":"염소 표백 가능",
       "염소 표백 불가":"염소 표백 불가"],
     "다림질 부호":
      ["180 다리미 가능":"180도 다리미 가능",
       "180 헝겁 다리미 가능":"헝겁을 덮고 180도 다리미 가능",
       "140 다리미 가능":"140도 다리미 가능",
       "80 헝겁 다리미 가능":"헝겁을 덮고 80도 다리미 가능",
       "다리미 불가":"다림질 불가능"],
     "드라이클리닝 부호":
      ["드라이 가능 셀프 불가":"드라이클리닝 할 수 있으나, 셀프 서비스는 할수 없음(전문점만)",
       "드라이 가능":"드라이클리닝 가능",
       "드라이 불가":"드라이클리닝 불가능",
       "석유계 드라이 가능":"드라이크리닝 할 수 있음. 단, 용제의 종류는 머클로에틸렌 또는 석유계"],
     "건조 부호":
      ["햇빛 옷걸이 건조":"옷걸이에 걸어서 햇빛에 건조",
       "햇빛 뉘어서 건조":"옷을 뉘어서 햇빛에 건조",
       "그늘 옷걸이 건조":"옷걸이에 걸어서 그늘에 건조",
       "건조기 가능":"건조기 사용 가능",
       "건조기 불가능":"건조기 사용 불가능"]]

  
  //MARK: - User Select Data
  var clotheName:[String] = []  // 옷 이름
  var imageName:[Data] = []     // 이미지 데이터
  var labelName:[[String]] = [[]] // 라벨 데이터
  
  
  //MARK: - API
  
  func fetchUserLabelData(index number:Int) -> [String] {
    return labelName[number] != [] ? labelName[number] : []
  }
  
  func saveUSerLabelData(index number:Int, labelList labelArray:[String]) {
    labelName[number] = labelArray
  }
  
  
  
  func getProductDetailInfo(labelName:String) -> String {
    for category in labelCategoryData {
      let dataKeys = labelData[category]!.keys
      let detailData = labelData[category]
      for labelString in dataKeys {
        if labelString == labelName {
          return detailData![labelName]!
        }
      }
    }
    return "000"
  }
}


class imageSingleton {
  static var imageList = imageSingleton()
  var imageList:[Data] = []
}


