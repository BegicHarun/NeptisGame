//
//  LoginScreen.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import SwiftUI

struct LoginScreen: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isLoggedIn: Bool = false
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var loggedInUser: User?

    private var isFormValid: Bool {
        !username.isEmpty && !password.isEmpty
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()

                VStack(spacing: 20) {
                    Text("NeptisGame")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)

                    InputView(placeholder: "Username", text: $username)

                    InputView(placeholder: "Password", text: $password, isSecure: true)

                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }

                    ButtonView(title: "Login", action: {
                        login()
                    }, isEnabled: isFormValid, isLoading: isLoading)
                }
                .padding(.horizontal)

                Spacer()

                HStack {
                    Text("Don't have an account?")
                    NavigationLink(destination: RegisterScreen()) {
                        Text("Register")
                            .foregroundColor(.blue)
                    }
                }
                .padding(.bottom, 20)
            }
            .padding()
            .navigationDestination(isPresented: $isLoggedIn) {
                HomeScreen(currentUser: loggedInUser ?? User(id: 0, firstName: "", lastName: "", age: 0, username: "", email: ""))
            }
        }
    }

    private func login() {
        isLoading = true
        AuthService.shared.login(username: username, password: password) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let user):
                    loggedInUser = user
                    isLoggedIn = true
                    errorMessage = nil
                case .failure(let error):
                    if let authError = error as? AuthError {
                        errorMessage = authError.localizedDescription
                    } else {
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

struct LoginScreen_Previews: PreviewProvider {
    static var previews: some View {
        LoginScreen()
    }
}
