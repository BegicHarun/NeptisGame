//
//  UserService.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//

import Foundation

enum UserError: Error, LocalizedError {
    case invalidResponse
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .invalidResponse:
            return "Invalid response from server"
        case .unknownError(let message):
            return message
        }
    }
}

class UserService {
    static let shared = UserService()
    
    private init() {}
    
    func register(firstName: String, lastName: String, age: Int, username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/users/add") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "age": age,
            "username": username,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(UserError.unknownError("No data received")))
                return
            }
            
            do {
                switch httpResponse.statusCode {
                case 200, 201:
                    let createUserResponse = try JSONDecoder().decode(CreateUserResponse.self, from: data)
                    let user = User(
                        id: createUserResponse.id,
                        firstName: createUserResponse.firstName,
                        lastName: createUserResponse.lastName,
                        age: createUserResponse.age,
                        username: createUserResponse.username,
                        email: "" 
                    )
                    completion(.success(user))
                default:
                    let responseBody = String(data: data, encoding: .utf8) ?? "No response body"
                    completion(.failure(UserError.unknownError("HTTP \(httpResponse.statusCode): \(responseBody)")))
                }
            } catch {
                completion(.failure(UserError.unknownError("Failed to decode response: \(error.localizedDescription)")))
            }
        }
        task.resume()
    }
    
    func fetchUsers(completion: @escaping (Result<[User], Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/users") else { return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(UserError.unknownError("No data received")))
                return
            }
            
            do {
                let usersResponse = try JSONDecoder().decode(UsersResponse.self, from: data)
                completion(.success(usersResponse.users))
            } catch {
                completion(.failure(UserError.unknownError("Failed to decode response: \(error.localizedDescription)")))
            }
        }
        task.resume()
    }
}
