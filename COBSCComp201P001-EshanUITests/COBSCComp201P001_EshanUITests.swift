//
//  COBSCComp201P001_EshanUITests.swift
//  COBSCComp201P001-EshanUITests
//
//  Created by Eshan Gallage on 2021-10-26.
//

import XCTest

class COBSCComp201P001_EshanUITests: XCTestCase {

    var app: XCUIApplication!
    override func setUp() {
            continueAfterFailure = false
            app = XCUIApplication()
            app.launch()
    //        XCUIApplication().tabBars["Tab Bar"].children(matching: .button).matching(identifier: "Login").element(boundBy: 0)
        }
        
        override func tearDown() {
            app = nil
        }
    func testLoginViewElementExistance(){
                            
          
            
            let Login_Email_Field = app.textFields["Email_Text"]
            let Login_Pass_Field = app.secureTextFields["Pass_Text"]
            let Login_Btn = app.buttons["Sign_In_Btn"]
            let Signup_Btn = app.buttons["Sign_Up_Btn"]
            
            XCTAssertTrue(Login_Email_Field.exists, "Email textbox is available!")
            XCTAssertTrue(Login_Pass_Field.exists, "Password textbox is available!")
            XCTAssertTrue(Login_Btn.exists, "Login button is available!")
            XCTAssertTrue(Signup_Btn.exists, "Sign up button is available!")
            
        
     }
  

}
