//
//  CompanyInfoTableViewCell.swift
//  Please_Sunshine_iOS
//
//  Created by 박현호 on 19/11/2018.
//  Copyright © 2018 박현호. All rights reserved.
//

import UIKit

class CompanyInfoTableViewCell: UITableViewCell {

    @IBOutlet weak var typeLabel: UILabel!
    @IBOutlet weak var typeInfoLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
