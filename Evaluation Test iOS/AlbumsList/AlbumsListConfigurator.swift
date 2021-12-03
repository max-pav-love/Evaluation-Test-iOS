//
//  AlbumsListConfigurator.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 03.12.2021.
//

import Foundation

final class AlbumsListConfigurator {
    
    func setupModule(_ view: AlbumsListViewController) {
        let viewController = view
        let interactor = AlbumsListInteractor()
        let presenter = AlbumsListPresenter()
        let router = AlbumsListRouter()
        
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
}

