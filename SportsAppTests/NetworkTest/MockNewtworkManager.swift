//
//  MockNewtworkManager.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import XCTest
@testable import SportsApp

final class MockNewtworkManager: XCTestCase {
   
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        FakeNetwork.returnError = false
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    func testData(){
        FakeNetwork.getData(met: "", sport: "") { (league: LeagueRoot!) in
            if  league.result.count == 2{
                XCTAssertEqual(league.result.count , 2)
            }
            else{
                XCTFail()
            }
        }
        
    }
    func testGettingData(){
        FakeNetwork.getData(met: "", sport: "") { (league: LeagueRoot!) in
            XCTAssertNotEqual(league.success, 2)
            XCTAssertEqual(league.success, 1)
        }
    }
   
}
