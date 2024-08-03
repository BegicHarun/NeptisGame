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
    /*
     Ukoliko dodje do errora ovdje da je UserViewModel out of scope
     a aplikacija se builda i runna normalno, problem je do Xcode verzije.
     
     https://forums.developer.apple.com/forums/thread/691672
     Ovdje se dosta njih javljalo da imaju isti problem sa novijim verzijama Xcode-a
     Dosta njih radi u Objective-C pa su uspjeli pronaci rjesenje removanjem
     #import fajlova ali za Swift nisam uspio naci nista
     
     Medjutim aplikacija radi i ako pokaze error potrebno je ocisti build folder i odraditi build ponovo
     
        Shift + Command + K
        Command + B
     */
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
        .navigationBarBackButtonHidden(true) 
    }
}

struct HomeScreen_Previews: PreviewProvider {
    static var previews: some View {
        HomeScreen(currentUser: User(id: 1, firstName: "Emily", lastName: "Johnson", age: 30, username: "johndoe", email: "john.doe@example.com"))
    }
}
