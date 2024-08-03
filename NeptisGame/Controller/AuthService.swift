//
//  AuthService.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import Foundation

enum AuthError: Error, LocalizedError {
    case invalidCredentials
    case unknownError(String)

    var errorDescription: String? {
        switch self {
        case .invalidCredentials:
            return "Username ili lozinka nisu ispravni"
        case .unknownError(let message):
            return message
        }
    }
}

class AuthService {
    static let shared = AuthService()
    
    private init() {}
    
    func login(username: String, password: String, completion: @escaping (Result<User, Error>) -> Void) {
        guard let url = URL(string: "https://dummyjson.com/auth/login") else { return }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.addValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = ["username": username, "password": password]
        
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
                completion(.failure(AuthError.unknownError("No data received")))
                return
            }
            
            
            if let jsonString = String(data: data, encoding: .utf8) {
                print("JSON Response: \(jsonString)")
            } else {
                print("Failed to convert data to string.")
            }
            
            do {
                switch httpResponse.statusCode {
                case 200:
                    let decoder = JSONDecoder()
                    decoder.keyDecodingStrategy = .convertFromSnakeCase
                    let authResponse = try decoder.decode(AuthResponse.self, from: data)
                    let user = User(
                        id: authResponse.id,
                        firstName: authResponse.firstName,
                        lastName: authResponse.lastName,
                        age: 0, // Default age as it is not present in the response
                        username: authResponse.username,
                        email: authResponse.email
                    )
                    completion(.success(user))
                case 401:
                    completion(.failure(AuthError.invalidCredentials))
                default:
                    let responseBody = String(data: data, encoding: .utf8) ?? "No response body"
                    completion(.failure(AuthError.unknownError("\(responseBody)")))
                }
            } catch let decodingError {
                print("Decoding error: \(decodingError)")
                completion(.failure(AuthError.unknownError("Failed to decode response: \(decodingError.localizedDescription)")))
            }
        }
        task.resume()
    }
}
