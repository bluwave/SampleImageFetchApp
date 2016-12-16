//
//  APIClient.swift
//  SampleA
//
//  Created by Garrett Richards on 12/15/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import Foundation
import Alamofire

typealias APIHandler = (NSError?) -> Void
typealias URLParameters = [String: Any]

enum APIEndpoint {
    case example(String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .example:
            return .get
        }
    }
    
    var path: String? {
        switch self {
        case .example(let params):
            return "/example"
        }
    }
}

class URLRequestFactory {
    func constructRequest(for endPoint: APIEndpoint) -> Foundation.URLRequest {
        let mutableURLRequest = constructDefaultURL(endPoint)
        let params = parametersForEndpoint(endPoint)
        do {
            return try Alamofire.JSONEncoding.default.encode(mutableURLRequest, with: params)
        }
        catch {
            //  FIXME: - may want to do soem error handling here
            return Foundation.URLRequest(url:Foundation.URL(string: "")!)
        }
    }
    
    private func constructDefaultURL(_ endPoint: APIEndpoint) -> Foundation.URLRequest {
        var url = Foundation.URL(string: baseURL())!
        if let path = endPoint.path {
            url = url.appendingPathComponent(path)
        }
        var mutableURLRequest = Foundation.URLRequest(url: url)
        mutableURLRequest.httpMethod = endPoint.method.rawValue
        return mutableURLRequest
    }
    
    private func parametersForEndpoint(_ endPoint: APIEndpoint) -> URLParameters {
        var params: URLParameters = URLParameters()
        
        switch endPoint {
            
        case .example(let exampleParameter):
            // add any URL parameters
            break
        }
        return params
    }
    
    private func baseURL() -> String {
        return "http://localhost/api/v1"
    }
}

class APIClient {
    var sessionManager: SessionManager = SessionManager()
    var urlRequestFactory = URLRequestFactory()
    
    func exampleRequest(handler: @escaping APIHandler) {
        let urlRequest = urlRequestFactory.constructRequest(for: .example("foobar"))
        
        sessionManager.request(urlRequest).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let json = json as? NSDictionary {
                    
                }
                else {
                    
                }
            case .failure(let error):
                break
            }
        }
    }
}
