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
    var companyList : [ CompanyList ] = [ CompanyList ]()
    var companySelectedIndex:IndexPath?
    var selectComapnyIndex : Int?
    var selectCompanySite : String?
    var selectCompanyPhoneNum : String?

    @IBOutlet weak var companyInfoTableView: UITableView!
    @IBOutlet weak var showCompanyNameLabel: UILabel!
    @IBOutlet weak var siteBtn: UIButton!
    @IBOutlet weak var callBtn: UIButton!
    
    @IBOutlet weak var companyDetailInfoTableView: UITableView!
    var companyInfo : CompanyInfo?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        setDelegate()
        setTarget()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        companyListInit()
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
        
        //  사이트 오픈 버튼 클릭
        siteBtn.addTarget(self, action: #selector(self.pressedSiteBtn(_:)), for: UIControl.Event.touchUpInside)
        
        //  전호걸기 버튼 클릭
        callBtn.addTarget(self, action: #selector(self.pressedCallBtn(_:)), for: UIControl.Event.touchUpInside)
    }
    
    //  업체 리스트 서버 통신
    func companyListInit() {
        
        Server.reqCompanyList { ( companyListData , rescode) in

            if( rescode == 200 ) {

                self.companyList = companyListData
                self.companyListCollectionView.reloadData()

                let indexPathForFirstRow = IndexPath(row: 0, section: 0)
                self.collectionView( self.companyListCollectionView, didSelectItemAt: indexPathForFirstRow )

            }else {

                let alert = UIAlertController(title: "서버", message: "통신상태를 확인해주세요", preferredStyle: .alert )
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil )
                alert.addAction( ok )
                self.present(alert , animated: true , completion: nil)
            }
        }
    }
    
    //  선택한 업체 디테일 서버 통신
    func companyDetailInit() {
        
        Server.reqCompanyDetail(c_id: self.selectComapnyIndex! ) { ( companyDetailData , rescode ) in
            
            if( rescode == 200 ) {
                
                self.companyInfo = companyDetailData
                
                if( self.companyInfo?.c_site == "-" ) {
                    self.siteBtn.isHidden = true
                } else {
                    self.siteBtn.isHidden = false
                }
                
                self.companyInfoTableView.reloadData()
                self.companyDetailInfoTableView.reloadData()
            } else {
                
                let alert = UIAlertController(title: "서버", message: "통신상태를 확인해주세요", preferredStyle: .alert )
                let ok = UIAlertAction(title: "확인", style: .default, handler: nil )
                alert.addAction( ok )
                self.present(alert , animated: true , completion: nil)
            }
        }
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
    
    @objc func pressedSiteBtn( _ sender : UIButton ) {
        
        UIApplication.shared.open( URL(string: self.selectCompanySite! )! , options: [:], completionHandler: nil )
    }
    
    @objc func pressedCallBtn( _ sender : UIButton ) {
        
        UIApplication.shared.open( URL(string: "tel://\(gsno(self.selectCompanyPhoneNum))" )! , options: [:], completionHandler: nil )
    }
    
//  Mark -> CollectionView delegate
    
    //  cell 의 개수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return companyList.count
    }
    
    //  cell 의 내용
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CompanyListCollectionViewCell", for: indexPath ) as! CompanyListCollectionViewCell
        
        cell.companyInfoLabel1.text = self.companyList[ indexPath.row ].c_summaryInfo1
        cell.companyInfoLabel2.text = self.companyList[ indexPath.row ].c_summaryInfo2
        cell.companyInfoLabel3.text = self.companyList[ indexPath.row ].c_summaryInfo3
        cell.companyNameLabel.text = self.companyList[ indexPath.row ].c_name
        
        if( indexPath == companySelectedIndex ) {
            
            cell.companyInfoImageView.image = #imageLiteral(resourceName: "listCirlce1")
            cell.companyInfoLabel1.alpha = 1
            cell.companyInfoLabel2.alpha = 1
            cell.companyInfoLabel3.alpha = 1
            cell.companyNameLabel.alpha = 1
            
            self.selectComapnyIndex = self.companyList[ indexPath.row ].c_id
            self.showCompanyNameLabel.text = self.companyList[ indexPath.row ].c_name

            companyDetailInit()
            
        } else {
            
            cell.companyInfoImageView.image = #imageLiteral(resourceName: "listCirlce")
            cell.companyInfoLabel1.alpha = 0.5
            cell.companyInfoLabel2.alpha = 0.5
            cell.companyInfoLabel3.alpha = 0.5
            cell.companyNameLabel.alpha = 0.5
        }
        
        return cell
    }
    
    //  cell 선택 했을 때
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        companySelectedIndex = indexPath
        collectionView.reloadData()
    }
    
    //  cell 크기 비율
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 160 * self.view.frame.width/375 , height: 204 * self.view.frame.height/667 )
    }
    
    //  cell 간 가로 간격 ( horizental 이라서 가로를 사용해야 한다 )
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        
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
            return companyInfo?.detail?.count ?? 0
        }
    }
    
    //  cell 안의 내용( delegate & datasource )
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if( tableView == companyInfoTableView ) {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "CompanyInfoTableViewCell") as! CompanyInfoTableViewCell

            if( indexPath.row == 0 ) {
                cell.typeLabel.text = "모듈 제조사"
                cell.typeInfoLabel.text = self.companyInfo?.c_module
            } else if( indexPath.row == 1 ) {
                cell.typeLabel.text = "인버터 제조사"
                cell.typeInfoLabel.text = self.companyInfo?.c_inverter
            } else if( indexPath.row == 2 ) {
                cell.typeLabel.text = "전화번호"
                cell.typeInfoLabel.text = self.companyInfo?.c_phoneNum
                self.selectCompanyPhoneNum = self.companyInfo?.c_phoneNum
            } else {
                cell.typeLabel.text = "홈페이지 주소"
                cell.typeInfoLabel.text = self.companyInfo?.c_site
                self.selectCompanySite = self.companyInfo?.c_site
            }
        
            return cell
            
        } else {
            
            let cell = tableView.dequeueReusableCell(withIdentifier: "ComapnyDetailInfoTableViewCell") as! ComapnyDetailInfoTableViewCell
            
            cell.panelNameLabel.text = "\(gino(self.companyInfo?.detail![ indexPath.row ].pi_watt ))W \(gsno(self.companyInfo?.detail![ indexPath.row ].pi_type))"
            
            cell.installPriceLabel.text = self.companyInfo?.detail![ indexPath.row ].pi_installPrice
            cell.supportPriceLabel.text = self.companyInfo?.detail![ indexPath.row ].pi_supportPrice
            cell.actualPriceLabel.text = self.companyInfo?.detail![ indexPath.row ].pi_actualPrice
            cell.panelSizeLabel.text = self.companyInfo?.detail![ indexPath.row ].pi_size
            
            return cell
        }
    }
    
    //  선택하면 넘어감
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
}
