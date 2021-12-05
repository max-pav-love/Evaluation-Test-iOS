//
//  HistoryPresenter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HistoryPresentationLogic {
    func presentSearchHistory(response: History.Something.Response)
}

class HistoryPresenter: HistoryPresentationLogic {
    
    weak var viewController: HistoryDisplayLogic?
    
    // MARK: - PresentationLogic
    
    func presentSearchHistory(response: History.Something.Response) {
        let viewModel = History.Something.ViewModel(requests: response.requests.reversed())
        viewController?.displayHistory(viewModel: viewModel)
    }
    
}
