//
//  Constants.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import Foundation
import UIKit

struct Constants {
    
    struct CollectionViewArrangement {
        static let leftDistance: CGFloat = 20
        static let rightDistance: CGFloat = 20
        static let galleryMinimumLineSpacing: CGFloat = 8
        static let galleryItemWidth = (UIScreen.main.bounds.width - Constants.CollectionViewArrangement.leftDistance - Constants.CollectionViewArrangement.rightDistance - (Constants.CollectionViewArrangement.galleryMinimumLineSpacing / 2 )) / 2
        static let collectionItemHeight: CGFloat = 280
    }
    struct collectionViewItemsData {
        
    }
}
