//
//  ButtonView.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import SwiftUI

struct ButtonView: View {
    var title: String
    var action: () -> Void
    var isEnabled: Bool = true
    var isLoading: Bool = false
    
    var body: some View {
        Button(action: {
            if isEnabled {
                action()
            }
        }) {
            if isLoading {
                ProgressView()
                    .progressViewStyle(CircularProgressViewStyle())
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
            } else {
                Text(title)
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(isEnabled ? Color.blue : Color.gray)
                    .cornerRadius(10)
                    .padding(.horizontal)
            }
        }
        .disabled(!isEnabled || isLoading)
    }
}
