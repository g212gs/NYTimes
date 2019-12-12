//
//  EnumTests.swift
//  NYTimesTests
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import XCTest
@testable import NYTimes

class EnumTests: XCTestCase {

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
    
    func testDisplayNameForTimePeriodEnum() {
        
        XCTAssertFalse(TimePeriod.Day.getDisplayName() != "Day")
        XCTAssertFalse(TimePeriod.Week.getDisplayName() != "Week")
        XCTAssertFalse(TimePeriod.Month.getDisplayName() != "Month")
    }

    func testRawValueForTimePeriodEnum() {
        
        XCTAssertFalse(TimePeriod.Day.rawValue != "1")
        XCTAssertFalse(TimePeriod.Week.rawValue != "7")
        XCTAssertFalse(TimePeriod.Month.rawValue != "30")
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
