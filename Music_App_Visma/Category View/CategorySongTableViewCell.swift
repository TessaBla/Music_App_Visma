//
//  CategorySongTableViewCell.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import UIKit

class CategorySongTableViewCell: UITableViewCell {
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var songInfoLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func initData(data: SongModel) {
        songTitleLabel.text = "\(data.artistName) - \(data.songName)"
        songInfoLabel.text = "\(data.size) - \(data.time)"
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
