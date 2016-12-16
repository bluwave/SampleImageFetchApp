//
//  APIClient.swift
//  SampleA
//
//  Created by Garrett Richards on 12/15/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import Foundation
import Alamofire

typealias URLParameters = [String: Any]
typealias APIClientImageSearchHandler = ([SearchAPIImage]? , NSError?) -> Void

enum APIEndpoint {
    case search(String)
    
    var method: Alamofire.HTTPMethod {
        switch self {
        case .search:
            return .get
        }
    }
    
    var path: String? {
        switch self {
        case .search( _):
            return nil
        }
    }
}

class URLRequestFactory {
    func constructRequest(for endPoint: APIEndpoint) -> Foundation.URLRequest {
        let mutableURLRequest = constructDefaultURL(endPoint)
        let params = parametersForEndpoint(endPoint)
        do {
            return try Alamofire.URLEncoding.default.encode(mutableURLRequest, with: params)
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
        params["api_key"] = "3e7cc266ae2b0e0d78e279ce8e361736" // FIXME: - this should be more at a class level for all requests
        params["format"] = "json"
        params["nojsoncallback"] = 1
        params["safe_search"] = 1
        
        switch endPoint {
            
        case .search(let search):
               //?method=flickr.photos.search&api_key=3e7cc266ae2b0e0d78e279ce8e361736&format=json&nojsoncallback=1&safe_search=1&text=dog
            params["method"] = "flickr.photos.search" //  FIXME: - abstract this method stuff out so other actions can be queried on API
            params["text"] = search //   FIXME: - do we need any cleaning or scrubbing of this search input
            break
        }
        return params
    }
    
    private func baseURL() -> String {
        return "https://api.flickr.com/services/rest/"
    }
}

class APIClient {
    var sessionManager: SessionManager = SessionManager()
    var urlRequestFactory = URLRequestFactory()
    
    func searchForImages(searchText: String, handler: @escaping APIClientImageSearchHandler) {
        let urlRequest = urlRequestFactory.constructRequest(for: .search(searchText))
        print("url: \(urlRequest.url?.absoluteString)")
        sessionManager.request(urlRequest).responseJSON { response in
            switch response.result {
            case .success(let json):
                if let json = json as? NSDictionary, let responseModel = SearchAPIImageResponseModel.from(json) {
                    print("responseMode: \(responseModel)")
                    handler(responseModel.images, nil)
                }
                else {
                    assertionFailure("could not parse json into expected models")
                    let error = NSError.internalError(message: "could not parse json into expected models")
                    handler(nil, error)
                }
            case .failure(let error):
                handler(nil, error as NSError?)
            }
        }
    }
}
