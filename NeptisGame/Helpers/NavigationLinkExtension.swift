//
//  NavigationLinkExtension.swift
//  NeptisGame
//
//  Created by Harun Begic on 30. 7. 2024..
//
import SwiftUI

extension View {
    func navigate<SomeView: View>(to destination: SomeView, when binding: Binding<Bool>) -> some View {
        ZStack {
            self

            NavigationStack {
                EmptyView()
                    .navigationDestination(isPresented: binding) {
                        destination
                            .navigationBarTitle("")
                            .navigationBarHidden(true)
                    }
            }
        }
    }
}
