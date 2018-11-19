//
//  CompanyListViewController.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 19/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import UIKit

class CompanyListViewController: UIViewController , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout , UITableViewDelegate , UITableViewDataSource {

    
    let userdefault = UserDefaults.standard
    
    @IBOutlet weak var alarmBtn: UIButton!
    @IBOutlet weak var alarmLabel: UILabel!
    @IBOutlet weak var bubbleUIView: UIView!
    
    @IBOutlet weak var companyListCollectionView: UICollectionView!

    @IBOutlet weak var companyInfoTableView: UITableView!
    @IBOutlet weak var showCompanyNameLabel: UILabel!
    
    @IBOutlet weak var companyDetailInfoTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        setDelegate()
        setTarget()
    }
    
    func set() {
        
        let flag = userdefault.integer(forKey: "alarm" )
        
        if( flag == 1 ) {
            self.alarmBtn.setImage( #imageLiteral(resourceName: "alarmOff"), for: .normal)
            alarmLabel.text = "다시 보려면 버튼을 눌러주세요"
            bubbleUIView.isHidden = true
        } else {
            self.alarmBtn.setImage( #imageLiteral(resourceName: "alarmOn"), for: .normal)
            alarmLabel.text = "300W 초과 발전기는 부산시에서 보조금이 지원되지 않습니다."
            bubbleUIView.isHidden = false
        }
    }
    
    func setDelegate() {
        
        companyListCollectionView.delegate = self
        companyListCollectionView.dataSource = self
        
        companyInfoTableView.delegate = self
        companyInfoTableView.dataSource = self
        companyInfoTableView.rowHeight = 30

        companyDetailInfoTableView.delegate = self
        companyDetailInfoTableView.dataSource = self
        companyDetailInfoTableView.rowHeight = 123

        
    }
    
    func setTarget() {
        
        //  알림 끄기 버튼 클릭
        alarmBtn.addTarget(self, action: #selector(self.pressedAlarmBtn(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func pressedAlarmBtn( _ sender: UIButton ) {
        
        if( alarmBtn.image(for: .normal) == #imageLiteral(resourceName: "alarmOn") ) {
            
            userdefault.set( 1 , forKey: "alarm")
            
            alarmBtn.setImage( #imageLiteral(resourceName: "alarmOff") , for: .normal )
            alarmLabel.text = "다시 보려면 버튼을 눌러주세요"
            bubbleUIView.isHidden = true
            
        } else {
            
            userdefault.set( 0 , forKey: "alarm")
            
            alarmBtn.setImage( #imageLiteral(resourceName: "alarmOn") , for: .normal )
            alarmLabel.text = "300W 초과 발전기는 부산시에서 보조금이 지원되지 않습니다."
            bubbleUIView.isHidden = false
        }
    }
    
    
    
//  Mark -> CollectionView delegate
    
    //  cell 의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return 3
    }
    
    //  cell 의 내용
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyListCollectionViewCell", for: indexPath ) as! CompanyListCollectionViewCell
        
        return cell
    }
    
    //  cell 선택 했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
    }
    
    //  cell 크기 비율
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 160 * self.view.frame.width/375 , height: 204 * self.view.frame.height/667 )
    }
    
    //  cell 간 가로 간격 ( horizental 이라서 가로를 사용해야 한다 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    
    
//  Mark -> TableView delegate
    
    //  cell 개수( delegate & datasource )
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    //  cell 별로 나타낼 개수( delegate & datasource )
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if( tableView == companyInfoTableView ) {
            return 4
        } else {
            return 3
        }
    }
    
    //  cell 안의 내용( delegate & datasource )
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if( tableView == companyInfoTableView ) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell") as! CompanyInfoTableViewCell
            
            if( indexPath.row == 0 ) {
                cell.typeLabel.text = "모듈 제조사"
            } else if( indexPath.row == 1 ) {
                cell.typeLabel.text = "인버터 제조사"
            } else if( indexPath.row == 2 ) {
                cell.typeLabel.text = "전화번호"
            } else {
                cell.typeLabel.text = "홈페이지 주소"
            }
            
            cell.typeInfoLabel.text = "서버데이터"
            
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComapnyDetailInfoTableViewCell") as! ComapnyDetailInfoTableViewCell
            
    
            
            cell.panelNameLabel.text = "서버데이터"
            cell.installPriceLabel.text = "서버데이터"
            cell.supportPriceLabel.text = "서버데이터"
            cell.actualPriceLabel.text = "서버데이터"
            cell.panelSizeLabel.text = "서버데이터"
            
            return cell
        }
    }
    
    //  cell 클릭했을시 다음 view 로 넘어가게 하는 코드 like push
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
