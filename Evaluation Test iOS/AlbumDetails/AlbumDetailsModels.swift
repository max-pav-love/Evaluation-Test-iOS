//
//  AlbumDetailsModels.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

enum AlbumDetails {
    enum Album {
        struct Request {
        }
        struct Response {
            var album: AlbumResults
            var tracks: [TracksResult]
        }
        struct ViewModel {
            struct DisplayedAlbum {
                let artistName: String
                let albumName: String
                let artworkUrl: URL?
                let numberOfTracks: Int
                let country: String
                let copyright: String
                let releaseDate: String
                let genre: String
            }
            struct DisplayedTrack {
                let trackName: String
                let trackArtist: String
                let trackLenght: String
            }
            var displayedAlbum: DisplayedAlbum
            var dispalayedTracks: [DisplayedTrack]
        }
    }
}
