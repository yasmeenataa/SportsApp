//
//  FakeCoreData.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import Foundation
@testable import SportsApp
class FakeCoreData: CoreDataProtocol{
   
    var leagues: [LocalLeague]!
    init(){
        leagues = [ LocalLeague(leagueKey:1, leagueName: "league1", sportName: "", leagueLogo: ""),
         LocalLeague(leagueKey:2, leagueName: "league2", sportName: "", leagueLogo: ""),
       LocalLeague(leagueKey:3, leagueName: "league3", sportName: "", leagueLogo: "")]
    }
    func insertLeague(league: SportsApp.LocalLeague) {
        leagues.append(league)
    }
    
    func getFavLeagues() -> [SportsApp.LocalLeague] {
        return leagues
    }
    
    func getLeagueFromLocal(leagueName: String, leagueKey: Int) -> SportsApp.LocalLeague? {
        for i in leagues{
            if   i.leagueKey == leagueKey && i.leagueName == leagueName{
                return i
            }
        }
        
        return  nil
    }
    
    func deleteFavLeague(leagueName: String, leagueKey: Int) {
        for i in 0..<leagues.count{
            
            if  leagues[i].leagueKey == leagueKey && leagues[i].leagueName == leagueName{
                leagues.remove(at: i)
                break
            }
        }
    }
    
}

