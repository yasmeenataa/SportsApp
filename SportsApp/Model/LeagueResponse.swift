//
//  LeagueResponse.swift
//  SportsApp
//
//  Created by Mac on 24/05/2023.
//

import Foundation
struct LeagueRoot: Decodable{
    let success: Int
    let result: [League]
}

struct League: Decodable{
    let leagueKey: Int?
    let leagueName: String?
    let countryKey: Int?
    let countryName: String?
    let leagueLogo: String?
    let countryLogo: String?
    let sportName:String?
    
    
    enum CodingKeys: String, CodingKey{
        case leagueKey = "league_key"
        case leagueName = "league_name"
        case countryKey = "country_key"
        case countryName = "country_name"
        case leagueLogo = "league_logo"
        case countryLogo = "country_logo"
        case sportName = "sportName"
    }
    
}
