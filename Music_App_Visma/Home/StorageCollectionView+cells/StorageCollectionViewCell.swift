//
//  StorageCollectionViewCell.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import UIKit

protocol StorageDelegate {
    func didSelectStorage(data: SavedMemory)
}

class StorageCollectionViewCell: UICollectionViewCell, UITableViewDelegate, UITableViewDataSource {

    
    @IBOutlet weak var homeStorageTableView: UITableView!
    var delegate: StorageDelegate?
    var allSongs: [AllSongsModel]!
    
    var allTimeMemoryLabel = "0:00"
    var allTimeFilesystemLabel = "0:00"
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        homeStorageTableView.delegate = self
        homeStorageTableView.dataSource = self
    }
    
    func initData(data: [AllSongsModel]){
        allSongs = data
        countStorageTime()
    }
    
    func countStorageTime(){
        allTimeMemoryLabel = "0:00"
        allTimeFilesystemLabel = "0:00"
        
        for category in allSongs {
            for song in category.songInfo {
                for saved in song.saved {
                    if saved == SavedMemory.fileSystem {
                        allTimeFilesystemLabel = addTime(timeStr: song.time, toTimeStr: allTimeFilesystemLabel)
                    } else if saved == SavedMemory.memory {
                        allTimeMemoryLabel = addTime(timeStr: song.time, toTimeStr: allTimeMemoryLabel)
                    }
                }
            }
        }
        homeStorageTableView.reloadData()
    }
    

    func addTime(timeStr: String, toTimeStr: String) -> String {
        let values = timeStr.components(separatedBy: ":")
        let addTo = toTimeStr.components(separatedBy: ":")

        let minAdd = Int(values[0])!
        let secAdd = Int(values[1])!
        
        let minTo = Int(addTo[0])!
        let secTo = Int(addTo[1])!
        
        var answerSec = secTo + secAdd
        var answerMins = minTo + minAdd
        
        if answerSec > 60 {
            answerSec = answerSec - 60
            answerMins = answerMins + 1
        }
        
        let answer = "\(answerMins):\(answerSec)"
        return answer
    }
    
    
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
       return "Storage"
    }
//    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let vw = UIView()
//        return vw
//    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        var passData:SavedMemory?
        
        if indexPath.row == 0 {
            passData = SavedMemory.memory
        } else {
            passData = SavedMemory.fileSystem
        }
        delegate?.didSelectStorage(data: passData!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "StorageCellHome", for: indexPath) as? StorageTableViewCell else {
            fatalError("Cell with identifier CThomeSongCell not found")
        }
        
        if indexPath.row == 0 {
            cell.storageLabel.text = SavedMemory.memory.rawValue
            cell.allMinsLabel.text = allTimeMemoryLabel
            
        } else {
            cell.storageLabel.text = SavedMemory.fileSystem.rawValue
            cell.allMinsLabel.text = allTimeFilesystemLabel
        }
        return cell
    }
}
