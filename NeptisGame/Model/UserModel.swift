//
//  UserModel.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import Foundation

struct User: Codable, Identifiable, Equatable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let username: String
    let email: String
}


struct CreateUserResponse: Codable {
    let id: Int
    let firstName: String
    let lastName: String
    let age: Int
    let username: String
    let password: String
}

struct UsersResponse: Codable {
    let users: [User]
    let total: Int
    let skip: Int
    let limit: Int
}

struct AuthResponse: Codable {
    let id: Int
    let username: String
    let email: String
    let firstName: String
    let lastName: String
    let gender: String
    let image: String
    let token: String
    let refreshToken: String
}
