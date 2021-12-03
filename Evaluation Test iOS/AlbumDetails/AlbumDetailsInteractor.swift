//
//  AlbumDetailsInteractor.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol AlbumDetailsBusinessLogic {
    func fetchAlbumDetails(request: AlbumDetails.Album.Request)
}

protocol AlbumDetailsDataStore {
    var album: AlbumResults? { get set }
    var albumTracksArray: [TracksResult] { get }
}

class AlbumDetailsInteractor: AlbumDetailsBusinessLogic, AlbumDetailsDataStore {
    
    var presenter: AlbumDetailsPresentationLogic?
    var album: AlbumResults?
    var albumTracksArray: [TracksResult] = []
    private let networkManager = NetworkManager()
    
    // MARK: - Business Logic
    
    func fetchAlbumDetails(request: AlbumDetails.Album.Request) {
        networkManager.fetchAlbumTracksData(for: album?.collectionId ?? 0) { [weak self] albumTracks  in
            guard let albumTracks = albumTracks else {
                return
            }
            self?.albumTracksArray = albumTracks.results
            let response = AlbumDetails.Album.Response(album: (self?.album)!, tracks: self?.albumTracksArray ?? [])
            self?.presenter?.presentAlbumDetails(response: response)
        }
    }
    
}
