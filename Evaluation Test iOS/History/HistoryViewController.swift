//
//  HistoryViewController.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit

protocol HistoryDisplayLogic: AnyObject {
    func displayHistory(viewModel: History.Something.ViewModel)
}

class HistoryViewController: UITableViewController, HistoryDisplayLogic {
    
    var interactor: HistoryBusinessLogic?
    var router: (NSObjectProtocol & HistoryRoutingLogic & HistoryDataPassing)?
    
    var userRequests = [String]()
    
    // MARK: - Object lifecycle
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
        setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }

    
    // MARK: - Setup
    
    private func setup() {
        let viewController = self
        let interactor = HistoryInteractor()
        let presenter = HistoryPresenter()
        let router = HistoryRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - View lifecycle

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        requestHistory()
    }
    
    // MARK: - Methods
    
    private func requestHistory() {
        let request = History.Something.Request()
        interactor?.requestSearchHistory(request: request)
    }
    
    func displayHistory(viewModel: History.Something.ViewModel) {
        self.userRequests = viewModel.requests
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userRequests.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: HistoryTableViewCell.identifier, for: indexPath) as? HistoryTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(searchRequest: userRequests[indexPath.row])
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        router?.routeToSearch()
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
}
