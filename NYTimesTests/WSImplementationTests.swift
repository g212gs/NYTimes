//
//  WSImplementationTests.swift
//  NYTimesTests
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import XCTest
@testable import NYTimes

class WSImplementationTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
    }
    
    func testMostViewed() {
        let expectation = self.expectation(description:  "Web Service Response Received")
        
        self.measure {
            
            OperationsManager.share.getMostViewed(section: "all-sections", timePeriod: TimePeriod.Day, offset: 0, completionHandler: { obj, err in
                
                expectation.fulfill()
            })
            
        }
        
        self.waitForExpectations(timeout: 30) { error in
            
            XCTAssertNil(error)
        }
    }

}
