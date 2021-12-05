//
//  HistoryTableViewCell.swift
//  Evaluation Test iOS
//
//  Created by Максим Хлесткин on 02.12.2021.
//

import UIKit

class HistoryTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchRequestLabel: UILabel!
    
    static let identifier = "historyCell"
    func configure(searchRequest: String) {
        searchRequestLabel.text = searchRequest
    }
}
