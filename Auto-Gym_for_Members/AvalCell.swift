//
//  AvalCell.swift
//  Auto-Gym_for_Members
//
//  Created by Marcio R. Rosemberg on 25/01/19.
//  Copyright © 2019 Marcio R. Rosemberg. All rights reserved.
//

import UIKit

class AvalCell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var leftLabel: UILabel!
    @IBOutlet weak var centerLabel: UILabel!
    @IBOutlet weak var rightLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
