//
//  DetailViewControllerTest.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 18.12.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp


class DetailViewControllerTest: XCTestCase {

    var sut: DetailViewController!
    
    override func setUpWithError() throws {
        let storuboard = UIStoryboard(name: "Main", bundle: nil)
        sut =  storuboard.instantiateViewController(identifier: String(describing: DetailViewController.self)) as? DetailViewController
        sut.loadViewIfNeeded()
    }

    override func tearDownWithError() throws {
        sut = nil
    }

    func testHasTitleLabel() {
        XCTAssertNotNil(sut.titleLabel)
        XCTAssertTrue(sut.titleLabel.isDescendant(of: sut.view))
    }
    
    func testHasDescriptionLabel() {
        XCTAssertNotNil(sut.descriptionLabel)
        XCTAssertTrue(sut.descriptionLabel.isDescendant(of: sut.view))
    }

    func testHasDateLabel() {
        XCTAssertNotNil(sut.dateLabel)
        XCTAssertTrue(sut.dateLabel.isDescendant(of: sut.view))
    }
    
    func testHasLocationLabel() {
        XCTAssertNotNil(sut.locationLabel)
        XCTAssertTrue(sut.locationLabel.isDescendant(of: sut.view))
    }
    func testHasMapView() {
        XCTAssertNotNil(sut.mapView)
        XCTAssertTrue(sut.mapView.isDescendant(of: sut.view))
    }
    func setupTaskAndAppearenceTransition(){
        let coordinats = CLLocationCoordinate2D(latitude: 54.748, longitude: 56.011)
        let location = Location(name: "Baz", coordinates: coordinats)
        let date = Date(timeIntervalSince1970: 1546300800)
        let task = Task(title: "Foo", date: date,  description: "Bar", location: location)
        sut.task = task
        
        sut.beginAppearanceTransition(true, animated: true)//view will appear
        sut.endAppearanceTransition()
        
    }
    func testSettingTasksSetsTitleLabel() {
        
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.titleLabel.text, "Foo")

    }
    func testSettingTasksSetsDescriptionLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.descriptionLabel.text, "Bar")
    }
    
    func testSettingTasksSetsLocationLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.locationLabel.text, "Baz")
    }
    
    func testSettingTasksSetsDateLabel() {
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.dateLabel.text, "01.01.19")
    }
    
    func testSettingTasksSetsMapView(){
        setupTaskAndAppearenceTransition()
        XCTAssertEqual(sut.mapView.centerCoordinate.latitude, 54.748, accuracy: 0.01)
        XCTAssertEqual(sut.mapView.centerCoordinate.longitude, 56.011, accuracy: 0.01)
    }
    
}
