//
//  ErrorListing.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import Foundation

class ErrorListings {
    
    static let kNoInterNetConnection = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No internet connection available"])
    
    static let kErrorWSNoData = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "No data available"])
    
    static let kInvalidURL = NSError(domain: "", code: 0, userInfo: [NSLocalizedDescriptionKey: "Invalid URL"])
}
