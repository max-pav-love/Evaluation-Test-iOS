//
//  AlbumsListViewController.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

protocol AlbumsListDisplayLogic: AnyObject {
    func displayAlbums(viewModel: AlbumsList.Albums.ViewModel)
}

class AlbumsListViewController: UIViewController, AlbumsListDisplayLogic {
    
    var interactor: AlbumsListBusinessLogic?
    var router: (NSObjectProtocol & AlbumsListRoutingLogic & AlbumsListDataPassing)?
    
    private var albums = [AlbumsList
                            .Albums
                            .ViewModel
                            .DisplayedAlbums]()
    private var usersRequest: String?
    private var timer: Timer?
    private let layout = UICollectionViewFlowLayout()
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet private weak var collection: UICollectionView?
    
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
        let interactor = AlbumsListInteractor()
        let presenter = AlbumsListPresenter()
        let router = AlbumsListRouter()
        viewController.interactor = interactor
        viewController.router = router
        interactor.presenter = presenter
        presenter.viewController = viewController
        router.viewController = viewController
        router.dataStore = interactor
    }
    
    // MARK: - Routing
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let scene = segue.identifier {
            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
            if let router = router, router.responds(to: selector) {
                router.perform(selector, with: segue)
            }
        }
    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupFlow()
    }
    
    // MARK: - Methods
    
    func getAlbums(_ album: String) {
        let request = AlbumsList.Albums.Request(album: album)
        interactor?.fetchAlbums(request: request)
    }
    
    func displayAlbums(viewModel: AlbumsList.Albums.ViewModel) {
        albums = viewModel.displayedAlbums
        DispatchQueue.main.async {
            self.collection?.reloadData()
        }
    }
}

extension AlbumsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: AlbumsListCollectionViewCell.identifier, for: indexPath) as? AlbumsListCollectionViewCell else {
            return UICollectionViewCell()
        }
        cell.layer.cornerRadius = 10
        cell.configure(albums[indexPath.row])
        return cell
    }
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        1
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.galleryItemWidth, height: Constants.collectionItemHeight)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        self.collection?.layer.cornerRadius = 1
        self.collection?.layer.shadowRadius = 5
        collection?.layer.shadowOpacity = 0.2
        collection?.layer.shadowOffset = CGSize(width: 3, height: 5)
        self.collection?.clipsToBounds = true
    }
}

extension AlbumsListViewController: UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func setupFlow() {
        layout.minimumLineSpacing = 8
        collection?.contentInset = UIEdgeInsets(top: 0,
                                                left: 16,
                                                bottom: 0,
                                                right: 16)
    }
    
}

extension AlbumsListViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchText != "" {
            timer?.invalidate()
            timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false, block: { [weak self] _ in
                self?.getAlbums(searchText)
            })
        }
    }
}


