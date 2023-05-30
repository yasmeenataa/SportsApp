//
//  FavTableViewCell.swift
//  SportsApp
//
//  Created by Mac on 28/05/2023.
//

import UIKit

class FavTableViewCell: UITableViewCell {
    @IBOutlet weak var favLeagueImage: UIImageView!
    
    @IBOutlet weak var favLeagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.favLeagueImage.layer.cornerRadius =   self.favLeagueImage.frame.size.width / 2
        self.favLeagueImage.layer.masksToBounds = false
        self.favLeagueImage.clipsToBounds = true
        self.favLeagueImage.layer.borderColor = UIColor.black.cgColor
        self.favLeagueImage.layer.borderWidth = 1.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
