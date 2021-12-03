//
//  AlbumDetailsViewController.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//  Copyright (c) 2021 ___ORGANIZATIONNAME___. All rights reserved.

import UIKit
import SwiftUI
import Kingfisher

protocol AlbumDetailsDisplayLogic: AnyObject {
    func displayAlbumDetails(viewModel: AlbumDetails.Album.ViewModel)
}

class AlbumDetailsViewController: UIViewController, AlbumDetailsDisplayLogic {
    
    var interactor: AlbumDetailsBusinessLogic?
    var router: (NSObjectProtocol & AlbumDetailsRoutingLogic & AlbumDetailsDataPassing)?
    
    private var tracks: [AlbumDetails.Album.ViewModel.DisplayedTrack] = []
    
    // MARK: - Object lifecycle
    
    @IBOutlet private weak var table: UITableView?
    
    @IBOutlet weak var artistNameLabel: UILabel!
    @IBOutlet weak var albumYearLabel: UILabel!
    @IBOutlet weak var albumGenreLabel: UILabel!
    @IBOutlet weak var albumCover: UIImageView!
    
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
        let interactor = AlbumDetailsInteractor()
        let presenter = AlbumDetailsPresenter()
        let router = AlbumDetailsRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    //
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let scene = segue.identifier {
    //            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
    //            if let router = router, router.responds(to: selector) {
    //                router.perform(selector, with: segue)
    //            }
    //        }
    //    }
    //
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        getAlbumDetails()
    }
    
    // MARK: - Methods
    
    func getAlbumDetails() {
        let request = AlbumDetails.Album.Request()
        interactor?.fetchAlbumDetails(request: request)
    }
    
    func displayAlbumDetails(viewModel: AlbumDetails.Album.ViewModel) {
        tracks = viewModel.dispalayedTracks
        DispatchQueue.main.async {
            self.navigationItem.title = viewModel.displayedAlbum.albumName
            self.artistNameLabel.text = viewModel.displayedAlbum.artistName
            self.albumYearLabel.text = viewModel.displayedAlbum.releaseDate
            self.albumGenreLabel.text = viewModel.displayedAlbum.genre
            self.albumCover.kf.indicatorType = .activity
            self.albumCover?.kf.setImage(with: viewModel.displayedAlbum.artworkUrl)
            self.albumCover.self?.layer.cornerRadius = 8
            self.table?.reloadData()
        }
    }
    
}

extension AlbumDetailsViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: AlbumDetailsTrackTableViewCell.identifier, for: indexPath) as? AlbumDetailsTrackTableViewCell else {
            return UITableViewCell()
        }
        cell.configure(tracks[indexPath.row])
        return cell
    }
    
}

extension AlbumDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Tracks"
    }
}
