//
//  FirstViewController.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 30/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var firstBtn: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setTarget()

    }
    
    func setTarget() {
        
        firstBtn.addTarget(self, action: #selector(self.pressedFirstBtn(_:)), for: UIControl.Event.touchUpInside)
    }
    
    @objc func pressedFirstBtn( _ sender : UIButton ) {
        
        guard let airPollutantsVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AirPollutantsViewController") as? AirPollutantsViewController else { return }
        
        airPollutantsVC.busansox = 40
        
        self.addChild( airPollutantsVC )
        airPollutantsVC.view.frame = self.view.frame
        self.view.addSubview( airPollutantsVC.view )
        airPollutantsVC.didMove(toParent: self )
    }

}
