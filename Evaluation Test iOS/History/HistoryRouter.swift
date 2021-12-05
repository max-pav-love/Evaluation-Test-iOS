//
//  HistoryRouter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol HistoryRoutingLogic {
    func routeToSearch()
}

protocol HistoryDataPassing {
    var dataStore: HistoryDataStore? { get }
}

class HistoryRouter: NSObject, HistoryRoutingLogic, HistoryDataPassing {
    
    weak var viewController: HistoryViewController?
    var dataStore: HistoryDataStore?
    
    // MARK: - Routing Logic
    
    func routeToSearch() {
        let viewControllers = viewController?.tabBarController?.viewControllers
        guard
            let searchVCIndex = viewControllers?.firstIndex(where: { $0.restorationIdentifier == "albumsList" }),
            let navigationController = viewControllers?[searchVCIndex] as? UINavigationController,
            let searchVC = navigationController.viewControllers.first as? AlbumsListViewController,
            var destinationDS = searchVC.router?.dataStore,
            let dataStore = dataStore,
            let source = viewController
        else {
            return
        }
        
        passDataToSearch(source: dataStore, destination: &destinationDS)
        navigateToSearch(source: source, destinationIndex: searchVCIndex)
        
    }
    
    // MARK: - Navigation
    
    func navigateToSearch(source: HistoryViewController, destinationIndex: Int) {
        source.tabBarController?.selectedIndex = destinationIndex
    }
    
    // MARK: - Passing Data
    
    func passDataToSearch(source: HistoryDataStore, destination: inout AlbumsListDataStore) {
        guard
            let selectedIndex = viewController?.tableView.indexPathForSelectedRow?.row,
            dataStore?.requests.indices.contains(selectedIndex) == true,
            let selectedRequest = dataStore?.requests[selectedIndex],
            let destinationInteractor = destination as? AlbumsListBusinessLogic
        else {
            return
        }
        let request = AlbumsList.Albums.Request(album: selectedRequest)
        destinationInteractor.fetchAlbums(request: request)
    }
    
}
