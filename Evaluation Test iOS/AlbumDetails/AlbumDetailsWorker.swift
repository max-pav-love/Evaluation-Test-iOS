//
//  AlbumDetailsWorker.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class AlbumDetailsWorker {
    
    func prepareDisplayedAlbumTracks(for tracks: [TracksResult?]) -> [AlbumDetails.Album.ViewModel.DisplayedTrack?] {
        
        var displayedTracks = [AlbumDetails.Album.ViewModel.DisplayedTrack?]()
        
        tracks.forEach { track in
//            let trackLenght = track.trackTimeMillis
//            let trackArtist = track.artistName
            let trackName = track?.trackName
            
            let track = AlbumDetails.Album.ViewModel.DisplayedTrack(trackName: trackName ?? "")
            displayedTracks.append(track)
        }
        return displayedTracks
    }
    
}
