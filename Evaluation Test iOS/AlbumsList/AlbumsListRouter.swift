//
//  AlbumsListRouter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

@objc protocol AlbumsListRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol AlbumsListDataPassing {
    var dataStore: AlbumsListDataStore? { get }
}

class AlbumsListRouter: NSObject, AlbumsListRoutingLogic, AlbumsListDataPassing {
    
    weak var viewController: AlbumsListViewController?
    var dataStore: AlbumsListDataStore?
    
    // MARK: - Routing Logic
    
//    func routeToSomewhere(segue: UIStoryboardSegue?) {
//        if let segue = segue {
//            let destinationVC = segue.destination as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//        } else {
//            let storyboard = UIStoryboard(name: "Main", bundle: nil)
//            let destinationVC = storyboard.instantiateViewController(withIdentifier: "SomewhereViewController") as! SomewhereViewController
//            var destinationDS = destinationVC.router!.dataStore!
//            passDataToSomewhere(source: dataStore!, destination: &destinationDS)
//            navigateToSomewhere(source: viewController!, destination: destinationVC)
//        }
//    }
    
    // MARK: - Navigation
    
//    func navigateToSomewhere(source: AlbumsListViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: - Passing data
    
//    func passDataToSomewhere(source: AlbumsListDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
    
}
