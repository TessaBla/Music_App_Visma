//
//  CategoryCollectionViewCell.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import UIKit

protocol CategoryDelegate {
    func didSelectCategory(category: AllSongsModel)
}

class CategoryCollectionViewCell: UICollectionViewCell, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout  {
    
    @IBOutlet weak var homeSongListCollectionView: UICollectionView!
    @IBOutlet weak var categoryNameLabel: UILabel!
    @IBOutlet weak var seeMoreButton: UIButton!
    
    var categoryData: AllSongsModel!
    var delegate: CategoryDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeSongListCollectionView.delegate = self
        homeSongListCollectionView.dataSource = self
        
        homeSongListCollectionView.register(UINib(nibName: "SongCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: "CVhomeSongCell")
    }
    

    func initData(data: AllSongsModel) {
        categoryData = data
        
        categoryNameLabel.text = categoryData?.category
    }
    
    @IBAction func seeMoreTap(_ sender: Any) {
        delegate?.didSelectCategory(category: categoryData)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return categoryData.songInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVhomeSongCell", for: indexPath) as? SongCollectionViewCell else {
            fatalError("Cell with identifier CVcategoryCell not found")
        }
        cell.initData(data: categoryData.songInfo[indexPath.row])
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: collectionView.frame.height * 0.7, height: collectionView.frame.height)
    }
    
    
}
