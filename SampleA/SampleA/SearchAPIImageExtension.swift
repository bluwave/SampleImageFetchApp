//
//  SearchAPIImageExtension.swift
//  SampleA
//
//  Created by Garrett Richards on 12/16/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import Foundation

extension SearchAPIImage {
    func flickrURL() -> URL {
//        http://farm{farm-id}.staticflickr.com/{server-id}/{id}_{secret}.jpg
        
        return URL(string: "http://farm\(farm).staticflickr.com/\(server)/\(id)_\(secret).jpg")!
    }
}
