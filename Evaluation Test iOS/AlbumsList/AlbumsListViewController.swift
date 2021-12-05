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
    private let configurator = AlbumsListConfigurator()
    
    @IBOutlet private weak var searchBar: UISearchBar?
    @IBOutlet weak var collection: UICollectionView?
    
    // MARK: - Routing
    
    
    
    //    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    //        if let scene = segue.identifier {
    //            let selector = NSSelectorFromString("routeTo\(scene)WithSegue:")
    //            if let router = router, router.responds(to: selector) {
    //                router.perform(selector, with: segue)
    //            }
    //        }
    //    }
    
    // MARK: - View lifecycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configurator.setupModule(self)
        setupFlow()
        self.collection?.keyboardDismissMode = .onDrag
        UINavigationBar.appearance().frame = CGRect(x: 0.0,
                                                    y: 0.0,
                                                    width: 414,
                                                    height: 30)
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
            self.searchBar?.text = viewModel.request
        }
    }
    
}

extension AlbumsListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        albums.count
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        router?.routeToAlbumDetails()
        collectionView.deselectItem(at: indexPath, animated: true)
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
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        CGSize(width: Constants.CollectionViewArrangement.galleryItemWidth, height: Constants.CollectionViewArrangement.collectionItemHeight)
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

extension AlbumsListViewController: UICollectionViewDelegateFlowLayout {
    func setupFlow() {
        layout.minimumLineSpacing = 8
        collection?.contentInset = UIEdgeInsets(top: 0,
                                                left: 16,
                                                bottom: 10,
                                                right: 16)
    }
}

extension AlbumsListViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            return
        }
        self.getAlbums(searchText)
        searchBar.endEditing(true)
    }
    
}
