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
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var navBarTitle: UINavigationItem!
    @IBOutlet private var loader: UIActivityIndicatorView?
    @IBOutlet private weak var loaderView: UIView?
    
    @IBOutlet weak var navBar: UINavigationBar!
    
    @IBOutlet weak var countryLabel: UILabel!
    
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
        setupUI(viewModel: viewModel)
        showUI()
    }
    
    @IBAction func closeAlbumDetailsButton(_ sender: UIBarButtonItem) {
        self.dismiss(animated: true)
    }
    
// MARK: - Private

    private func showUI() {
        DispatchQueue.main.async {
            self.table?.isHidden = false
            self.loader?.stopAnimating()
            self.loaderView?.isHidden = true
            self.albumCover.isHidden = false
            self.navBar.isHidden = false
        }
    }
    
    private func setupUI(viewModel: AlbumDetails.Album.ViewModel) {
        DispatchQueue.main.async {
            self.navBarTitle.title = viewModel.displayedAlbum.albumName
            self.artistNameLabel.text = viewModel.displayedAlbum.artistName
            self.albumYearLabel.text = "Year: " +  viewModel.displayedAlbum.releaseDate
            self.albumGenreLabel.text = "Genre: " +  viewModel.displayedAlbum.genre
            self.copyrightLabel.text = viewModel.displayedAlbum.copyright
            self.countryLabel.text = viewModel.displayedAlbum.country
            self.albumCover.kf.indicatorType = .activity
            self.albumCover?.kf.setImage(with: viewModel.displayedAlbum.artworkUrl)
            self.albumCover.self?.layer.cornerRadius = 15
            self.albumCover?.layer.shadowRadius = 5
            self.albumCover?.layer.shadowOpacity = 0.2
            self.albumCover?.layer.shadowOffset = CGSize(width: 4, height: 9)
            self.albumCover?.clipsToBounds = true
            self.table?.reloadData()
        }
    }
    
}

// MARK: - UITableViewDataSource

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

// MARK: - UITableViewDelegate

extension AlbumDetailsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        "Tracks"
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        view.tintColor = UIColor.systemGroupedBackground
    }
}
