//
//  SampleATests.swift
//  SampleATests
//
//  Created by Garrett Richards on 12/15/16.
//  Copyright © 2016 Acme. All rights reserved.
//

import XCTest
@testable import SampleA

class SampleATests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testExample() {
        let client = APIClient()
        let expectationA = expectation(description: "temp")
        client.searchForImages(searchText: "dog") { (images, error) in
            print("images: \(images)")
            print("error: \(error)")
            expectationA.fulfill()
        }
        waitForExpectations(timeout: 4.0)
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
