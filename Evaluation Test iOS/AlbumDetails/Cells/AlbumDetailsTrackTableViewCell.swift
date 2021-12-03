//
//  AlbumDetailsTrackTableViewCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 03.12.2021.
//

import UIKit

class AlbumDetailsTrackTableViewCell: UITableViewCell {

    static let identifier = "TrackCell"
    
    @IBOutlet weak var trackTitleLabel: UILabel!
    @IBOutlet weak var trackLenghtLabel: UILabel!
    
    func configure(_ track: AlbumDetails.Album.ViewModel.DisplayedTrack) {
        trackTitleLabel.text = track.trackName
//        trackLenghtLabel.text = track.trackArtist
    }
}
