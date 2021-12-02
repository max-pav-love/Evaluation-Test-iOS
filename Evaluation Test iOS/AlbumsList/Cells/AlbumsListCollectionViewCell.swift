//
//  AlbumsListCollectionViewCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit
import Kingfisher

class AlbumsListCollectionViewCell: UICollectionViewCell {
    
    static let identifier = "AlbumCell"
    
    @IBOutlet weak var albumTitleLabel: UILabel!
    @IBOutlet private weak var albumImage: UIImageView?
    @IBOutlet weak var albumArtist: UILabel!
    @IBOutlet weak var numberOfTracks: UILabel!
    
    func configure(_ albums: AlbumsList.Albums.ViewModel.DisplayedAlbums) {
        albumTitleLabel.text = albums.albumName
        albumImage?.kf.indicatorType = .activity
        albumImage?.kf.setImage(with: albums.artworkUrl)
        albumImage.self?.layer.cornerRadius = 8
        albumArtist.text = albums.artistName
        numberOfTracks.text = "Tracks: \(albums.numberOfTracks)"
    }
}
