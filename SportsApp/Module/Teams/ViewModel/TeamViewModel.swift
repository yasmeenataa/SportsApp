//
//  TeamViewModel.swift
//  SportsApp
//
//  Created by Mac on 25/05/2023.
//

import Foundation
class TeamDetailsViewModel{
    var sendTeamToTeamViewController : (()->()) = {}
   
    var teamList : [Teams]? {
        didSet {
            sendTeamToTeamViewController()
        }
    }
    
    func getTeamDetails(teamId: Int,sportName : String) {
        NetworkManager.getData(met: "Teams&teamId=\(teamId)", sport: sportName) { [weak self] (myResponse: TeamsRoot!) in
            print("team done ////// \(myResponse.result[0].team_key)")
            self?.teamList = myResponse.result
        }
        
    }
}
