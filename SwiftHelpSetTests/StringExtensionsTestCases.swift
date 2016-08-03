//
//  StringExtensionsTestCases.swift
//  SwiftHelpSet
//
//  Created by Luca D'Alberti on 8/3/16.
//  Copyright © 2016 dalu93. All rights reserved.
//

import XCTest
@testable import SwiftHelpSet

class StringExtensionsTestCases: XCTestCase {

    override func setUp() {
        super.setUp()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testCorrectPhoneNumber() {
        let phoneNumber = "+1 123 456 7890"
        XCTAssert(phoneNumber.isPhoneNumber, "\(phoneNumber) is a correct phone number. It should return true")
    }
    
    func testUncorrectPhoneNumber() {
        let phoneNumber = "+1 123 456YTFYygd7890"
        XCTAssert(phoneNumber.isPhoneNumber == false, "\(phoneNumber) is not a correct phone number. It should return false")
    }
    
    func testIsBlankWithBlankString() {
        let string = ""
        XCTAssert(string.isBlank, "The string passed is really empty. Should return true")
    }
    
    func testIsBlankWithSpaceString() {
        let string = "      "
        XCTAssert(string.isBlank == true, "The string, even if it has spaces inside, it's really blank. Should return true")
    }
    
    func testIsBlankWithNonBlankString() {
        let string = " sdfdfg fg fg  "
        XCTAssert(string.isBlank == false, "The string is not empty. Should return false")
    }
    
    func testCorrectEmail() {
        let email = "test@test.com"
        XCTAssert(email.isEmail, "The email (\(email)) is a real email. Should return true")
    }
    
    func testCorrectEmailWithSpaces() {
        let emailWithSpaces = "  test@test.it"
        XCTAssert(emailWithSpaces.isEmail, "The email has spaces, but at the start and/or at the end. The utility trims the string before.")
    }
    
    func testUncorrectWithSpacesInsideEmail() {
        let email = "test @test.it"
        XCTAssert(email.isEmail == false, "The email has spaces inside the string. It cannot be accepted as email")
    }
    
    func testUncorrectEmail() {
        let email = "test*&%%$%$%.it"
        XCTAssert(email.isEmail == false, "The string isn't an email at all.")
    }
}
