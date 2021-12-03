//
//  AlbumDetailsPresenter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol AlbumDetailsPresentationLogic {
    func presentAlbumDetails(response: AlbumDetails.Album.Response)
}

class AlbumDetailsPresenter: AlbumDetailsPresentationLogic {
    
    weak var viewController: AlbumDetailsDisplayLogic?
    
    // MARK: - PresentationLogic
    
    func presentAlbumDetails(response: AlbumDetails.Album.Response) {

        var songsArray = [AlbumDetails.Album.ViewModel.DisplayedTrack]()
        response.tracks.forEach { song in
            guard let song = song.trackName else { return }
            let songName = song
            let displayedTrack = AlbumDetails.Album.ViewModel.DisplayedTrack(trackName: songName)
            songsArray.append(displayedTrack)
        }
        
        let displayedAlbumDetails = AlbumDetails
            .Album
            .ViewModel
            .DisplayedAlbum(artistName: response.album.artistName,
                            albumName: response.album.collectionName,
                            artworkUrl: response.album.artworkUrl100,
                            numberOfTracks: response.album.trackCount,
                            country: response.album.country,
                            copyright: response.album.copyright,
                            releaseDate: response.album.releaseDate,
                            genre: response.album.primaryGenreName)
        let viewModel = AlbumDetails.Album.ViewModel(displayedAlbum: displayedAlbumDetails, dispalayedTracks: songsArray)
        viewController?.displayAlbumDetails(viewModel: viewModel)
    }
    
}
