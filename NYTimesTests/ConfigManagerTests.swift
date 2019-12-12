//
//  ConfigManagerTests.swift
//  NYTimesTests
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import XCTest
@testable import NYTimes

class ConfigManagerTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testApiPathMostViewed() {
        // Given a section and time period, the API path should always be returned.
        
        XCTAssertNotNil(ConfigurationManager.apiPathMostViewed(section: "all-sections", timePeriod: "1", offset: 0))
    }
    
    func testApiPathSectionsListAvailable() {
        // Given a section and time period, the API path should always be returned.
        
        XCTAssertNotNil(ConfigurationManager.apiPathSectionsList())
        
    }
    
    func testApiPathSectionsListValidURL() {
    
        let url = URL(string: ConfigurationManager.apiPathSectionsList())

        XCTAssertNotNil(url)
    }
    
    func testApiKeyAvailable() {
        
        let urlString = ConfigurationManager.apiPathSectionsList()
        
        XCTAssertTrue(urlString.contains("api-key="))
    }

}
