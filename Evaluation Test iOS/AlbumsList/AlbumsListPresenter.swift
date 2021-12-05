//
//  AlbumsListPresenter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

protocol AlbumsListPresentationLogic {
    func presentAlbums(response: AlbumsList.Albums.Response)
}

class AlbumsListPresenter: AlbumsListPresentationLogic {
    
    weak var viewController: AlbumsListDisplayLogic?
    private var worker: AlbumsListWorker?
    
    // MARK: - PresentationLogic
    
    func presentAlbums(response: AlbumsList.Albums.Response) {
        worker = AlbumsListWorker()
        guard let displayedAlbums = worker?.prepareDisplayedAlbums(from: response.albums) else {
            return
        }
        let viewModel = AlbumsList.Albums.ViewModel(displayedAlbums: displayedAlbums, request: response.request)
        viewController?.displayAlbums(viewModel: viewModel)
    }
    
}
