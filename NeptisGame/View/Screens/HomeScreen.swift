//
//  HomeScreen.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import SwiftUI

struct HomeScreen: View {
    var currentUser: User
    @StateObject private var viewModel = UserViewModel()
    
    @State private var selectedUser: User?
    @State private var showAlert = false
    @State private var navigateToGameScreen = false
    
    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Spacer()
                    Text("Welcome, \(currentUser.firstName) \(currentUser.lastName)")
                        .padding()
                }
                
                VStack {
                    Text("Users")
                        .font(.largeTitle)
                        .fontWeight(.bold)
                        .padding(.bottom, 10)
                    
                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.red)
                            .padding()
                    } else {
                        List(viewModel.users) { user in
                            HStack {
                                Text("\(user.firstName) \(user.lastName)")
                                Spacer()
                                if currentUser.id != user.id {
                                    Button(action: {
                                        selectedUser = user
                                        showAlert = true
                                    }) {
                                        Text("Play")
                                            .foregroundColor(.blue)
                                    }
                                } else {
                                    Text("You")
                                        .foregroundColor(.gray)
                                }
                            }
                        }
                    }
                }
                .padding()
                .navigationTitle("")
                .navigationBarHidden(true)
            }
            .onAppear {
                viewModel.fetchUsers {
                    viewModel.addUser(user: currentUser)
                }
            }
            .alert(isPresented: $showAlert) {
                Alert(
                    title: Text("Play Game"),
                    message: Text("Do you want to play guess name with \(selectedUser?.username ?? "")?"),
                    primaryButton: .default(Text("Yay!"), action: {
                        navigateToGameScreen = true
                    }),
                    secondaryButton: .cancel(Text("Naah"))
                )
            }
            .navigationDestination(isPresented: $navigateToGameScreen) {
                GameScreen(opponentUsername: selectedUser?.username ?? "", loggedInUser: currentUser)
            }
        }
        .navigationBarBackButtonHidden(true) // Hide back button
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(currentUser: User(id: 1, firstName: "Emily", lastName: "Johnson", age: 30, username: "johndoe", email: "john.doe@example.com"))
    }
}
