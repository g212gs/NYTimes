//
//  NYTimesTests.swift
//  NYTimesTests
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import UIKit
import XCTest
@testable import NYTimes

class NYTimesTests: XCTestCase {

    var storyboard : UIStoryboard?
    
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        self.storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        XCTAssertNotNil(self.storyboard)
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testMasterView() {
        
        let listScreen = self.storyboard?.instantiateViewController(withIdentifier: "ListScreen")
        
        XCTAssertNotNil(listScreen)
        XCTAssertTrue(listScreen is ListScreen)
        
    }
    
    func testDetailView() {
        
        let detailScreen = self.storyboard?.instantiateViewController(withIdentifier: "DetailScreen")
        
        XCTAssertNotNil(detailScreen)
        XCTAssertTrue(detailScreen is DetailScreen)
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}
