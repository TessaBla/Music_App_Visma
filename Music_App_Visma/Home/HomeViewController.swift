//
//  HomeViewController.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import Foundation
import UIKit

class HomeViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout, CategoryDelegate, StorageDelegate, PassStorageData {
    
    @IBOutlet weak var homeListCollectionView: UICollectionView!
    var songsList = [AllSongsModel]()
    var selectedCaegory: AllSongsModel?
    var selectedStorage: SavedMemory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        homeListCollectionView.delegate = self
        homeListCollectionView.dataSource = self
        
      //  homeListCollectionView.scrollIndicatorInsets = UIEdgeInsets(top: 0,left: 0,bottom: 0,right: -10);
                
        self.navigationController?.navigationBar.prefersLargeTitles = true
        initDataModel()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "seeMoreSegue" {
            guard let destinationVieCntroler = segue.destination as? FullCategoryTableViewControlle else {
                fatalError("Cant find class Named FullCategoryTableViewControlle")
            }
            destinationVieCntroler.initData(data: selectedCaegory!)
        } else if segue.identifier == "seeStorageSege" {
            guard let destinationVieCntroler = segue.destination as? FullStorageTableViewController else {
                fatalError("Cant find class Named FullStorageTableViewController")
            }
            destinationVieCntroler.delegate = self
            let fullData = MemoryModel(memoryType: selectedStorage!, allSongs: songsList)
            destinationVieCntroler.initData(data: fullData)
        }

    }
    
    func didSelectCategory(category: AllSongsModel) {
        selectedCaegory = category
        performSegue(withIdentifier: "seeMoreSegue", sender: nil)
    }
    
    func didSelectStorage(data: SavedMemory) {
        selectedStorage = data
        performSegue(withIdentifier: "seeStorageSege", sender: nil)
    }
    
    func passBackStorageData(data: [AllSongsModel]) {
        ///Grazina i storagev pakeista info
        songsList = data
        homeListCollectionView.reloadData()
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return songsList.count + 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.row < songsList.count {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVcategoryCell", for: indexPath) as? CategoryCollectionViewCell else {
                fatalError("Cell with identifier CVcategoryCell not found")
            }
            cell.delegate = self
            cell.initData(data: songsList[indexPath.row])
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CVstorageCell", for: indexPath) as? StorageCollectionViewCell else {
                fatalError("Cell with identifier CVstorageCell not found")
            }
            cell.initData(data: songsList)
            cell.delegate = self
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.row < songsList.count {
            return CGSize(width: collectionView.frame.width, height: collectionView.frame.width * 0.7)
        } else {
            return CGSize(width: collectionView.frame.width, height: 160)
        }
    }
}

