//
//  RegisterScreen.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import SwiftUI

struct RegisterScreen: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var age: String = ""
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isRegistered: Bool = false
    @State private var errorMessage: String?
    @State private var isLoading: Bool = false
    @State private var newUser: User?
    
    private var isFormValid: Bool {
        !firstName.isEmpty && !lastName.isEmpty && !age.isEmpty && !username.isEmpty && !password.isEmpty && Int(age) != nil
    }

    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack(spacing: 20) {
                    Text("Register")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .foregroundColor(Color.blue)
                    
                    InputView(placeholder: "First Name", text: $firstName)
                    
                    InputView(placeholder: "Last Name", text: $lastName)
                    
                    InputView(placeholder: "Age", text: $age)
                    
                    InputView(placeholder: "Username", text: $username)
                    
                    InputView(placeholder: "Password", text: $password, isSecure: true)
                    
                    if let errorMessage = errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding(.top, 10)
                    }
                    
                    ButtonView(title: "Register", action: {
                        register()
                    }, isEnabled: isFormValid, isLoading: isLoading)
                }
                .padding(.horizontal)
                
                Spacer()
            }
            .padding()
            .navigationDestination(isPresented: $isRegistered) {
                HomeScreen(currentUser: newUser ?? User(id: 0, firstName: "", lastName: "", age: 0, username: "", email: ""))
            }
        }
    }
    
    private func register() {
        guard let userAge = Int(age) else {
            errorMessage = "Please enter a valid age."
            return
        }
        
        isLoading = true
        UserService.shared.register(firstName: firstName, lastName: lastName, age: userAge, username: username, password: password) { result in
            DispatchQueue.main.async {
                isLoading = false
                switch result {
                case .success(let user):
                    newUser = user
                    isRegistered = true
                    errorMessage = nil
                case .failure(let error):
                    if let userError = error as? UserError {
                        errorMessage = userError.localizedDescription
                    } else {
                        errorMessage = error.localizedDescription
                    }
                }
            }
        }
    }
}

struct RegisterScreen_Previews: PreviewProvider {
    static var previews: some View {
        RegisterScreen()
    }
}
