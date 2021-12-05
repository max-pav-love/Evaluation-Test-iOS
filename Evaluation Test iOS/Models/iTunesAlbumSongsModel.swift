//
//  iTunesAlbumSongsModel.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 03.12.2021.
//

import Foundation

struct AlbumTracks: Codable {
    var results: [TracksResult]
}

struct TracksResult: Codable {
    let trackName: String?
    let artistName: String?
    let trackTimeMillis: Int?
}
