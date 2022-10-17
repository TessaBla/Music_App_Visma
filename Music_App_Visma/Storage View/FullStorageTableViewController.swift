//
//  FullStorageTableViewController.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import UIKit

protocol PassStorageData {
    func passBackStorageData(data: [AllSongsModel])
}

class FullStorageTableViewController: UITableViewController {

    var selectedIndexPath: Int?
    var memoryType: SavedMemory?
    var allSongsData: [AllSongsModel]!
    var delegate: PassStorageData?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    func initData(data: MemoryModel){
        title = data.memoryType.rawValue
        memoryType = data.memoryType
        allSongsData = data.allSongs
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        if self.isMovingFromParent {
            delegate?.passBackStorageData(data: allSongsData)
        }
    }
    
    func savedEditCell(cellInfo: SongModel) -> SongModel{
        
        var notSaved = false
        var cellData = cellInfo
        if memoryType == SavedMemory.fileSystem {
            var savedToFileSystem = false

            for saved in cellData.saved {
                if saved == SavedMemory.notSaved {
                    notSaved = true
                } else if saved == SavedMemory.fileSystem {
                    savedToFileSystem = true
                }
            }
            
            if notSaved {
                cellData.saved.removeAll()
                cellData.saved.append(SavedMemory.fileSystem)
            }
            
            if !savedToFileSystem && !notSaved {
                cellData.saved.append(SavedMemory.fileSystem)
            }
                        
        } else if memoryType == SavedMemory.memory {
            var savedToMemory = false
            for saved in cellData.saved {
                if saved == SavedMemory.notSaved {
                    notSaved = true
                } else if saved == SavedMemory.memory{
                    savedToMemory = true
                }
            }
            
            if notSaved {
                cellData.saved.removeAll()
                cellData.saved.append(SavedMemory.memory)
            }
            
            if !savedToMemory && !notSaved {
                cellData.saved.append(SavedMemory.memory)
            }
        }
        
        return cellData
    }
    
    func unsavedEditCell(cellInfo: SongModel) -> SongModel {
        var cellData = cellInfo
        var removeAt = 0

        for i in 0..<cellData.saved.count {
            if cellData.saved[i] == memoryType {
                removeAt = i
            }
        }
            
        cellData.saved.remove(at: removeAt)
        
        if cellData.saved.count == 0 {
            cellData.saved.append(SavedMemory.notSaved)
        }
        
        return cellData
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return allSongsData.count
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection
                                section: Int) -> String? {
        return allSongsData[section].category
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allSongsData[section].songInfo.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TVStorageSongCel", for: indexPath) as? StorageSongTableViewCell else {
            fatalError("Cell with identifier TVStorageSongCel not found")
        }
        
        let cellData = allSongsData[indexPath.section].songInfo[indexPath.row]
        
        if memoryType == SavedMemory.fileSystem {
            for saved in cellData.saved {
                if saved == SavedMemory.fileSystem {
                    cell.songSaveImage.image = UIImage(systemName: "checkmark.circle")
                    break
                } else {
                    cell.songSaveImage.image = UIImage(systemName: "arrow.down.to.line.circle.fill")
                }
            }
        } else if memoryType == SavedMemory.memory {
            for saved in cellData.saved {
                if saved == SavedMemory.memory {
                    cell.songSaveImage.image = UIImage(systemName: "checkmark.circle")
                    break
                } else {
                    cell.songSaveImage.image = UIImage(systemName: "arrow.down.to.line.circle.fill")
                }
            }
        } else {
            cell.songSaveImage.image = UIImage(systemName: "arrow.down.to.line.circle.fill")
        }

        cell.initData(data: cellData)
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        selectedIndexPath = indexPath.row
        var cellData = allSongsData[indexPath.section].songInfo[indexPath.row]

        var memoryTypeExistsForSaving = false
        
        for saved in cellData.saved {
            if saved == memoryType {
                memoryTypeExistsForSaving = true
            }
        }
        
        if !memoryTypeExistsForSaving {
            cellData = savedEditCell(cellInfo: cellData)
        } else {
            cellData = unsavedEditCell(cellInfo: cellData)
        }
        
        allSongsData[indexPath.section].songInfo[indexPath.row] = cellData
        tableView.reloadRows(at: [indexPath], with: .fade)
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 40
    }

}
