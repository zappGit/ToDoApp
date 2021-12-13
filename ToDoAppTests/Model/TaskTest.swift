//
//  TaskTest.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 11.12.2021.
//

import XCTest
@testable import ToDoApp

class TaskTest: XCTestCase {

    func testInitTaskWithTitle() {
        let task = Task(title: "Foo")//Foo Bar Buz
        XCTAssertNotNil(task)
    }
    func testInitTaskWithTitleAndDescription() {
        let task = Task(title: "Foo", description: "Bar")//Foo Bar Buz
        XCTAssertNotNil(task)
    }
    func testWhenGivenTitleSetsTitle() {
        let task = Task(title: "Foo")
        
        XCTAssertEqual(task.title, "Foo")
    }
    
    func testWhenGivenDescriptionSetsDescription() {
        let task = Task(title: "Foo", description: "Bar")
        XCTAssertTrue(task.description == "Bar")
    }
    
    func testTaskInitsWithDate() {
        let task = Task(title: "Foo", description: "Foo")
        XCTAssertNotNil(task.date)
    }
    func testWhenGivenLocationSetsLocation() {
        let location = Location(name: "Foo")
        let task = Task(title: "Foo",
                        description: "Foo",
                        location: location)
        XCTAssertEqual(location, task.location)
    }
    
}
