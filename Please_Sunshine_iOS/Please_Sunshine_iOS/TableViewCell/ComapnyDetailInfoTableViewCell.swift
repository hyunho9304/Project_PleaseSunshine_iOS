//
//  ComapnyDetailInfoTableViewCell.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 19/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import UIKit

class ComapnyDetailInfoTableViewCell: UITableViewCell {
    
    @IBOutlet weak var circleUIView1: UIView!
    @IBOutlet weak var circleUIView2: UIView!
    @IBOutlet weak var circleUIView3: UIView!
    @IBOutlet weak var circleUIView4: UIView!
    @IBOutlet weak var circleUIView5: UIView!
    

    @IBOutlet weak var panelNameLabel: UILabel!
    @IBOutlet weak var installPriceLabel: UILabel!
    @IBOutlet weak var supportPriceLabel: UILabel!
    @IBOutlet weak var actualPriceLabel: UILabel!
    @IBOutlet weak var panelSizeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        var circleUIViewList : [ UIView ] = [ self.circleUIView1 , self.circleUIView2 , self.circleUIView3 , self.circleUIView4 , self.circleUIView5 ]
        
        for i in 0 ..< 5 {
            
            circleUIViewList[i].layer.cornerRadius = circleUIViewList[i].layer.frame.width/2.0
            circleUIViewList[i].clipsToBounds = true
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
