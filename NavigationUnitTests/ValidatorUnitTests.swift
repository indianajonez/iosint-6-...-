//
//  ValidatorUnitTests.swift
//  NavigationUnitTests
//
//  Created by Ekaterina Saveleva on 06.09.2023.
//

import XCTest
@testable import Navigation



final class ValidatorUnitTests: XCTestCase {
    
    
    func testEmailNoDomain() {
        let validatir = Validator.shared
        let email = "Test@mail"
        
        let result = validatir.checkMail(email)
        
        XCTAssertEqual(result, false)
    }
    
    func testEmailAt() {
        let validator = Validator.shared
        let email = "Testmail.ru"
        
        let result = validator.checkMail(email)
        
        XCTAssertEqual(result, false)
    }
    
    func testPasswordNotFeild() {
        let validator = Validator.shared
        let password = ""
        
        let result = validator.checkPassword(password)
        
        XCTAssertEqual(result, false)
    }
}
   



