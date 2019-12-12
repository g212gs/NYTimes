//
//  WebAPISession.swift
//  NYTimes
//
//  Created by Gaurang Lathiya on 12/12/19.
//  Copyright © 2019 g212gs. All rights reserved.
//

import Foundation

class WebAPISession: NSObject {

    lazy var configurationCustom: URLSessionConfiguration = URLSessionConfiguration.default
    lazy var session: URLSession = URLSession(configuration: self.configurationCustom)
    
    typealias webServiceResponceHandler =  ((Data?, Error?) -> Void)
    typealias webServiceRequestHandler = ((NSURLRequest?, Error?) -> Void)
    
    // MARK: - Web Service Call Method
    public func callWebAPI(wsType:WSType, bodyType: BodyType, filePathKey: String?, webURLString: String, parameter: Dictionary<String, Any>, completion:
        @escaping webServiceResponceHandler) {
        
        // Set up the URL request
        guard let url = URL(string: webURLString) else {
            completion(nil, ErrorListings.kInvalidURL)
            return
        }
        
        var urlRequest = URLRequest.init(url: url, cachePolicy: .useProtocolCachePolicy
            , timeoutInterval: 30)
        urlRequest.allowsCellularAccess = true // For allow mobile data
        urlRequest.httpMethod = wsType.rawValue
        urlRequest.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
        
        switch wsType {
        case .GET:
            urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
            
            var urlSuffix = ""
            // Set up the Web URL for URLRequest for GET
            let parameterString = parameter.stringFromHttpParameters()
            if parameterString.count > 0 {
                urlSuffix = "?\(parameterString)"
            }
            
            guard let urlLegal = URL(string: webURLString + urlSuffix) else {
                completion(nil, ErrorListings.kInvalidURL)
                return
            }
            urlRequest.url = urlLegal
            print("Request URL: \(String(describing: urlRequest.url))")
            
            self.webAPI(urlRequest: urlRequest) { (responce, error) in
                completion(responce, error)
            }
            
            break
        case .POST:
            switch bodyType {
            case .row_Application_Json:
                // Set up the http body for URLRequest
                urlRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
                
                self.preparePostParameters(parameter: parameter, urlRequest: urlRequest, completion: { (urlRequestObj, error) in
                    
                    if error != nil {
                        completion(nil, error)
                    }
                    else {
                        urlRequest = urlRequestObj! as URLRequest
                        
                        self.webAPI(urlRequest: urlRequest) { (responce, error) in
                            completion(responce, error)
                        }
                    }
                })
                break
            case .multipart:
                let boundary = "Boundary-\(UUID().uuidString)"
                urlRequest.setValue("\(bodyType.rawValue); boundary=\(boundary)"
                    , forHTTPHeaderField: "Content-Type")
                
                urlRequest.httpBody = createMultiPartFormDataBody(parameters: parameter, boundary: boundary, filepath: filePathKey)
                
                self.webAPI(urlRequest: urlRequest) { (responce, error) in
                    completion(responce, error)
                }
            case .wwwFormUnreloaded:
                urlRequest.addValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
                
                urlRequest.encodeParameters(parameters: parameter as! [String : String])
                
                self.webAPI(urlRequest: urlRequest) { (responce, error) in
                    completion(responce, error)
                }
            default:
                break
            }
        }
    }
    
    
    // MARK: - Web Service Engine
    func webAPI(urlRequest: URLRequest, completion: @escaping webServiceResponceHandler) {
        
        // Check internet
        if ReachabilityManager.shared.reachability.connection != .unavailable {
            let task = self.session.dataTask(with: urlRequest, completionHandler: { (data, response, error) in
                completion(data, error)
            })
            task.resume()
        } else {
            completion(nil, ErrorListings.kNoInterNetConnection)
        }
    }
    
    // MARK: - Helper for "POST"
    func preparePostParameters(parameter: Dictionary<String, Any>, urlRequest: URLRequest, completion:
        @escaping webServiceRequestHandler) {
        do {
            let jsonData = try JSONSerialization.data(withJSONObject: parameter, options: [])
            print("Request URL: \(String(describing: urlRequest.url))")
            
            var urlRequestObj = urlRequest
            urlRequestObj.httpBody = jsonData
            
            completion(urlRequestObj as NSURLRequest, nil)
        } catch {
            print("JSON serialization failed:  \(error)")
            completion(nil, error)
        }
    }
    
    // MARK: -  Helper for "multipart/form-data"
    func createMultiPartFormDataBody(parameters: [String: Any],
                                     boundary: String,
                                     filepath: String?) -> Data {
        
        let body = NSMutableData()
        let boundaryPrefix = "--\(boundary)\r\n"
        
        if let fileContentKey = filepath {
            for (key,value) in parameters {
                
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\(key)")
                
                if fileContentKey == key {
                    do {
                        if let filePathURL = value as? String, let assetURL = URL(string: filePathURL) {
                            let data = try Data(contentsOf: assetURL, options: NSData.ReadingOptions.alwaysMapped)
                            
                            var contentType = "image/jpeg"
                            if let swimeObj: MimeType = Swime.mimeType(data: data) {
                                contentType = swimeObj.mime
                            }
                            let fileName = (value as! NSString).lastPathComponent
                            
                            body.appendString("; filename=\"\(fileName)\"\r\n")
                            body.appendString("Content-Type: \(contentType)\r\n\r\n")
                            body.append(data)
                            body.appendString("\r\n")
                            body.appendString("--".appending(boundary.appending("--")))
                        }
                    } catch let error {
                        // contents could not be loaded
                        print("Error while fetch file: \(error.localizedDescription)")
                    }
                } else {
                    // for other value
                    body.appendString("\r\n\r\n\(value)")
                }
            }
        } else {
            for (key,value) in parameters {
                body.appendString(boundaryPrefix)
                body.appendString("Content-Disposition: form-data; name=\(key)")
                body.appendString("\r\n\r\n\(value)")
            }
        }
        return body as Data
    }
}
