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
    @IBOutlet weak var busanSoxLabel: UILabel!
    
    @IBOutlet weak var popUpUIView: UIView!
    @IBOutlet weak var percentBackUIView1: UIView!
    @IBOutlet weak var percentUIView1: UIView!
    @IBOutlet weak var percentBackUIView2: UIView!
    @IBOutlet weak var percentUIView2: UIView!
    
    
    @IBOutlet weak var xBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        set()
        setTarget()
        showAnimate()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if( self.busansox! <= 30 ) {
            percentUIView1.frame.size.width = CGFloat( ( Double( self.busansox! ) * Double( self.percentBackUIView1.frame.size.width ) ) / 30 )
        } else {
            
            let tmpSox = self.busansox! - 30
            
            percentUIView1.frame.size.width = self.percentBackUIView1.frame.size.width
            percentUIView2.frame.size.width = CGFloat( ( Double( tmpSox ) * Double( self.percentBackUIView2.frame.size.width ) ) / 30 )
            
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        let touch : UITouch? = touches.first
        
        if touch?.view != popUpUIView {
            
            self.view.removeFromSuperview()
        }
    }
    
    func set() {
        
        self.view.backgroundColor = UIColor.black.withAlphaComponent( 0.6 )
        
        popUpUIView.layer.cornerRadius = 10 * self.view.frame.width / 375
        popUpUIView.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner , .layerMinXMinYCorner , .layerMaxXMinYCorner ]
        
        percentBackUIView1.layer.cornerRadius = ( percentBackUIView1.frame.height / 2 ) * self.view.frame.width / 375
        percentBackUIView1.layer.maskedCorners = [.layerMinXMaxYCorner , .layerMinXMinYCorner ]
        
        percentBackUIView1.layer.borderWidth = 1
        percentBackUIView1.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        percentBackUIView1.alpha = 0.47
        
        percentBackUIView2.layer.cornerRadius = ( percentBackUIView2.frame.height / 2 ) * self.view.frame.width / 375
        percentBackUIView2.layer.maskedCorners = [.layerMaxXMaxYCorner , .layerMaxXMinYCorner ]
        
        percentBackUIView2.layer.borderWidth = 1
        percentBackUIView2.layer.borderColor = #colorLiteral(red: 0.768627451, green: 0.768627451, blue: 0.768627451, alpha: 1)
        percentBackUIView2.alpha = 0.47

        percentUIView1.layer.cornerRadius = ( percentUIView1.frame.height / 2 ) * self.view.frame.width / 375
        percentUIView1.layer.maskedCorners = [.layerMinXMaxYCorner , .layerMinXMinYCorner ]
        
        busanSoxLabel.text = "\(gino(busansox)) ppm"
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
