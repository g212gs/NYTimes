//
//  WebAPIProtocol.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import Foundation

protocol WebAPIProtocol {
    
    /**
     Gets a Data object corresponding to given URL String.
     
    
     - parameter urlString: Full URL of the resource.
     - parameter completionHandler: Callback with opionally the returned data and error.
     
     This method accepts a string value representing the full url and a callback handler with optionally the data and error
     */
    func getData(urlString : String, completionHandler: @escaping (Data?, Error?) -> Void)
    
}
