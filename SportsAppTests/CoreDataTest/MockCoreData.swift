//
//  MockCoreData.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import XCTest
@testable import SportsApp
final class MockCoreData: XCTestCase {
    var coreData = FakeCoreData()
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
       
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        
    }

    func testinsertLeague()  {
        let localLeague = LocalLeague(leagueKey: 4, leagueName: "", sportName: "", leagueLogo: "")
        coreData.insertLeague(league: localLeague)
        XCTAssertEqual(coreData.leagues.count, 4)
        
    }
    func testdeleteFavLeague(){
        let league: ()? =  coreData.deleteFavLeague(leagueName: "league1", leagueKey: 1)
        
            XCTAssertEqual(coreData.leagues.count , 2)
        
    }
    func testgetFavLeagues(){
        coreData.getFavLeagues()
        XCTAssertEqual(coreData.leagues.count, 3)
    }
    func testgetFavLeagueWithName( ){
       let league =  coreData.getLeagueFromLocal(leagueName: "league1", leagueKey: 1)
        if league != nil{
            XCTAssertEqual(coreData.leagues.count , 3)
        }
        else{
            XCTFail()
        }
       
    }

}
