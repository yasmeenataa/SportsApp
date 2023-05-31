//
//  FavViewModelTests.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import XCTest
@testable import SportsApp
final class FavViewModelTests: XCTestCase {
    var viewModel: FavouriteViewModel!
    var coreData: FakeCoreData!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        coreData = FakeCoreData()
        viewModel = FavouriteViewModel(coreData: coreData)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
        coreData = nil
    }
    func testInsertFavLeague()
    {
        var league =  LocalLeague(leagueKey:1, leagueName: "league1", sportName: "", leagueLogo: "")
        viewModel.coreData.insertLeague(league: league)
        XCTAssertEqual(coreData.leagues.count, 4)
        
    }
    func testGetSelectedLeague() {
        
        var league =  LocalLeague(leagueKey:1, leagueName: "league1", sportName: "", leagueLogo: "")
        
        coreData.insertLeague(league: league)
        let result = viewModel.getSelectedLeague(leagueName: "league1", leagueKey: 1)
        XCTAssertEqual(result.leagueName, "league1", "Expected league name to be 'league1'")
        XCTAssertEqual(result.leagueKey, 1, "Expected league key to be 1")
        XCTAssertEqual(result.leagueName, coreData.leagues[0].leagueName, "Expected result to be equal to coreData.league")
    }
    func testGetLeagues() {
        
        let result = viewModel.getLeagues()

        XCTAssertEqual(result.count, 3, "Expected 3 leagues")
       }
    func testDeleteLeague() {
        viewModel.deleteLeague(leagueName: "league1", leagueKey: 1)
        XCTAssertEqual(coreData.leagues.count, 2, "Expected 3 league remaining")
        
    }
}
