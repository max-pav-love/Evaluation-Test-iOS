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
    private let networkManager = NetworkManager()
    private let storageManager = StorageManager()
    
    // MARK: - Business Logic
    
    func fetchAlbums(request: AlbumsList.Albums.Request) {
        storageManager.addRequest(request: request.album)
        networkManager.fetchAlbumsData(for: request.album) { [weak self] albums in
            guard let albums = albums else {
                return
            }
            self?.albumsResults = albums.results.sorted(by: { $0.collectionName < $1.collectionName })
            let response = AlbumsList.Albums.Response(albums: self?.albumsResults ?? [], request: request.album)
            self?.presenter?.presentAlbums(response: response)
        }
    }
    
}
