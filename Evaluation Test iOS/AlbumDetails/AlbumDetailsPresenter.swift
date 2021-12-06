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
    private var worker: AlbumDetailsWorker?
    
    // MARK: - PresentationLogic
    
    func presentAlbumDetails(response: AlbumDetails.Album.Response) {
        worker = AlbumDetailsWorker()
        guard
            let tracks = worker?.prepareDisplayedTracks(response),
            let info = worker?.prepareDisplayedAlbumInfo(response)
        else {
            return
        }
        let viewModel = AlbumDetails.Album.ViewModel(displayedAlbum: info, dispalayedTracks: tracks)
        viewController?.displayAlbumDetails(viewModel: viewModel)
    }
    
}
