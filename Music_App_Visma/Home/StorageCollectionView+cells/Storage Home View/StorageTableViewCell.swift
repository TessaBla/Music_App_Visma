//
//  StorageTableViewCell.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import UIKit

class StorageTableViewCell: UITableViewCell {

    @IBOutlet weak var storageLabel: UILabel!
    @IBOutlet weak var allMinsLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
