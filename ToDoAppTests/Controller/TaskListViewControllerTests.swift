//
//  TaskListViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 16.12.2021.
//

import XCTest
@testable import ToDoApp

class TaskListViewControllerTests: XCTestCase {
    var sut: TaskListViewController!
    override func setUpWithError() throws {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
         let vc = storyBoard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self))
         sut = vc as? TaskListViewController
         
         sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testTableViewDontNillWhenViewIsLoaded() {
        XCTAssertNotNil(sut.tableView)
    }

    func testWhenViewIsLoadedDataProviderIsNotNil() {
         XCTAssertNotNil(sut.dataProvider)
    }
    
    func testWhenViewIsLoadedTVDelegateIsSet() {
        XCTAssertTrue(sut.tableView.delegate is DataProvider)
    }
    func testWhenViewIsLoadedTVDataSourseIsSet() {
        XCTAssertTrue(sut.tableView.dataSource is DataProvider)
    }
    
    func testWhenViewIsLoadedTableViewDelegateEqualDataSourse() {
        XCTAssertEqual(sut.tableView.dataSource as? DataProvider,
                       sut.tableView.delegate as? DataProvider)
    }
}
