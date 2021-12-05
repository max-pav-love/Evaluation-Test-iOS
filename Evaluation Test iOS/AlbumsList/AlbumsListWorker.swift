//
//  AlbumsListWorker.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

class AlbumsListWorker {
    
    func prepareDisplayedAlbums(from albums: [AlbumResults]) -> [AlbumsList
                                                                .Albums
                                                                .ViewModel
                                                                .DisplayedAlbums] {
        var displayedAlbums = [AlbumsList
                                .Albums
                                .ViewModel
                                .DisplayedAlbums]()        
        albums.forEach { album in
            let artistName = album.artistName
            let albumName = album.collectionName
            let artworkUrl = album.artworkUrl100
            let numberOfTracks = album.trackCount
            let country = album.country
            let copyright = album.copyright
            let releaseDate = album.releaseDate
            let genre = album.primaryGenreName
            
            let album = AlbumsList
                .Albums
                .ViewModel
                .DisplayedAlbums(artistName: artistName,
                                 albumName: albumName,
                                 artworkUrl: artworkUrl,
                                 numberOfTracks: numberOfTracks,
                                 country: country,
                                 copyright: copyright ?? "",
                                 releaseDate: releaseDate,
                                 genre: genre)
            displayedAlbums.append(album)
        }
        return displayedAlbums
    }
    
}
