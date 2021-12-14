//
//  TaskManagerTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 14.12.2021.
//

import XCTest
@testable import ToDoApp

class TaskManagerTests: XCTestCase {
    var sut: TaskManager! // system under test
    override func setUpWithError() throws {
        sut = TaskManager()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testInitTaskManagerWithZeroTask() {
        XCTAssertEqual(sut.taskCount, 0)
    }
    
    func testInitTaskManagerWithZeroDoneTask() {
        XCTAssertEqual(sut.doneTaskCount, 0)
    }
    
    func testAddTaskIncrementTaskCount() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        XCTAssertEqual(sut.taskCount, 1)
    }
    
    func testTaskAtIndexAddedTask() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        let returnedTask = sut.task(at: 0)
        XCTAssertEqual(task.title, returnedTask.title)
    }
    
    func testCheckTaskAtIndexChangeCounts() {
        let task = Task(title: "Foo")
        sut.add(task: task)
        
        sut.checkTask(at: 0)
        XCTAssertEqual(sut.taskCount, 0)
        XCTAssertEqual(sut.doneTaskCount, 1)
    }
    
    func testTaskRemoveFromTasks(){
        let firstTask = Task(title: "Foo")
        let secondTask = Task(title: "Baz")
        
        sut.add(task: firstTask)
        sut.add(task: secondTask)
        
        sut.checkTask(at: 0)
        
        XCTAssertEqual(sut.task(at: 0), secondTask)
    }
    
    func testDoneTaskAtReturnsCheckedTasks() {
        let task = Task(title: "Foo")
        
        sut.add(task: task)
        sut.checkTask(at: 0)
        
        let returnedTask = sut.doneTask(at: 0)
        
        XCTAssertEqual(returnedTask, task)
    }
    
    func testRemoveAllResultsCountsBeZero() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Baz"))
        
        sut.checkTask(at: 0)
        sut.removeAll()
        XCTAssertEqual(sut.taskCount as Int?, 0)
        XCTAssertEqual(sut.doneTaskCount as Int?, 0)
    }
    
    func testAddingSameObjectDoesNotIncrimentCount() {
        sut.add(task: Task(title: "Foo"))
        sut.add(task: Task(title: "Foo"))
        
        XCTAssertEqual(sut.taskCount as Int?, 1)
    }

}
