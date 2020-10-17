//
//  AddClotheVC.swift
//  WorkspaceSettings.xcsettings  FabricCareSymbols
//
//  Created by 김광수 on 2020/06/19.
//  Copyright © 2020 김광수. All rights reserved.
//

import UIKit
import Foundation

class AddClotheVC: UIViewController {
  
  //MARK: - Passed Properties
  
  // 이전 화면에서 받아오는 값들 didselectRowAt
  var userSelectIndex:Int?
  var newClothe:Bool?
  var laundryData: LaundryData?
  
  //MARK: - Using Properties
  
  let tableView = UITableView()
  let headerView = ClotheInfoCustomCell()
  
  var userClothName:String = ""
  var userSelectLabelData:[String] = []
  
  lazy var imagePicker: UIImagePickerController = {
    let imagePicker = UIImagePickerController()
    imagePicker.delegate = self
    return imagePicker
  }()
  
  // MARK:- viewDidLoad
  override func viewDidLoad() {
    super.viewDidLoad()
    buttonAction()
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
    tableView.delegate = self
    tableView.frame = view.frame
    
    tableView.register(PlusClotheCell.self, forCellReuseIdentifier: PlusClotheCell.identifier)
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "CellId")
    
    headerView.imgButton.addTarget(self, action: #selector(selectImg(_:)), for: .touchUpInside)
    tableView.tableHeaderView = headerView
    headerView.frame = CGRect(x: 0, y: 0, width: view.frame.width, height: 200)
    
    view.addSubview(tableView)
  }
  
  func buttonAction() {
    navigationItem.leftBarButtonItem = UIBarButtonItem(title: "취소", style: .plain, target: self, action: #selector(cancelButton(_:)))
  }
  
  @objc func cancelButton(_ sender: UIBarButtonItem) {
//    let data = laundryData?.saveUSerLabelData(index: userSelectIndex!, labelList: userSelectLabelData)
    userSelectLabelData.remove(at: userSelectIndex!)
    navigationController?.popViewController(animated: true)
  }
  
  func inLabelView() {
    guard let laundry = laundryData?.labelName else { return }
    let label = laundry.flatMap { $0 }
    if label.isEmpty == false {
      print("viewLoadStart not empty")
      var imgArray: [UIView] = []
      for i in label {
        let imgView = UIImageView()
        imgView.image = UIImage(named: "\(i)")
        imgArray.append(imgView)
      }
      let stackView = UIStackView(arrangedSubviews: imgArray)
      stackView.distribution = .fillEqually
      stackView.axis = .horizontal
      stackView.spacing = 0
      headerView.view.addSubview(stackView)
      stackView.frame = CGRect(x: 0, y: 0, width: headerView.view.frame.width, height: headerView.view.frame.height)
    } else {
      print("viewLoadStart empty")
      let label = UILabel()
      label.text = "라벨을 추가해 주세요."
      label.backgroundColor = .systemGray5
      label.textAlignment = .center
      headerView.view.addSubview(label)
      label.translatesAutoresizingMaskIntoConstraints = false
      NSLayoutConstraint.activate([
        label.topAnchor.constraint(equalTo: headerView.view.topAnchor),
        label.bottomAnchor.constraint(equalTo: headerView.view.bottomAnchor),
        label.leadingAnchor.constraint(equalTo: headerView.view.leadingAnchor),
        label.trailingAnchor.constraint(equalTo: headerView.view.trailingAnchor)
      ])
    }
  }
  // MARK:- viewWillAppear
  override func viewWillAppear(_ animated: Bool) {
    super.viewWillAppear(animated)
    inLabelView()

    guard let userSelectIndex = userSelectIndex,
      let laundryData = laundryData else { return }
    print("dataADD from \(userSelectIndex)")
    userSelectLabelData = laundryData.fetchUserLabelData(index: userSelectIndex)
    print(userSelectLabelData)
    tableView.reloadData()
  }

  func fetchUserData() {
    guard let userSelectIndex = userSelectIndex,
      let laundryData = laundryData else { return }
    userSelectLabelData = laundryData.fetchUserLabelData(index: userSelectIndex)
    userClothName = laundryData.clotheName[userSelectIndex]
  }
  
  @objc func selectImg(_ sender: UIButton) {
    let alert = UIAlertController(title: nil, message: "사진을 선택하세요.", preferredStyle: .actionSheet)
    let camera = UIAlertAction(title: "Camera", style: .default) { (UIAlertAction) in
      guard UIImagePickerController.isSourceTypeAvailable(.camera) else { return }
      self.imagePicker.sourceType = .camera
      let mediaTypes = UIImagePickerController.availableMediaTypes(for: .camera)
      
      // kUTTypeVideo - 영상
      // kUTTypeMovie - 영상 + 소리
      
      self.imagePicker.mediaTypes = mediaTypes ?? []
      self.imagePicker.mediaTypes = ["public.image"]
      //            self.imagePicker.mediaTypes = [kUTTypeImage] as [String]
      
      if UIImagePickerController.isFlashAvailable(for: .rear) {
        self.imagePicker.cameraFlashMode = .auto
      }
      self.present(self.imagePicker, animated: true)
    }
    
    let album = UIAlertAction(title: "Album", style: .default) { (UIAlertAction) in
      self.imagePicker.sourceType = .savedPhotosAlbum
      self.present(self.imagePicker, animated: true)
    }
    let cancel = UIAlertAction(title: "Cancel", style: .cancel) { (_) in
      
    }
    alert.addAction(camera)
    alert.addAction(album)
    alert.addAction(cancel)
    return present(alert, animated: true)
  }
}


//MARK: - UITableVeiwDataSource
extension AddClotheVC: UITableViewDataSource {
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return userSelectLabelData.count + 1
  }
  
  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Label"
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    var cell = UITableViewCell()
    tableView.rowHeight = 180
    if indexPath.row < userSelectLabelData.count {
      let userClothCell = UITableViewCell(style: .subtitle, reuseIdentifier: "CellId")
      
      let clothName = userSelectLabelData[indexPath.row]
      
      userClothCell.textLabel?.text = clothName
      userClothCell.detailTextLabel?.text = laundryData?.getProductDetailInfo(labelName: clothName)
      userClothCell.imageView?.image = UIImage(named: clothName)
      
      cell = userClothCell
      
    } else if userSelectLabelData.count == 0 {
      print("plus-1")
      let plusCell = tableView.dequeueReusableCell(withIdentifier: PlusClotheCell.identifier, for: indexPath) as! PlusClotheCell
      cell = plusCell
    }
    
    return cell
  }
}

extension AddClotheVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
    let originImage = info[.originalImage] as! UIImage
    let selectImage = originImage
    
    guard let imageData = selectImage.jpegData(compressionQuality: 0.1) else { return }
    
    if headerView.imgButton == nil {
      laundryData?.imageName.append(imageData)
    } else {
//      laundryData?.imageName[userSelectIndex!] = imageData
    }
    
    headerView.imgButton.setImage(selectImage, for: .normal)
    headerView.imgButton.imageView?.layer.cornerRadius = headerView.imgButton.frame.width / 2
    
    dismiss(animated: true)
  }
}

//MARK: - UITableVeiwDelegate
extension AddClotheVC: UITableViewDelegate {
  
  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    
    let selectLabelVC = NewSelectLabelVC()
    selectLabelVC.laundryData = self.laundryData
    selectLabelVC.userSelectIndex = self.userSelectIndex
    navigationController?.pushViewController(selectLabelVC, animated: true)
  }
}




