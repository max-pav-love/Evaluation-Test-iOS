//
//  AlbumDetailsRouter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

@objc protocol AlbumDetailsRoutingLogic {
}

protocol AlbumDetailsDataPassing {
    var dataStore: AlbumDetailsDataStore? { get }
}

class AlbumDetailsRouter: NSObject, AlbumDetailsRoutingLogic, AlbumDetailsDataPassing {
    
    weak var viewController: AlbumDetailsViewController?
    var dataStore: AlbumDetailsDataStore?
    
}
