//
//  ImageModel.swift
//  SampleA
//
//  Created by Garrett Richards on 12/16/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import Foundation
import Mapper

struct SearchAPIImageResponseModel: Mappable {
    //  {"photos":{"page":1,"pages":3166,"perpage":100,"total":"316531","photo"} , "stat": "ok"
    
    var images = [SearchAPIImage]()
    var page = 0
    var numberOfPages = 0
    var pageSize = 0
    var total = 0
    
    public init(map: Mapper) throws {
        //  FIXME: - rethink these keypaths, put into constants
        images = map.optionalFrom("photos.photo") ?? []
        page = map.optionalFrom("photos.page") ?? page
        numberOfPages = map.optionalFrom("photos.pages") ?? numberOfPages
        pageSize = map.optionalFrom("photos.perpage") ?? pageSize
        total = map.optionalFrom("photos.total") ?? total
    }
}

struct SearchAPIImage: Mappable {
//    "id":"31568320821","owner":"108632805@N06","secret":"c334b9fcbc","server":"388","farm":1,"title":"","ispublic":1,"isfriend":0,"isfamily":0}
    var id: Int = 0
    var owner = ""
    var secret = ""
    var server = ""
    var farm = ""
    var title = ""
    
    public init(map: Mapper) throws {
        //  FIXME: - rethink these keypaths, put into constants
        id = map.optionalFrom("id") ?? id
        owner = map.optionalFrom("owner") ?? owner
        secret = map.optionalFrom("secret") ?? secret
        server = map.optionalFrom("server") ?? server
        farm = map.optionalFrom("farm") ?? farm
        title = map.optionalFrom("title") ?? title
    }
}
