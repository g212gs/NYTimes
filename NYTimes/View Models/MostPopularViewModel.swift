//
//  MostPopularViewModel.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 13/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import UIKit

protocol MostPopularViewModelDelegate: class {
    func SuccessRetrivingResult()
    func FailureRetrivingResult(error msg: String)
}

class MostPopularViewModel: NSObject {

    // MARK: - Public Varibles

    weak var delegate: MostPopularViewModelDelegate?
    var dataSourceObjects = [Result]()

    // MARK: - Private Varibles
    private var operationsManager: OperationsManager
    
    var currentOffset = 0
    var defaultSection = "all-sections"
    var defaultTimePeriod = TimePeriod.Week

    init(operationsManager: OperationsManager) {
        self.operationsManager = operationsManager
    }
    
    /// fetch Data from source etc ..Webservice/DataBase
    func fetchData() {
        
        operationsManager.getMostViewed(
            section: self.defaultSection,
            timePeriod: self.defaultTimePeriod,
            offset: self.currentOffset) { (responseModel, error) in
                
                if let response = responseModel, let arrResults = response.results {
                    self.dataSourceObjects = arrResults
                    self.delegate?.SuccessRetrivingResult()
                } else {
                    self.delegate?.FailureRetrivingResult(error: error?.localizedDescription ?? ErrorListings.kErrorWSNoData.localizedDescription)
                }
        }
    }
    
}
