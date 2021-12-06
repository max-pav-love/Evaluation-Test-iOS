//
//  StorageManager.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 04.12.2021.
//

import Foundation

final class StorageManager {
    
    enum StorageKeys: String {
        case searchRequests
    }
    
    func addRequest(request: String) {
        var data = UserDefaults.standard.stringArray(forKey: StorageKeys.searchRequests.rawValue) ?? []
        data.append(request)
        let lastRequests = Array(data.suffix(10))
        UserDefaults.standard.set(lastRequests, forKey: StorageKeys.searchRequests.rawValue)
        UserDefaults.standard.synchronize()
    }
    
    func loadRequests() -> [String] {
        let data = UserDefaults.standard.stringArray(forKey: StorageKeys.searchRequests.rawValue)
        return data ?? []
    }
    
}
