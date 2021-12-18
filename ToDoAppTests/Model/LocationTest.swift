//
//  LocationTest.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 13.12.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class LocationTest: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testSetName() {
        let name = "Foo"
        
        let location = Location(name: name)
        
        XCTAssertEqual(name, location.name)
    }
    
    func testSetCoordinates() {
        let coordinates = CLLocationCoordinate2D(
            latitude: 1,
            longitude: 2)
        let location = Location(
            name: "Foo",
            coordinates: coordinates)
        
        XCTAssertEqual(coordinates.latitude,
                       location.coordinates?.latitude)
        XCTAssertEqual(coordinates.longitude,
                       location.coordinates?.longitude)
        
    }
}
