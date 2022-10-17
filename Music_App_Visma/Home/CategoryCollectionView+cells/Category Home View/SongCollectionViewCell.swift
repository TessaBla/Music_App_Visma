//
//  SongCollectionViewCell.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import UIKit

class SongCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var songTitleLabel: UILabel!
    @IBOutlet weak var artistLabel: UILabel!
    @IBOutlet weak var sizeLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    
    var songData: SongModel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setUpShadowForImageView()
    }
    
    func initData(data: SongModel){
        songData = data
        
        songTitleLabel.text = songData.songName
        artistLabel.text = songData.artistName
        sizeLabel.text = songData.size
        timeLabel.text = songData.time
        imageView.image = songData.image
    }
    
    override func prepareForReuse() {
        imageView.image = nil
    }
    
    
    func setUpShadowForImageView() {
                
//        imageView.layer.shadowColor = UIColor.gray.cgColor
//        imageView.layer.shadowOffset = CGSize(width: 0.0, height: 3.0)
//        imageView.layer.shadowRadius = 8
//        imageView.layer.shadowOpacity = 0.5
//        imageView.layer.masksToBounds = false
    }

}
