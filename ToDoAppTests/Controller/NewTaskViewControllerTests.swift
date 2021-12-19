//
//  NewTaskViewControllerTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 18.12.2021.
//

import XCTest
import CoreLocation
@testable import ToDoApp

class NewTaskViewControllerTests: XCTestCase {

    var sut: NewTaskViewController!
    var placemark: MockCLPlacemark!
    
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
    
    func testSaveUserGeocoderConvertCoordinateFromAdress() {
        let df = DateFormatter()
        df.dateFormat = "dd.MM.yy"
        let date = df.date(from: "01.01.19")
        
        sut.titleTextfield.text = "Foo"
        sut.locationTextfield.text = "Bar"
        sut.dateTextfield.text = "01.01.19"
        sut.adressTextfield.text = "Уфа"
        sut.descriptionTextfield.text = "Baz"
        
        sut.taskManager = TaskManager()
        let mockGeocoder = MockCLGeocoder()
        sut.geocoder = mockGeocoder
        sut.save()
        
        
        let coordinates = CLLocationCoordinate2D(latitude: 54.7373058, longitude: 55.9722491)
        let location = Location(name: "Bar", coordinates: coordinates)
        let generatedTask = Task(title: "Foo", date: date, description: "Baz", location: location)
       
        placemark = MockCLPlacemark()
        placemark.mockCoordinate = coordinates
        mockGeocoder.complitionHandler?([placemark], nil)
        let task = sut.taskManager.task(at: 0)
        
        XCTAssertEqual(task, generatedTask)
    }
    
    func testSavebuttonHasSaveMethode() {
        let saveButton = sut.saveButton
        
        guard let actions = saveButton?.actions(forTarget: sut, forControlEvent: .touchUpInside) else {
            XCTFail()
            return
        }
        XCTAssertTrue(actions.contains("save"))
    }
    
    
    func testGeocoderFetchesCorrectCoordinate() {
        let geocoderAnswer = expectation(description: "Geocode answer")
        let addressString = "Уфа"
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString(addressString) { placemarks, error in
            let placemark = placemarks?.first
            
            let location = placemark?.location
            
            guard let longitude = location?.coordinate.longitude,
                  let latitude = location?.coordinate.latitude else {
                      XCTFail()
                      return
                  }
            
            XCTAssertEqual(latitude, 54.7373058)
            XCTAssertEqual(longitude, 55.9722491)
            geocoderAnswer.fulfill()
        }
        waitForExpectations(timeout: 5, handler: nil)
    }
}


extension NewTaskViewControllerTests {
    class MockCLGeocoder: CLGeocoder {
        var complitionHandler: CLGeocodeCompletionHandler?
        
        override func geocodeAddressString(_ addressString: String, completionHandler: @escaping CLGeocodeCompletionHandler) {
            self.complitionHandler = completionHandler
        }
    }
    
    class MockCLPlacemark: CLPlacemark {
        
        var mockCoordinate: CLLocationCoordinate2D!
        
        override var location: CLLocation? {
            return CLLocation(latitude: mockCoordinate.latitude, longitude: mockCoordinate.longitude)
        }
    }
}
