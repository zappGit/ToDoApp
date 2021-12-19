//
//  APIClientTests.swift
//  ToDoAppTests
//
//  Created by Артем Хребтов on 19.12.2021.
//

import XCTest
import Foundation
@testable import ToDoApp

class APIClientTests: XCTestCase {

    var sut: APIClient!
    var mockURLSession: MockUrlSession!
    
    override func setUpWithError() throws {
        mockURLSession = MockUrlSession()
        sut = APIClient()
        sut.urlSession = mockURLSession
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func userLogin() {
        let complitionHandler = {(token: String?, error: Error?) in }
        sut.login(withName: "name", password: "%qwerty", complitionHandler: complitionHandler)
    }
    
    func testLoginUsersCorrectHost() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.host, "todoapp.com")
    }
    func testLoginUsersCorrectPath() {
        userLogin()
        XCTAssertEqual(mockURLSession.urlComponents?.path, "/login")
    }
    func testLoginUsersExpectedQueryParametrs(){
        userLogin()
        guard let queryItems = mockURLSession.urlComponents?.queryItems else {
            XCTFail()
            return
        }
        
        let urlQueryItemName = URLQueryItem(name: "name", value: "name")
        let urlQueryItemPassword = URLQueryItem(name: "password", value: "%qwerty")
        
        XCTAssertTrue(queryItems.contains(urlQueryItemName))
        XCTAssertTrue(queryItems.contains(urlQueryItemPassword))
    }
   
}

extension APIClientTests {
    class MockUrlSession: URLSessionProtocol {
        var url: URL?
        
        var urlComponents: URLComponents? {
            guard let url = url else {
                return nil
            }
            return URLComponents(url: url, resolvingAgainstBaseURL: true)
        }
         func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
             self.url = url
             return URLSession.shared.dataTask(with: url)
        }
    }
}



