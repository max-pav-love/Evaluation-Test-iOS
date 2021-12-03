//
//  AlbumsListInteractor.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

protocol AlbumsListBusinessLogic {
    func fetchAlbums(request: AlbumsList.Albums.Request)
}

protocol AlbumsListDataStore {
    var albumsResults: [AlbumResults] { get }
}

class AlbumsListInteractor: AlbumsListBusinessLogic, AlbumsListDataStore {
    
    var albumsResults: [AlbumResults] = []
    
    var presenter: AlbumsListPresentationLogic?
    var worker: AlbumsListWorker?
    private let networkManager = NetworkManager()
    
    // MARK: - Business Logic
    
    func fetchAlbums(request: AlbumsList.Albums.Request) {
        networkManager.fetchAlbumsData(for: request.album) { [weak self] albums in
            guard let albums = albums else {
                return
            }
            self?.albumsResults = albums.results
            let response = AlbumsList.Albums.Response(albums: self?.albumsResults ?? [])
            self?.presenter?.presentAlbums(response: response)
        }
    }
    
}
