//
//  OperationsManager.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import Foundation

class OperationsManager {
    
    static let share = OperationsManager()

    private init() {
    }
    
    let networkController = NetworkController()
    
    /**
     Fetch the Most Viewed Items from the API.
     
     - parameter section: Section to search e.g. all-sections.
     - parameter timePeriod: Time Period enum value.
     - parameter offset: Pagination offset for the request.
     - parameter completionHandler: Callback with optional object MostViewedResponse and Error.
     
     This function utilises the network controller to get the JSON and transforms them into the MostViewedResponse Model.
     */
    public func getMostViewed(section : String, timePeriod : TimePeriod, offset: Int, completionHandler: @escaping (Mostpopular?, Error?) -> Void) {
        
        ProgressLoader.show()
    
        let urlPath = ConfigurationManager.apiPathMostViewed(section: section, timePeriod: timePeriod.rawValue, offset: offset)
        
        self.networkController.getData(urlString: urlPath) { (data, wsError) in
            ProgressLoader.dismiss()
            
            guard let responseData = data else { return completionHandler(nil, wsError) }
            
            // to show the response in String format
//            let reseponseStr = String(decoding: responseData, as: UTF8.self)
//            print("Response: \(reseponseStr)")
        
            let decoder = JSONDecoder()
            do {
                let mostPopular = try decoder.decode(Mostpopular.self, from: responseData)
                completionHandler(mostPopular, wsError)
            } catch {
                print(error.localizedDescription)
                completionHandler(nil, wsError)
            }
        }
    }
}
