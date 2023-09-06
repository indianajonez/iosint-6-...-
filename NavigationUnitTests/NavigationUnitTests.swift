//
//  NavigationUnitTests.swift
//  NavigationUnitTests
//
//  Created by Ekaterina Saveleva on 06.09.2023.
//

import XCTest
@testable import Navigation
import Realm
import FirebaseAuth
import FirebaseCore


final class NavigationUnitTests: XCTestCase {

    func testCheckAuthAsync() throws {
        
        var login: String = "katay@mail.ru"
        var pass: String = ""
        
        var validateResult: Bool = false
        let expectedResult: Bool = true
             
        let validatorExpectation = expectation(description: "Expectation in " + #function)
        
        CheckerService().checkCredentials(email: login, pass: pass) { user, errorString in
            guard errorString == nil else {
                validateResult = false
                return
            }
            
            guard let user else {
                validateResult = false
                return
            }
            
            validateResult = true
            validatorExpectation.fulfill()
        }
        
        waitForExpectations(timeout: 1.0) { _ in
            XCTAssertEqual(validateResult, expectedResult)
        }
    }

    func testCheckSmth() throws {}
}
