//
//  UpCommingViewCell.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import UIKit

class UpCommingViewCell: UICollectionViewCell {
    
    @IBOutlet weak var eventTime: UILabel!
    @IBOutlet weak var eventDate: UILabel!
    @IBOutlet weak var TeamTwoName: UILabel!
    @IBOutlet weak var teamOneName: UILabel!
    @IBOutlet weak var teamTwoImage: UIImageView!
    @IBOutlet weak var teamOneImage: UIImageView!
    
    override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = 10
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
}
