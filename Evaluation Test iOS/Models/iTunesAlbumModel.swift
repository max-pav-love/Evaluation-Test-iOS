//
//  iTunesAlbumsModel.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import Foundation

struct Albums: Decodable {
    let results: [AlbumsResults]
}

struct AlbumsResults: Decodable {
    let artistName: String
    let collectionName: String
    let artworkUrl100: URL?
    let trackCount: Int
    let copyright: String
    let country: String
    let releaseDate: String
    let primaryGenreName: String
}
