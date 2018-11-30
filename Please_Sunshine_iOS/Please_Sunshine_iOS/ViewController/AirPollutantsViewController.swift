//
//  AirPollutantsViewController.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 30/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import UIKit

class AirPollutantsViewController: UIViewController {

    var busansox : Int?
    @IBOutlet weak var popUpUIView: UIView!
    
    
    @IBOutlet weak var xBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        setTarget()
        showAnimate()
    }
    
    func set() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent( 0.6 )
        
        popUpUIView.layer.cornerRadius = 10 * self.view.frame.width / 375
        popUpUIView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner , .layerMinXMinYCorner , .layerMaxXMinYCorner ]
    }
    
    func setTarget() {
        
        xBtn.addTarget(self, action: #selector(self.pressedXBtn(_:)), for: UIControl.Event.touchUpInside)
    }
    
    func showAnimate() {
        
        self.view.transform = CGAffineTransform( scaleX: 1.3 , y: 1.3 )
        self.view.alpha = 0.0
        UIView.animate(withDuration: 0.18) {
            self.view.alpha = 1.0
            self.view.transform = CGAffineTransform( scaleX: 1.0 , y: 1.0 )
        }
    }
    
    @objc func pressedXBtn( _ sender : UIButton ) {
        
        self.view.removeFromSuperview()
    }
}
