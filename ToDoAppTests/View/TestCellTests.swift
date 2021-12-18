//
//  TestCellTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 17.12.2021.
//

import XCTest
import CoreLocation
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
    
    func testCellHasDateLabel() {
        XCTAssertNotNil(cell.dateLabel)
    }
    
    func testCellHasDateInContentView() {
        XCTAssertTrue(cell.dateLabel.isDescendant(of: cell.contentView))//что то есть на контент вью
    }
    func testCellHasLocationLabel() {
        XCTAssertNotNil(cell.locationLabel)
    }
    
    func testCellHasLocationInContentView() {
        XCTAssertTrue(cell.locationLabel.isDescendant(of: cell.contentView))//что то есть на контент вью
    }
    func testConfigureSetsTitle(){
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        XCTAssertEqual(task.title, cell.titleLabel.text)
    }
    
    func testConfigureSetsDate() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task)
        let df = DateFormatter() //nsdateformatter.com
        df.dateFormat = "dd.MM.yy"
        let date = task.date
        let dateString = df.string(from: date)
        
        XCTAssertEqual(cell.dateLabel.text, dateString)
    }
    
    func testConfigureLocationSets() {
        let task = Task(title: "Foo", location: Location(name: "Home", coordinates: CLLocationCoordinate2D(latitude: 1, longitude: 1)))
        cell.configure(withTask: task)
        XCTAssertEqual(cell.locationLabel.text, task.location?.name)
    }
    
    func configureCellWithTask() {
        let task = Task(title: "Foo")
        cell.configure(withTask: task, done: true)
    }
    
    func testDoneTaskShouldStrikeThrow() {
        configureCellWithTask()
        let attributeString = NSAttributedString(string: "Foo", attributes: [NSAttributedString.Key.strikethroughStyle : NSUnderlineStyle.single.rawValue])
        XCTAssertEqual(cell.titleLabel.attributedText, attributeString)
    }
    
    func testDoneDateLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.dateLabel)
    }
    func testDoneLocationLabelEqualsNil() {
        configureCellWithTask()
        XCTAssertNil(cell.locationLabel)
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
