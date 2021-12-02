//
//  NetworkManager.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import Foundation

final class NetworkManager {
    
    private let albumsURL = "https://itunes.apple.com/search?term="
    
    func fetchAlbumsData(for usersRequest: String, completion: @escaping (_ albums: Albums?) -> Void) {
        let albumsReadyURL = albumsURL + "\(usersRequest)&entity=album&attribute=albumTerm"
        print(albumsReadyURL)
        
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
    
}