extension HomeViewController {
    func initDataModel(){
        let dataDictionary = [["keyCategory" : "Rock",
                              "keySongArray" : [["keyArtistName": "Queen",
                                                 "keySongName":"Bohemian Rhapsody",
                                                 "keySongTime":"05:05",
                                                 "keySongSize": "10mb",
                                                 "keySongIsSaved": [SavedMemory.memory],
                                                 "keySongImage": UIImage(named: "queen")!],
                                                ["keyArtistName": "AC/DC",
                                                "keySongName":"Back In Black",
                                                "keySongTime":"3:25",
                                                "keySongSize": "6mb",
                                                 "keySongIsSaved": [SavedMemory.fileSystem],
                                                "keySongImage": UIImage(named: "acdc")!],
                                                ["keyArtistName": "Elvis Presley",
                                                "keySongName":"Jailhouse Rock",
                                                "keySongTime":"01:25",
                                                "keySongSize": "5mb",
                                                 "keySongIsSaved": [SavedMemory.memory, SavedMemory.fileSystem],
                                                "keySongImage": UIImage(named: "ElvisPresley")!],
                                                ["keyArtistName": "Guns N' Roses",
                                                "keySongName":" Sweet Child O' Mine",
                                                "keySongTime":"3:25",
                                                "keySongSize": "5mb",
                                                 "keySongIsSaved": [SavedMemory.notSaved],
                                                "keySongImage": UIImage(named: "GunsNRoses")!],
                                                ["keyArtistName": "Nirvana",
                                                "keySongName":"Smells Like Teen Spirit",
                                                "keySongTime":"3:25",
                                                "keySongSize": "5mb",
                                                 "keySongIsSaved": [SavedMemory.notSaved],
                                                "keySongImage": UIImage(named: "Nirvana")!],
                                                ["keyArtistName": "Eagles",
                                                "keySongName":"Hotel California",
                                                "keySongTime":"3:25",
                                                "keySongSize": "5mb",
                                                 "keySongIsSaved": [SavedMemory.notSaved],
                                                "keySongImage": UIImage(named: "Eagles")!],
                                                ["keyArtistName": "Metallica",
                                                "keySongName":"Enter Sandman",
                                                "keySongTime":"3:25",
                                                "keySongSize": "5mb",
                                                 "keySongIsSaved": [SavedMemory.notSaved],
                                                "keySongImage": UIImage(named: "Metallica")!]]],
                              ["keyCategory" : "Pop",
                                                    "keySongArray" : [["keyArtistName": "Beyoncé",
                                                                       "keySongName":"Single Ladies",
                                                                       "keySongTime":"3:25",
                                                                       "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                       "keySongImage": UIImage(named: "Beyonce")!],
                                                                      ["keyArtistName": "Rihanna ",
                                                                      "keySongName":"Umbrella",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "Rihanna")!],
                                                                      ["keyArtistName": "Taylor Swift",
                                                                      "keySongName":"Shake it Off",
                                                                      "keySongTime":"3:25s",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "TaylorSwift")!],
                                                                      ["keyArtistName": "Britney Spears",
                                                                      "keySongName":"Toxic",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "BritneySpears")!],
                                                                      ["keyArtistName": "Katy Perry",
                                                                      "keySongName":"Firework",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "KatyPerry")!],
                                                                      ["keyArtistName": "The Weeknd",
                                                                      "keySongName":"Blinding Lights",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "TheWeeknd")!],
                                                                      ["keyArtistName": "Outkast",
                                                                      "keySongName":"Hey Ya!",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "Outkast")!]]],
                              ["keyCategory" : "Techno",
                                                    "keySongArray" : [["keyArtistName": "TurboKevin",
                                                                       "keySongName":"CHASE THE SUN",
                                                                       "keySongTime":"3:25",
                                                                       "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                       "keySongImage": UIImage(named: "TurboKevin")!],
                                                                      ["keyArtistName": "TAZI",
                                                                      "keySongName":"Heater",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "TAZI")!],
                                                                      ["keyArtistName": "Girl In Red",
                                                                      "keySongName":"I Wanna Be Your Girlfriend",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "GirlInRed")!],
                                                                      ["keyArtistName": "Resonance",
                                                                      "keySongName":"Give Me Some More",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "Resonance")!],
                                                                      ["keyArtistName": "VLC",
                                                                      "keySongName":"90's Feeling",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "VLC")!],
                                                                      ["keyArtistName": "SHOUSE",
                                                                      "keySongName":"Love Tonight",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "SHOUSE")!],
                                                                      ["keyArtistName": "Stan Christ",
                                                                      "keySongName":"Trepidation",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "StanChrist")!]]],
                              ["keyCategory" : "Rap",
                                                    "keySongArray" : [["keyArtistName": "Dr. Dre feat. Snoop Doggy Dogg",
                                                                       "keySongName":"Nuthin’ But a ‘G’ Thang",
                                                                       "keySongTime":"3:25",
                                                                       "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                       "keySongImage": UIImage(named: "dogg")!],
                                                                      ["keyArtistName": "Run-DMC",
                                                                      "keySongName":"Sucker M.C.’s",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "Run-DMC")!],
                                                                      ["keyArtistName": "Public Enemy",
                                                                      "keySongName":"Fight the Power",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "PublicEnemy")!],
                                                                      ["keyArtistName": "2Pac",
                                                                      "keySongName":"Dear Mama",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "2Pac")!],
                                                                      ["keyArtistName": "50 Cent",
                                                                      "keySongName":"In Da Club",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "50Cent")!],
                                                                      ["keyArtistName": "Eminem",
                                                                      "keySongName":"Lose Yourself",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "Eminem")!],
                                                                      ["keyArtistName": "Kanye West",
                                                                      "keySongName":"Jesus Walks",
                                                                      "keySongTime":"3:25",
                                                                      "keySongSize": "5mb",
                                                                       "keySongIsSaved": [SavedMemory.notSaved],
                                                                      "keySongImage": UIImage(named: "KanyeWest")!]]]]
        
        for item in dataDictionary {
            songsList.append(AllSongsModel.init(dictionary: item))
        }
    }
}
