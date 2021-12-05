//
//  HistoryWorker.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

class HistoryWorker {
    
    private let storageManager = StorageManager()
    
    func fetchSearchHistory() -> [String] {
        storageManager.loadRequests()
    }
    
}
