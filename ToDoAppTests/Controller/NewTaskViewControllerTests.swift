//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 18.12.2021.
//

import XCTest
@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {

    var sut: NewTaskViewController!
    
    override func setUpWithError() throws {
       let storyboard = UIStoryboard(name: "Main", bundle: nil)
        sut = storyboard.instantiateViewController(withIdentifier: String(describing: NewTaskViewController.self)) as? NewTaskViewController
        sut.loadViewIfNeeded()
        
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testHasTitleTestField() {
        XCTAssertTrue(sut.titleTextfield.isDescendant(of: sut.view))
    }
    func testHasLocationTestField() {
        XCTAssertTrue(sut.locationTextfield.isDescendant(of: sut.view))
    }
    func testHasDateTestField() {
        XCTAssertTrue(sut.dateTextfield.isDescendant(of: sut.view))
    }
    func testHasAdressTestField() {
        XCTAssertTrue(sut.adressTextfield.isDescendant(of: sut.view))
    }
    func testHasDescriptionTestField() {
        XCTAssertTrue(sut.locationTextfield.isDescendant(of: sut.view))
    }
    func testHasSaveButton() {
        XCTAssertTrue(sut.saveButton.isDescendant(of: sut.view))
    }
    func testHasCancellButton() {
        XCTAssertTrue(sut.cancellButton.isDescendant(of: sut.view))
    }
}
