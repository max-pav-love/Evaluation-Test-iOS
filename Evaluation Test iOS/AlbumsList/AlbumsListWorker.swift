//
//  AlbumsListWorker.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

class AlbumsListWorker {
    
    func getDisplayedNews(from albums: [AlbumsResults]) -> [AlbumsList
                                                                .Albums
                                                                .ViewModel
                                                                .DisplayedAlbums] {
        var displayedAlbums = [AlbumsList
                                .Albums
                                .ViewModel
                                .DisplayedAlbums]()
        albums.forEach { albums in
            let artistName = albums.artistName
            let albumName = albums.collectionName
            let artworkUrl = albums.artworkUrl100
            let numberOfTracks = albums.trackCount
            let country = albums.country
            let copyright = albums.copyright
            let releaseDate = albums.releaseDate
            let genre = albums.primaryGenreName
            
            let album = AlbumsList
                .Albums
                .ViewModel
                .DisplayedAlbums(artistName: artistName,
                                 albumName: albumName,
                                 artworkUrl: artworkUrl,
                                 numberOfTracks: numberOfTracks,
                                 country: country,
                                 copyright: copyright,
                                 releaseDate: releaseDate,
                                 genre: genre)
            displayedAlbums.append(album)
        }
        return displayedAlbums
    }
    
}
