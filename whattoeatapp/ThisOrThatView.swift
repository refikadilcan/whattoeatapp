import SwiftUI

struct ThisOrThatView: View {
    @State private var remainingFoods: [Food] = Food.all.shuffled()
    @State private var leftFood: Food? = nil
    @State private var rightFood: Food? = nil
    @State private var titleBouncing = false
    @State private var leftVisible = true
    @State private var rightVisible = true

    var body: some View {
        ZStack {
            Color("OceanBlueLight")
                .ignoresSafeArea()

            VStack {
                Text("What to Eat?")
                    .font(.system(size: 45, design: .rounded))
                    .fontWeight(.bold)
                    .foregroundStyle(.black)
                    .padding(.top, 60)
                    .offset(y: titleBouncing ? -8 : 0)
                    .animation(.interpolatingSpring(stiffness: 400, damping: 8), value: titleBouncing)

                Spacer()

                if let winner = leftFood, remainingFoods.isEmpty && rightFood == nil {
                    // Kazanan belli oldu
                    Image(winner.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .scaleEffect(1.0)
                        .transition(.scale(scale: 0.5).combined(with: .opacity))

                    Text(winner.name)
                        .font(.custom("Chalkboard SE", size: 38))
                        .foregroundStyle(.black)
                        .padding(.top, 8)
                        .transition(.opacity)

                } else if let left = leftFood, let right = rightFood {
                    // İki yemek karşı karşıya
                    HStack(spacing: 20) {
                        // Sol yemek
                        Button {
                            pickFood(winner: left, loser: right, loserSide: .right)
                        } label: {
                            VStack {
                                Image(left.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))

                                Text(left.name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .opacity(leftVisible ? 1 : 0)
                        .offset(x: leftVisible ? 0 : -60)

                        Text("VS")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(.gray)

                        // Sağ yemek
                        Button {
                            pickFood(winner: right, loser: left, loserSide: .left)
                        } label: {
                            VStack {
                                Image(right.imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(height: 150)
                                    .clipShape(RoundedRectangle(cornerRadius: 16))

                                Text(right.name)
                                    .font(.title3)
                                    .fontWeight(.semibold)
                                    .foregroundStyle(.black)
                            }
                            .frame(maxWidth: .infinity)
                        }
                        .opacity(rightVisible ? 1 : 0)
                        .offset(x: rightVisible ? 0 : 60)
                    }
                    .padding(.horizontal, 24)
                }

                Spacer()
                Spacer()

                if let winner = leftFood, remainingFoods.isEmpty && rightFood == nil {
                    FindOnMapButton(foodName: winner.name)
                        .padding(.bottom, 12)

                    Button {
                        startGame()
                    } label: {
                        Text("Play Again")
                            .font(.title2)
                            .fontWeight(.semibold)
                            .foregroundStyle(.white)
                            .frame(maxWidth: .infinity)
                            .padding()
                            .background(Color("OceanBlue"))
                            .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 40)
                }
            }
        }
        .onAppear {
            startGame()
        }
    }

    private func startGame() {
        remainingFoods = Food.all.shuffled()
        leftFood = remainingFoods.removeFirst()
        rightFood = remainingFoods.removeFirst()
        leftVisible = true
        rightVisible = true
    }

    private enum Side { case left, right }

    private func pickFood(winner: Food, loser: Food, loserSide: Side) {
        // Başlık zıplama efekti
        titleBouncing = true
        Task {
            try? await Task.sleep(for: .seconds(0.15))
            titleBouncing = false
        }

        // Kaybeden tarafi fade-out + slide-out
        withAnimation(.easeIn(duration: 0.25)) {
            if loserSide == .left {
                leftVisible = false
            } else {
                rightVisible = false
            }
        }

        // Kısa bekleyiş sonra yeni yemek slide-in
        Task {
            try? await Task.sleep(for: .seconds(0.35))
            if remainingFoods.isEmpty {
                withAnimation(.spring(duration: 0.5, bounce: 0.3)) {
                    leftFood = winner
                    rightFood = nil
                }
            } else {
                let newFood = remainingFoods.removeFirst()
                if loserSide == .left {
                    leftFood = newFood
                } else {
                    rightFood = newFood
                }
                // Yeni yemek slide-in
                withAnimation(.spring(duration: 0.4, bounce: 0.2)) {
                    leftVisible = true
                    rightVisible = true
                }
            }
        }
    }
}

#Preview {
    ThisOrThatView()
}
