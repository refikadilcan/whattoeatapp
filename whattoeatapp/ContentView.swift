//
//  ContentView.swift
//  whattoeatapp
//
//  Created by Refik Adilcan Eğilmez on 2026-03-23.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color(.systemGroupedBackground)
                    .ignoresSafeArea()

                VStack(spacing: 24) {
                    Text("Choose Your Way")
                        .font(.system(size: 38, design: .rounded))
                        .fontWeight(.bold)
                        .padding(.top, 60)

                    HStack(spacing: 16) {
                        // Dice Kartı
                        NavigationLink(destination: RandomPickView()) {
                            VStack(spacing: 14) {
                                Spacer()
                                Image(systemName: "dice.fill")
                                    .font(.system(size: 56))
                                    .frame(height: 64)
                                    .foregroundStyle(.white)
                                Text("Dice")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                Text("Pick a random meal")
                                    .font(.subheadline)
                                    .foregroundStyle(.white.opacity(0.85))
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("WarmYellow"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
                        }

                        // Duel Kartı
                        NavigationLink(destination: ThisOrThatView()) {
                            VStack(spacing: 14) {
                                Spacer()
                                Image(systemName: "figure.fencing")
                                    .font(.system(size: 56))
                                    .frame(height: 64)
                                    .foregroundStyle(.white)
                                Text("Duel")
                                    .font(.title)
                                    .fontWeight(.bold)
                                    .foregroundStyle(.white)
                                Text("This or that?")
                                    .font(.subheadline)
                                    .multilineTextAlignment(.center)
                                    .foregroundStyle(.white.opacity(0.85))
                                Spacer()
                            }
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                            .background(Color("OceanBlue"))
                            .clipShape(RoundedRectangle(cornerRadius: 20))
                            .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
                        }
                    }
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    ContentView()
}
