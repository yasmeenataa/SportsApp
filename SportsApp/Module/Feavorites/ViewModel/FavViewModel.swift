//
//  FavViewModel.swift
//  SportsApp
//
//  Created by Mac on 25/05/2023.
//

import Foundation
class FavouriteViewModel {
    var refreshFavouriteLeagues: (()->()) = {}
    var leagues: [LocalLeague]?{
        didSet{
           
                        refreshFavouriteLeagues()
        }
    }
    var returnFavouriteLeague: (()->()) = {}
    var league: LocalLeague?{
        didSet{
            
        returnFavouriteLeague()
        }
    }
    
    var coreData: CoreDataProtocol
    init( coreData: CoreDataProtocol) {
        self.coreData = coreData
    }
    
    func getLeagues() -> [LocalLeague]{
        leagues = coreData.getFavLeagues()
        
        return leagues ?? []
    }
    
    func deleteLeague(leagueName: String, leagueKey: Int){
        coreData.deleteFavLeague(leagueName: leagueName, leagueKey: leagueKey)
        let _ = getLeagues()
    }
    
    func getSelectedLeague(leagueName: String, leagueKey: Int) -> LocalLeague{
        league = coreData.getLeagueFromLocal(leagueName: leagueName, leagueKey: leagueKey)
        return league ?? LocalLeague(leagueKey: 0, leagueName: "", sportName: "", leagueLogo: "")
    }
}
