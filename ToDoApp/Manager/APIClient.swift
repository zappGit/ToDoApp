//
//  APIClient.swift
//  ToDoApp
//
//  Created by Артем Хребтов on 19.12.2021.
//

import Foundation

protocol URLSessionProtocol {
    func dataTask(with url: URL, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask
}

extension URLSession: URLSessionProtocol {
    
}
class APIClient {
    lazy var urlSession: URLSessionProtocol = URLSession.shared
    func login(withName name: String, password: String, complitionHandler: @escaping (String?, Error?) -> Void) {
        let allowedCharacters = CharacterSet.urlQueryAllowed //swift-encode-url
        guard let name = name.addingPercentEncoding(withAllowedCharacters: allowedCharacters),
             let password = password.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
                  fatalError()
              }
        let query = "name=\(name)&password=\(password)"
        guard let url = URL(string: "https://todoapp.com/login?\(query)") else {
            fatalError()
        }
        urlSession.dataTask(with: url) { data, response, error in
            
        }
    }
}
//свой сет символов закодирования
extension String {
    var persentEncoded: String {
        let allowedCharacters = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]\\/.,?}{").inverted
        guard let encodedString = self.addingPercentEncoding(withAllowedCharacters: allowedCharacters) else {
            fatalError()
        }
        return encodedString
    }
}
