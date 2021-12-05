//
//  AlbumsListModels.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

enum AlbumsList {
    enum Albums {
        struct Request {
            let album: String
        }
        struct Response {
            let albums: [AlbumResults]
            let request: String
        }
        struct ViewModel {
            struct DisplayedAlbums {
                let artistName: String
                let albumName: String
                let artworkUrl: URL?
                let numberOfTracks: Int
                let country: String
                let copyright: String
                let releaseDate: String
                let genre: String
            }
            let displayedAlbums: [DisplayedAlbums]
            let request: String
        }
    }
}
