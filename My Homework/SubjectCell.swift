//
//  SubjectCell.swift
//  My Homework
//
//  Created by Manas Ashwin on 27/07/18.
//  Copyright © 2018 Manas Producers. All rights reserved.
//

import UIKit
import SwipeCellKit

class SubjectCell: SwipeTableViewCell {

    @IBOutlet weak var subjectLabel : UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
