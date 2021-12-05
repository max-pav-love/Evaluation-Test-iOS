//
//  HistoryInteractor.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HistoryBusinessLogic {
    func requestSearchHistory(request: History.Something.Request)
}

protocol HistoryDataStore {
    var requests: [String] { get }
}

class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
    
    var presenter: HistoryPresentationLogic?
    private var worker: HistoryWorker?
    
    // MARK: - DataStore
    
    var requests = [String]()
    
    // MARK: - Business Logic
    
    func requestSearchHistory(request: History.Something.Request) {
        worker = HistoryWorker()
        requests = worker?.fetchSearchHistory() ?? []
        
        let response = History.Something.Response(requests: requests)
        presenter?.presentSearchHistory(response: response)
    }
    
}
