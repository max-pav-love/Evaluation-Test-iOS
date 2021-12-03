//
//  AlbumsListRouter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

@objc protocol AlbumsListRoutingLogic {
    func routeToAlbumDetails()
}

protocol AlbumsListDataPassing {
    var dataStore: AlbumsListDataStore? { get }
}

class AlbumsListRouter: NSObject, AlbumsListRoutingLogic, AlbumsListDataPassing {
    
    weak var viewController: AlbumsListViewController?
    var dataStore: AlbumsListDataStore?
    //    private static let detailSegue = "showAlbumDetails"
    
    // MARK: - Routing Logic
    
    func routeToAlbumDetails() {
        let storyboard = UIStoryboard(name: "AlbumDetails", bundle: nil)
        guard
            let destinationVC = storyboard.instantiateViewController(withIdentifier: "AlbumDetailsStoryboard") as? AlbumDetailsViewController,
            var destinationDS = destinationVC.router?.dataStore,
            let dataStore = dataStore else {
                return
            }
        passDataToAlbumDetails(source: dataStore, destination: &destinationDS)
        navigateToAlbumDetails(destination: destinationVC)
    }
    
    func navigateToAlbumDetails(destination: AlbumDetailsViewController) {
//        viewController?.navigationController?.pushViewController(destination, animated: true)
        viewController?.present(destination, animated: true)
//        viewController?.navigationController?.present(destination, animated: true)
    }
    
    // MARK: - Passing data
    
    func passDataToAlbumDetails(source: AlbumsListDataStore, destination: inout AlbumDetailsDataStore) {
        guard let indexPath = viewController?.collection?.indexPathsForSelectedItems?.first else { return }
        destination.album = source.albumsResults[indexPath.item]
    }
    
}
