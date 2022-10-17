//
//  Model.swift
//  Music_App_Visma
//
//  Created by Terese on 2022-10-13.
//

import Foundation
import UIKit

struct MemoryModel {
    var memoryType: SavedMemory
    var allSongs: [AllSongsModel]
}

enum SavedMemory: String {
    case memory = "Memory"
    case fileSystem = "Filesystem"
    case notSaved
}

struct AllSongsModel {
    var category: String
    var songInfo: [SongModel]
    
    init(dictionary : [String:Any]) {
        category = dictionary["keyCategory"] as? String ?? "Undfined"
        let songData = dictionary["keySongArray"] as! [[String:Any]]
        songInfo = songData.map(SongModel.init)
    }
}

struct SongModel {
    var artistName: String
    var songName: String
    var time: String
    var size: String
    var image: UIImage
    var saved: [SavedMemory]
    
    init(dictionary : [String:Any]) {
        artistName = dictionary["keyArtistName"] as? String ?? "Undefined"
        songName = dictionary["keySongName"] as? String ?? "Undefined"
        time = dictionary["keySongTime"] as? String ?? "Undefined"
        size = dictionary["keySongSize"] as? String ?? "Undefined"
        image = dictionary["keySongImage"] as? UIImage ?? UIImage()
        saved = dictionary["keySongIsSaved"] as? [SavedMemory] ?? [SavedMemory.notSaved]
    }
}


