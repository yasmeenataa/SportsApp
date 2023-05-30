//
//  CoreDataProtocol.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
protocol CoreDataProtocol{
    func insertLeague(league: LocalLeague)
    
    func getFavLeagues() -> [LocalLeague]
    
    func getLeagueFromLocal(leagueName: String, leagueKey: Int)  -> LocalLeague?
    
    func deleteFavLeague(leagueName: String, leagueKey: Int)
}
