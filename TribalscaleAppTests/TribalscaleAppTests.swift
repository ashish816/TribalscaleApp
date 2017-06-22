//
//  TribalscaleAppTests.swift
//  TribalscaleAppTests
//
//  Created by Ashish Mishra on 6/21/17.
//  Copyright © 2017 Ashish Mishra. All rights reserved.
//

import XCTest
import Alamofire
@testable import TribalscaleApp

class TribalscaleAppTests: XCTestCase {
    var userListViewController : ViewController?
    
    override func setUp() {
        super.setUp()
        userListViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserList") as? ViewController
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
   
    func testUserApiConnection() {
        let randomUserUrl = "https://randomuser.me/api/?results=500"
        
           let promise = expectation(description: "Completion handler invoked")
        
        Alamofire.request(randomUserUrl, method: .get, parameters: nil, encoding: JSONEncoding.default).response { (response) in
            if statusCode == 200 {
                // 2
                promise.fulfill()
            } else {
                XCTFail("Status code: \(statusCode)")
            }
        }
        waitForExpectations(timeout: 5, handler: nil)

    }
    
    func testNumberOfUsers() {
        XCTAssertEqual(self.userListViewController?.userList.count, 500)
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
