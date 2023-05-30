//
//  LeaguesViewModel.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
class LeaguesViewModel{
    var sport: String?
    var sendArrayToViewController: (()->()) = {}
    var leagues: [League]!{
        didSet{
            sendArrayToViewController()
        }
    }
    init(sport: String ) {
        self.sport = sport
    }
    
    func getData(){
        
        NetworkManager.getData(met: "Leagues", sport: sport ?? "") { [weak self] (myResponse: LeagueRoot!) in
            
            self?.leagues = myResponse.result
        }
    }
}
