//
//  WebAPIHelper.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import Foundation

// WebService Type
enum WSType: String {
    case GET = "GET"
    case POST = "POST"
}

// Implemented this with reference of postman
enum BodyType: String {
    case none = "NONE" // No need to supply body
    case multipart = "multipart/form-data"
    case wwwFormUnreloaded = "application/x-www-form-urlencoded"
    case binary = "BINARY" // handling is different way
    case row_Text_Plain = "text/plain"
    case row_Application_Json = "application/json"
    case row_Application_Javascript = "application/javascript"
    case row_Application_Xml = "application/xml"
    case row_Text_Xml = "text/xml"
    case row_Text_Html = "text/html"
}


/**
 Number of days `1 | 7 | 30 ` corresponds to a day, a week, or a month of content.
 
 - Parameter name: time-period.
 - Used in: path.
 - type: string.
 */
enum TimePeriod : String {
    case Day = "1"
    case Week = "7"
    case Month = "30"
    
    func getDisplayName() -> String {
        
        switch self {
            
        case .Day:
            return "Day"
            
        case .Week:
            return "Week"
            
        case .Month:
            return "Month"
        }
    }
}


// API URLS
let APIKey = "UTlHiPJQwOyDGJcprYiurIP2LwjqBqYa"
let kAPIPeriods:Int = 7
let kAPISections = "all-sections"
let API_BASE_URL: String = "http://api.nytimes.com/svc/mostpopular/v2/mostviewed/"

let API_URL = API_BASE_URL + "/\(kAPISections)" + "/\(kAPIPeriods)" + ".json?api-key=\(APIKey)"

extension String {
    
    /// Percent escapes values to be added to a URL query as specified in RFC 3986
    ///
    /// This percent-escapes all characters besides the alphanumeric character set and "-", ".", "_", and "~".
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: Returns percent-escaped string.
    
    func addingPercentEncodingForURLQueryValue() -> String? {
        let allowedCharacters = CharacterSet(charactersIn: "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789-._~")
        
        return self.addingPercentEncoding(withAllowedCharacters: allowedCharacters)
    }
    
}

extension Dictionary {
    
    /// Build string representation of HTTP parameter dictionary of keys and objects
    ///
    /// This percent escapes in compliance with RFC 3986
    ///
    /// http://www.ietf.org/rfc/rfc3986.txt
    ///
    /// :returns: String representation in the form of key1=value1&key2=value2 where the keys and values are percent escaped
    
    func stringFromHttpParameters() -> String {
        let parameterArray = self.map { (key, value) -> String in
            let percentEscapedKey = (key as! String).addingPercentEncodingForURLQueryValue()!
            let percentEscapedValue = ("\(value)" ).addingPercentEncodingForURLQueryValue()!
            return "\(percentEscapedKey)=\(percentEscapedValue)"
        }
        
        return parameterArray.joined(separator: "&")
    }
}

extension NSMutableData {
    func appendString(_ string: String) {
        let data = string.data(using: String.Encoding.utf8, allowLossyConversion: false)
        append(data!)
    }
}

// MARK:- Helper for "application/x-www-form-urlencoded"
extension URLRequest {
    
    private func percentEscapeString(_ string: String) -> String {
        var characterSet = CharacterSet.alphanumerics
        characterSet.insert(charactersIn: "-._* ")
        
        return string
            .addingPercentEncoding(withAllowedCharacters: characterSet)!
            .replacingOccurrences(of: " ", with: "+")
            .replacingOccurrences(of: " ", with: "+", options: [], range: nil)
    }
    
    mutating func encodeParameters(parameters: [String : String]) {
        httpMethod = "POST"
        
        let parameterArray = parameters.map { (arg) -> String in
            let (key, value) = arg
            return "\(key)=\(self.percentEscapeString(value))"
        }
        
        httpBody = parameterArray.joined(separator: "&").data(using: String.Encoding.utf8)
    }
}
