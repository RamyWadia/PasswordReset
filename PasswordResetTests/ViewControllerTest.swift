//
//  ViewControllerTest.swift
//  PasswordResetTests
//
//  Created by Ramy Atalla on 2022-06-14.
//

import XCTest
@testable import PasswordReset

class ViewControllerTests_NewPassword_Validation: XCTestCase {
    
    var vc: ViewController!
    let validPassword = "12345Aa!"
    let tooShortPassword = "123Aa!"
    
    override func setUp() {
        super.setUp()
        
        vc = ViewController()
    }
    
    func testEmplptyPassword() throws {
        vc.newPasswordText = ""
        vc.resetPasswordButtonTapped()
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text!, "Enter your password")
    }
    
    func testInvalidPassword() throws {
        vc.newPasswordText = "12345_"
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Enter valid special chars (.,@:?!()$\\/#) with no spaces")
    }
    
    func testCriteriaNotMet() throws {
        vc.newPasswordText = tooShortPassword
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "Your password must meet the requirements below")
    }
    
    func testValidPassword() throws {
        vc.newPasswordText = validPassword
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.newPasswordTextField.errorLabel.text, "")
    }

}

class ViewControllerTests_Confirm_Password_Validation: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testEmptyPassword() throws {
        vc.confirmPasswordText = ""
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Enter your password.")
    }
    
    func testPasswordsDoNotMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "Passwords do not match.")
    }

    func testPasswordsMatch() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped()
        
        XCTAssertEqual(vc.confirmPasswordTextField.errorLabel.text!, "")
    }
}

class ViewControllerTests_Show_Alert: XCTestCase {

    var vc: ViewController!
    let validPassword = "12345678Aa!"
    let tooShort = "1234Aa!"
    
    override func setUp() {
        super.setUp()
        vc = ViewController()
    }
    
    func testShowSuccess() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = validPassword
        vc.resetPasswordButtonTapped()

        XCTAssertNotNil(vc.alert)
        XCTAssertEqual(vc.alert!.title, "Success") // Optional
    }

    func testShowError() throws {
        vc.newPasswordText = validPassword
        vc.confirmPasswordText = tooShort
        vc.resetPasswordButtonTapped()

        XCTAssertNil(vc.alert)
    }
}
