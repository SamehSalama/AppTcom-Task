//
//  AthleteTableViewCell.swift
//  AppTcom Task
//
//  Created by Sameh Salama on 10/16/17.
//  Copyright © 2017 Da Blue Alien. All rights reserved.
//

import UIKit

class AthleteTableViewCell: UITableViewCell {

    @IBOutlet weak var athleteNameLabel: UILabel!
    @IBOutlet weak var athleteImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
