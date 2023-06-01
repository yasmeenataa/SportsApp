//
//  TeamsCollectionViewCell.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamImage: UIImageView!
    
    override func layoutSubviews() {
            super.layoutSubviews()
            layer.cornerRadius = 10
            layer.borderWidth = 1
            layer.borderColor = UIColor.black.cgColor
        }
}
