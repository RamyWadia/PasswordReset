//
//  PasswordStatusViewTest.swift
//  PasswordResetTests
//
//  Created by Ramy Atalla on 2022-06-14.
//

import XCTest
@testable import PasswordReset

class PasswordStatusViewTests_ShowCheckmarkOrRest_When_Validation_Is_Inline: XCTestCase {
    
    var statusView: PasswordStatusView!
    let validPassword = "12345Aa!"
    let tooShortPassword = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = true
    }
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    func testTooShort() throws {
        statusView.updateDisplay(tooShortPassword)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertFalse(statusView.lengthCriteriaView.isCheckMarkImage)
        XCTAssertTrue(statusView.lengthCriteriaView.isResetImage)
    }
}

class PasswordStatusViewTests_ShowCheckMarkOrRedX_When_Validation_Is_Loss_Of_Focus: XCTestCase {
    var statusView: PasswordStatusView!
    let validPassword = "12345Aa!"
    let tooShortPassword = "123Aa!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
        statusView.shouldResetCriteria = false
    }
    
    func testValidPassword() throws {
        statusView.updateDisplay(validPassword)
        XCTAssertTrue(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isCheckMarkImage)
    }
    
    func testInvalidPassword() throws {
        statusView.updateDisplay(tooShortPassword)
        XCTAssertFalse(statusView.lengthCriteriaView.isCriteriaMet)
        XCTAssertTrue(statusView.lengthCriteriaView.isXmarkImage)
    }
}

class PasswordStatusViewTests_Validate_ThreeOfFour: XCTestCase {
    
    var statusView: PasswordStatusView!
    let twoOfFour = "1234567A"
    let threeOfFour = "123456aA"
    let fourOfFour = "12345aA!"
    
    override func setUp() {
        super.setUp()
        statusView = PasswordStatusView()
    }
    
    func testTwoOfFour() throws {
        XCTAssertFalse(statusView.validate(twoOfFour))
    }
    
    func testThreeOfFour() throws {
        XCTAssertTrue(statusView.validate(threeOfFour))
    }
    
    func testFourOfFour() throws {
        XCTAssertTrue(statusView.validate(fourOfFour))
    }
    
}
