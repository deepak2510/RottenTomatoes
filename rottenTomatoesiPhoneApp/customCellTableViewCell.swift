//
//  customCellTableViewCell.swift
//  rottenTomatoesiPhoneApp
//
//  Created by Bhagchandani, Deepak on 9/24/14.
//  Copyright (c) 2014 Bhagchandani, Deepak. All rights reserved.
//

import UIKit

class customCellTableViewCell: UITableViewCell {

    @IBOutlet weak var customDescription: UILabel!
    @IBOutlet weak var customTitle: UILabel!
    @IBOutlet weak var customImageView: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
       
   
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
  
    

}


