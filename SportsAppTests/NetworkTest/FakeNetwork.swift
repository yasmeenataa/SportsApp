//
//  FakeNetwork.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import Foundation
@testable import SportsApp
class FakeNetwork: NetworkProtocol{
    
   static var returnError : Bool = false
   
    static var league1 = League(leagueKey: 1, leagueName: "", countryKey: 1, countryName: "", leagueLogo: "", countryLogo: "", sportName: "")
    static var league2 = League(leagueKey: 2, leagueName: "", countryKey: 1, countryName: "", leagueLogo: "", countryLogo: "", sportName: "")
    
    
    static func getData<T>(met: String, sport: String, handler: @escaping (T?) -> Void) where T : Decodable {
        
        if !returnError {
            handler(LeagueRoot(success: 1, result: [league1 , league2]) as? T)
        }else{
            handler(nil)
        }
        
    }
    
}
