//
//  AlbumDetailsWorker.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class AlbumDetailsWorker {
    
    func prepareDisplayedTracks(_ response: AlbumDetails.Album.Response) -> [AlbumDetails.Album.ViewModel.DisplayedTrack] {
        var songsArray = [AlbumDetails.Album.ViewModel.DisplayedTrack]()
        response.tracks.forEach { song in
            guard let trackName = song.trackName else {
                return
            }
            let trackArtist = song.artistName
            let trackLenght = printSecondsToHoursMinutesSeconds(song.trackTimeMillis ?? 0)
            
            let displayedTrack = AlbumDetails
                .Album
                .ViewModel
                .DisplayedTrack(trackName: trackName,
                                trackArtist: trackArtist ?? "",
                                trackLenght: trackLenght)
            songsArray.append(displayedTrack)
            songsArray = songsArray.sorted(by: { $0.trackName < $1.trackArtist })
        }
        return songsArray
    }
    
    func prepareDisplayedAlbumInfo(_ response: AlbumDetails.Album.Response) -> AlbumDetails.Album.ViewModel.DisplayedAlbum {
        let displayedAlbumDetails = AlbumDetails
            .Album
            .ViewModel
            .DisplayedAlbum(artistName: response.album.artistName,
                            albumName: response.album.collectionName,
                            artworkUrl: response.album.artworkUrl100,
                            numberOfTracks: response.album.trackCount,
                            country: response.album.country,
                            copyright: response.album.copyright ?? "",
                            releaseDate: formatDate(response.album.releaseDate),
                            genre: response.album.primaryGenreName)
        return displayedAlbumDetails
    }
    
    private func formatDate(_ string: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ssZZZ"
        guard let backendDate = formatter.date(from: string) else { return "" }
        let stringFormatter = DateFormatter()
        stringFormatter.dateFormat = "yyyy"
        let date = stringFormatter.string(from: backendDate)
        return date
    }
    
    private func secondsToMinutesSeconds(_ milliseconds: Int) -> (Int, Int) {
        let minutes = ((milliseconds / 1000) / 60)
        let seconds = ((milliseconds / 1000) % 60)
        return (minutes, seconds)
    }
    
    private func printSecondsToHoursMinutesSeconds(_ milliseconds: Int) -> String {
        let (m, s) = secondsToMinutesSeconds(milliseconds)
        if s.digitCount == 1 {
            return ("\(m):0\(s)")
        } else {
            return ("\(m):\(s)")
        }
    }
    
}
