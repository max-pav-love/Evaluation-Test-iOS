//
//  HistoryRouter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol HistoryRoutingLogic {
    //func routeToSomewhere(segue: UIStoryboardSegue?)
}

protocol HistoryDataPassing {
    var dataStore: HistoryDataStore? { get }
}

class HistoryRouter: NSObject, HistoryRoutingLogic, HistoryDataPassing {
    
    weak var viewController: HistoryViewController?
    var dataStore: HistoryDataStore?
    
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
    
//    func navigateToSomewhere(source: HistoryViewController, destination: SomewhereViewController) {
//        source.show(destination, sender: nil)
//    }
    
    // MARK: - Passing data
    
//    func passDataToSomewhere(source: HistoryDataStore, destination: inout SomewhereDataStore) {
//        destination.name = source.name
//    }
    
}
