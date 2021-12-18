//
//  DataProviderTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 16.12.2021.
//

import XCTest
@testable import ToDoApp

class DataProviderTests: XCTestCase {

    var sut: DataProvider!
    var tableView: UITableView!
    var controller: TaskListViewController!
    
    override func setUpWithError() throws {
        sut = DataProvider()
        sut.taskManager = TaskManager()
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        controller = storyBoard.instantiateViewController(identifier: String(describing: TaskListViewController.self)) as? TaskListViewController
        controller.loadViewIfNeeded()
        tableView = controller.tableView
        tableView.dataSource = sut
        tableView.delegate = sut
    }
    override func tearDownWithError() throws {
    }

    func testNumberOfSection(){
        let numberOfSections = tableView.numberOfSections
        XCTAssertEqual(numberOfSections, 2)
    }
    
    func testNumberOfRowsInSectionZeroIsTaskCount() {
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.add(task: Task(title: "Baz"))
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 0), 2)
    }
    
    func testNumberOfRowsInSectionOneIsDoneTaskCount() {
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        sut.taskManager?.add(task: Task(title: "Baz"))
        sut.taskManager?.checkTask(at: 0)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        XCTAssertEqual(tableView.numberOfRows(inSection: 1), 2)
    }
    
    func testCellForRowAtIndexPathReturnTaskCell() {
        sut.taskManager?.add(task: Task(title: "Foo"))
        tableView.reloadData()
        let cell  = tableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(cell is TaskCell)
    }
    
    func testCellForRowInIndexPathDequeuesFromTableView() {
        let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
        mockTableView.dataSource = sut
        mockTableView.register(TaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
        
        sut.taskManager?.add(task: Task(title: "Foo"))
        mockTableView.reloadData()
        
        _ = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0))
        
        XCTAssertTrue(mockTableView.cellIsDequeued)
    }
    
    func testCellForRowInSectionZeroCallsConfigure() {
        
        let task = Task(title: "Foo")
        let mockTableView = MockTableView.mockTableView(withDataSouce: sut)
        
        sut.taskManager?.add(task: task)
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 0)) as? MockTaskCell
        
        XCTAssertEqual(task, cell?.task)
        
    }
    
    func testCellForRowInSectionOneCallsConfigure() {
        
        let mockTableView = MockTableView.mockTableView(withDataSouce: sut)
        let task = Task(title: "Foo")
        let task2 = Task(title: "Bar")
        
        sut.taskManager?.add(task: task)
        sut.taskManager?.add(task: task2)
        sut.taskManager?.checkTask(at: 0)
       
        mockTableView.reloadData()
        
        let cell = mockTableView.cellForRow(at: IndexPath(row: 0, section: 1)) as! MockTaskCell
        
        XCTAssertEqual(cell.task, task)
        
    }
    
    func testDeleteButtonZeroShowsDone() {
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(buttonTitle, "Done")
    }
    func testDeleteButtonOneShowsDone() {
        let buttonTitle = tableView.delegate?.tableView?(tableView, titleForDeleteConfirmationButtonForRowAt: IndexPath(row: 0, section: 1))
        
        XCTAssertEqual(buttonTitle, "Undone")
    }
    
    func testCheckingTaskChecksInTaskManager() {
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 0))
        
        XCTAssertEqual(sut.taskManager?.taskCount, 0)
        XCTAssertEqual(sut.taskManager?.doneTaskCount, 1)
    }
    
    func testUnCheckingTaskUnChecksInTaskManager() {
        let task = Task(title: "Foo")
        sut.taskManager?.add(task: task)
        sut.taskManager?.checkTask(at: 0)
        tableView.reloadData()
        
        tableView.dataSource?.tableView?(tableView, commit: .delete, forRowAt: IndexPath(row: 0, section: 1))
        
        
        XCTAssertEqual(sut.taskManager?.taskCount, 1)
        XCTAssertEqual(sut.taskManager?.doneTaskCount, 0)
    }
    
}

extension DataProviderTests {
    class MockTableView: UITableView {
        var cellIsDequeued = false
        static func mockTableView(withDataSouce: UITableViewDataSource) -> MockTableView {
            let mockTableView = MockTableView(frame: CGRect(x: 0, y: 0, width: 100, height: 100), style: .plain)
            mockTableView.dataSource = withDataSouce
            mockTableView.register(MockTaskCell.self, forCellReuseIdentifier: String(describing: TaskCell.self))
            return mockTableView
        }
        
        override func dequeueReusableCell(withIdentifier identifier: String, for indexPath: IndexPath) -> UITableViewCell {
            cellIsDequeued = true
            return super.dequeueReusableCell(withIdentifier: identifier, for: indexPath)
        }
    }
}

class MockTaskCell: TaskCell {
    var task: Task?
    
    override func configure(withTask task: Task, done: Bool = false) {
        self.task = task
    }
    
}
