//
//  HistoryPresenter.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HistoryPresentationLogic {
    func presentSomething(response: History.Something.Response)
}

class HistoryPresenter: HistoryPresentationLogic {
    
    weak var viewController: HistoryDisplayLogic?
    
    // MARK: - PresentationLogic
    
    func presentSomething(response: History.Something.Response) {
        let viewModel = History.Something.ViewModel()
        viewController?.displaySomething(viewModel: viewModel)
    }
    
}
