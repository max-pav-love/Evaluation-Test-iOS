//
//  NetworkManager.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import Foundation

final class NetworkManager {
    
    private let albumsURL = "https://itunes.apple.com/search?term="
    private let albumTracksURL = "https://itunes.apple.com/lookup?id="
    
    func fetchAlbumsData(for usersRequest: String, completion: @escaping (_ albums: Albums?) -> Void) {
        let albumsReadyURL = albumsURL + "\(usersRequest)&entity=album"
        
        guard let url = URL(string: albumsReadyURL) else { return }
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            guard let data = data else {
                completion(nil)
                return
            }
            do {
                let decoder = JSONDecoder()
                let albums = try decoder.decode(Albums.self, from: data)
                completion(albums)
            } catch let error {
                print("Error serialization json", error)
                completion(nil)
            }
        }.resume()
    }
    
    func fetchAlbumTracksData(for albumId: Int, completion: @escaping (_ albumTracks: AlbumTracks?) -> Void) {
        let albumTracksReadyURL = albumTracksURL + "\(albumId)&entity=song"
        guard let url = URL(string: albumTracksReadyURL) else { return }
        DispatchQueue.main.async {
            URLSession.shared.dataTask(with: url) { (data, _, _) in
                guard let data = data else {
                    return
                }
                do {
                    let decoder = JSONDecoder()
                    let tracks = try decoder.decode(AlbumTracks.self, from: data)
                    completion(tracks)
                } catch let error {
                    print("Error serialization json", error)
                    completion(nil)
                }
            }.resume()
        }
    }
    
}
