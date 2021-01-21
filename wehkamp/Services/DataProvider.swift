//
//  DataProvider.swift
//  wehkamp
//
//  Created by Kostya on 19/01/2021.
//  Copyright © 2021 Kostiantyn Gorbunov. All rights reserved.
//

import Foundation

enum DataProviderError: Error {
    case resourceNotFound
    case parsingFailure(inner: Error)
}

protocol DataProvider {
    typealias FetchMemberResult = Result<Department, Error>
    typealias FetchMemberCompletion = (FetchMemberResult) -> Void

    func fetchMemberList(_ completion: @escaping FetchMemberCompletion)
}

struct LocalMembersDataProvider: DataProvider {

    private let queue = DispatchQueue(label: "LocalMembersDataProviderQueue")

    // Completion block will be called on main queue
    func fetchMemberList(_ completion: @escaping FetchMemberCompletion) {
        guard let path = Bundle.main.url(forResource: "department", withExtension: "json") else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }

        queue.async {
            do {
                let jsonData = try Data(contentsOf: path)
                let result = try! JSONDecoder().decode(Department.self, from: jsonData)

                DispatchQueue.main.async {
                    completion(.success(result))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
        }
    }
}

struct RemoteMembersDataProvider: DataProvider {
    
    private enum Constants {
        static let url: URL? = URL(string: "https://universal-app-dev-452bd.firebaseio.com/members.json")
    }

    func fetchMemberList(_ completion: @escaping FetchMemberCompletion) {
        guard let url = Constants.url else {
            DispatchQueue.main.async {
                completion(.failure(DataProviderError.resourceNotFound))
            }
            return
        }
        let task = URLSession.shared.departmentTask(with: url) { department, response, error in
            if let error = error {
                DispatchQueue.main.async {
                    completion(.failure(DataProviderError.parsingFailure(inner: error)))
                }
            }
            if let result = department {
                DispatchQueue.main.async {
                    completion(.success(result))
                }
            }
        }
        task.resume()
    }
}
