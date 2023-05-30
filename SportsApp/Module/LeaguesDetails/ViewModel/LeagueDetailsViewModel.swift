//
//  LeagueDetailsViewModel.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation

class LeagueDetailsViewModel{
    var sport: String?
    var leagueId: Int?
    var upComingArrayToViewController: (()->()) = {}
    var latestArrayToViewController: (()->()) = {}
    var teamArrayToViewController: (()->()) = {}
    var upComingEvents: [Event]!{
        didSet{
            upComingArrayToViewController()
        }
    }
    
    var latestEvents: [Event]!{
        didSet{
            latestArrayToViewController()
        }
    }
   
    var teams: [Teams]!{
        didSet{
            teamArrayToViewController()
        }
    }
    var coredata: CoreDataProtocol
    init(sport: String, leagueId: Int, coredata: CoreDataProtocol) {
        self.sport = sport
        self.leagueId = leagueId
        self.coredata = coredata
    }
    
    func getUpComingEvents(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"

        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        NetworkManager.getData(met: "Fixtures&leagueId=\(leagueId ?? 4)&from=\(currentDateString)&to=2025-01-01", sport: sport ?? "") { [weak self] (myResponse: EventRoot!) in
            print("upcoming events recieved")
            self?.upComingEvents = myResponse.result
        }
        
    }
    func getLatestEvents(){
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let currentDate = Date()
        let currentDateString = dateFormatter.string(from: currentDate)
        NetworkManager.getData(met: "Fixtures&leagueId=\(leagueId ?? 4)&from=2020-01-01&to=\(currentDateString)", sport: sport ?? "") { [weak self] (myResponse: EventRoot!) in
            print("latest events done")
            self?.latestEvents = myResponse.result
        }
    }
    
    func getTeams(){
   
        NetworkManager.getData(met: "Teams&?met=Leagues&leagueId=\(leagueId ?? 1)", sport: sport ?? "") { [weak self] (myResponse: TeamsRoot!) in
            print("Teams done")
            self?.teams = myResponse.result
        }
    }
    
    func deleteFavLeague(leagueName: String, leagueKey: Int){
        coredata.deleteFavLeague(leagueName: leagueName, leagueKey: leagueKey)
    }
    
    func getSelectedLeague(leagueName: String, leagueKey: Int) -> LocalLeague?{
        print("Return selected league")

        return coredata.getLeagueFromLocal(leagueName: leagueName, leagueKey: leagueKey) ?? nil
    }
    func addToFav(league: LocalLeague){
        coredata.insertLeague(league: league)
    }
    
}
