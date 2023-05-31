//
//  NetworkTest.swift
//  SportsAppTests
//
//  Created by Mac on 31/05/2023.
//

import XCTest
@testable import SportsApp

final class NetworkTest: XCTestCase {
    var network: NetworkProtocol!
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        network = NetworkManager()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        network = nil
    }

    func testGetFootballtData()  {
        let myExpectation = expectation(description: "waiting api network")
        NetworkManager.getData(met: "Leagues", sport: "football") { (myResponse: LeagueRoot!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
       
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
    }
    func testGetBasketData()  {
        let myExpectation = expectation(description: "waiting api network")
        NetworkManager.getData(met: "Leagues", sport: "basketball") { (myResponse: LeagueRoot!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
       
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
    }
    func testGetTennisData()  {
        let myExpectation = expectation(description: "waiting api network")
        NetworkManager.getData(met: "Leagues", sport: "tennis") { (myResponse: LeagueRoot!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
       
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
    }
    func testGetTeamData()  {
        let myExpectation = expectation(description: "waiting api network")
        NetworkManager.getData(met: "Teams&teamId=74", sport: "football") { (myResponse: LeagueRoot!) in
            guard let myResponse = myResponse else{
                XCTFail()
                myExpectation.fulfill()
                return
            }
       
            XCTAssertEqual(myResponse.success, 1)
            myExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 10)
        
    }

    

}
