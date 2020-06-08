//
//  Request.swift
//  TestWaterDashboard
//
//  Created by user167484 on 6/8/20.
//  Copyright © 2020 Allen Savio. All rights reserved.
//

import Foundation

enum Request {
    case fetchWaterData
    case fetchBarData
    case fetchLineData
    case fetchPieData
    
    var url: URL? {
        switch self {
        case .fetchWaterData:
            return Bundle.main.url(forResource: "waterData", withExtension: "json")
        case .fetchBarData:
            return Bundle.main.url(forResource: "lineData", withExtension: "json")
        case .fetchLineData:
            return Bundle.main.url(forResource: "barData", withExtension: "json")
        case .fetchPieData:
            return Bundle.main.url(forResource: "pieData", withExtension: "json")
        }
    }
    
    enum URLError: Error {
        case empty
        case incorrect
        case wrongURL
    }
    
    typealias RequestCompletion<T> = (_ response: URLResponse?, _ data: T) -> Void
    typealias FailureCompletion = (_ error: Error) -> Void
    func execute<T: Decodable>(success: @escaping RequestCompletion<T>, failure: @escaping FailureCompletion) {
        guard let url = url else { failure(URLError.wrongURL); return }
        print(url.absoluteString)
        let session = URLSession(configuration: .default)
        session.dataTask(with: url) { (data, response, error) in
            if let error = error {
                DispatchQueue.main.async {
                    failure(error)
                }
            } else {
                guard let data = data else { return }
                guard let string = String(data: data, encoding: String.Encoding.isoLatin1) else { return }
                guard let properData = string.data(using: .utf8, allowLossyConversion: true) else { return }
       
                do {
                    let decoder = JSONDecoder()
                    let newData = try decoder.decode(T.self, from: properData)
                    DispatchQueue.main.async {
                        success(response, newData)
                    }
                } catch let error {
                    print("Caught Error - > \(error)")
                    DispatchQueue.main.async {
                        failure(error)
                    }
                    
                }
            }
        }.resume()
    }
}
