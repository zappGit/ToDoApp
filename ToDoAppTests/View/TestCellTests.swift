//
//  TestCellTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 17.12.2021.
//

import XCTest
@testable import ToDoApp

class TestCellTests: XCTestCase {
    var cell: TaskCell!
    override func setUpWithError() throws {
        let stotyBoard = UIStoryboard(name: "Main", bundle: nil)
        let controller = stotyBoard.instantiateViewController(withIdentifier: String(describing: TaskListViewController.self)) as! TaskListViewController
        controller.loadViewIfNeeded()
        
        let tableView = controller.tableView
        let dataSource = FakeDataSourse()
        tableView?.dataSource = dataSource
        
        cell = tableView?.dequeueReusableCell(withIdentifier: String(describing: TaskCell.self), for: IndexPath(row: 0, section: 0)) as? TaskCell
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testCellHasTitleLabel() {
        XCTAssertNotNil(cell.titleLabel)
    }
    
    func testCellHasTitleInContentView() {
        XCTAssertTrue(cell.titleLabel.isDescendant(of: cell.contentView))//что то есть на контент вью
    }

}

extension TestCellTests {
    class FakeDataSourse: NSObject, UITableViewDataSource {
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            return UITableViewCell()
        }
        
        
    }
}
