//
//  GameScreen.swift
//  NeptisGame
//
//  Created by Harun Begic on 31. 7. 2024..
//
import SwiftUI

struct GameScreen: View {
    var opponentUsername: String
    var loggedInUser: User

    @StateObject private var gameController = GameController()
    @State private var userScore = 0
    @State private var opponentScore = 0
    @State private var currentAttempt = 1
    @State private var guess = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var gameOver = false
    @State private var navigateToHome = false
    @StateObject private var viewModel = UserViewModel()
    var body: some View {
        VStack {
            Text("You vs \(opponentUsername)")
                .font(.largeTitle)
                .padding()

            Text("Score: \(userScore) vs \(opponentScore)")
                .font(.title)
                .padding()

            Text("Attempt: \(currentAttempt)/10")
                .padding()

            Text(gameController.recipeName)
                .font(.title2)
                .padding()

            TextField("Enter your guess", text: $guess)
                .textFieldStyle(RoundedBorderTextFieldStyle())
                .padding()

            Button("Send") {
                submitGuess()
            }
            .padding()
            .disabled(guess.isEmpty) // Disable button when input field is empty

            Spacer()
        }
        .navigationTitle("Game Screen")
        .navigationBarTitleDisplayMode(.inline)
        .navigationBarBackButtonHidden(true)
        .onAppear(perform: loadRandomRecipe)
        .alert(isPresented: $showAlert) {
            Alert(
                title: Text("Result"),
                message: Text(alertMessage),
                dismissButton: .default(Text("OK")) {
                    if gameOver {
                        navigateToHome = true
                    } else {
                        loadRandomRecipe()
                    }
                }
            )
        }
        .navigationDestination(isPresented: $navigateToHome) {
            HomeScreen(currentUser: loggedInUser)
                .navigationBarTitle("")
                .navigationBarHidden(true)
        }
    }

    private func loadRandomRecipe() {
        print("Loading random recipe...")
        gameController.fetchRandomRecipe { recipeName, tags in
            DispatchQueue.main.async {
                if let name = recipeName, let tags = tags {
                    gameController.recipeName = name
                    gameController.recipeTags = tags
                    print("Recipe fetched: \(name), Tags: \(tags)")
                } else {
                    print("Error: Unable to fetch a new recipe.")
                    gameController.recipeName = "Error fetching recipe"
                    gameController.recipeTags = []
                }
            }
        }
    }

    private func submitGuess() {
        print("Submit guess called")

        if guess.lowercased() == gameController.recipeName.lowercased() {
            userScore += 1
            alertMessage = "Correct! Your score: \(userScore)"
        } else {
            alertMessage = "Wrong! The correct answer was: \(gameController.recipeName)"
        }

        gameController.fetchTags { tags in
            guard let tags = tags, !tags.isEmpty else {
                print("Tags fetch failed or empty")
                DispatchQueue.main.async {
                    showAlert = true
                }
                return
            }

            let opponentGuess = tags.randomElement() ?? ""
            print("Opponent guessed: \(opponentGuess)")

            if gameController.recipeTags.contains(opponentGuess) {
                opponentScore += 1
                alertMessage += "\nOpponent guessed correctly! Opponent's score: \(opponentScore)"
            } else {
                alertMessage += "\nOpponent guessed wrong! Opponent's score: \(opponentScore)"
            }

            DispatchQueue.main.async {
                currentAttempt += 1
                guess = ""
                showAlert = true
                
                print("Attempt: \(currentAttempt), User Score: \(userScore), Opponent Score: \(opponentScore)")

                if currentAttempt >= 10 {
                    showGameResult()
                }
            }
        }
    }

    private func showGameResult() {
        if userScore > opponentScore {
            alertMessage = "You won! Congrats!"
        } else if userScore < opponentScore {
            alertMessage = "You lost! More luck next time…"
        } else {
            alertMessage = "It's a tie!"
        }

        gameOver = true
        showAlert = true
    }
}

struct GameScreen_Previews: PreviewProvider {
    static var previews: some View {
        GameScreen(opponentUsername: "exampleUser", loggedInUser: User(id: 1, firstName: "John", lastName: "Doe", age: 30, username: "johndoe", email: "john.doe@example.com"))
    }
}
