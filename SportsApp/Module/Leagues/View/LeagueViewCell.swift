//
//  LeagueViewCell.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import UIKit

class LeagueViewCell: UITableViewCell {

    @IBOutlet weak var leagueName: UILabel!
    @IBOutlet weak var leagueImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
       self.leagueImage.contentMode = .scaleAspectFill
        
        self.leagueImage.layer.cornerRadius =   self.leagueImage.frame.size.width / 2
        self.leagueImage.layer.masksToBounds = false
        self.leagueImage.clipsToBounds = true
        self.leagueImage.layer.borderColor = UIColor.black.cgColor
        self.leagueImage.layer.borderWidth = 1.5
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
