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
            var album: String
        }
        struct Response {
            var albums: [AlbumsResults]
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
            var displayedAlbums: [DisplayedAlbums]
        }
    }
}
