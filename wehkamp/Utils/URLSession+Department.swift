//
//  URLSession+Department.swift
//  wehkamp
//
//  Created by Kostya on 21/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

extension URLSession {
    private func codableTask<T: Codable>(with url: URL, completionHandler: @escaping (T?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.dataTask(with: url) { data, response, error in
            guard let data = data, error == nil else {
                completionHandler(nil, response, error)
                return
            }
            let decoder = JSONDecoder()
            decoder.dateDecodingStrategy = .iso8601
            completionHandler(try? decoder.decode(T.self, from: data), response, nil)
        }
    }

    func departmentTask(with url: URL, completionHandler: @escaping (Department?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return self.codableTask(with: url, completionHandler: completionHandler)
    }
}
