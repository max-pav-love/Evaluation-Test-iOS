//
//  HistoryInteractor.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HistoryBusinessLogic {
    func doSomething(request: History.Something.Request)
}

protocol HistoryDataStore {
    
}

class HistoryInteractor: HistoryBusinessLogic, HistoryDataStore {
    
    var presenter: HistoryPresentationLogic?
    var worker: HistoryWorker?
    
    // MARK: - DataStore
    
    // MARK: - Business Logic
    
    func doSomething(request: History.Something.Request) {
        worker = HistoryWorker()
        worker?.doSomeWork()
        
        let response = History.Something.Response()
        presenter?.presentSomething(response: response)
    }
    
}
