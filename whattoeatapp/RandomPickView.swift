import SwiftUI

struct RandomPickView: View {
    @State private var selectedFood: Food?
    @State private var titleBouncing = false
    @State private var isChoosing = false

    var body: some View {
        ZStack {
            Color("WarmYellowLight")
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

                if isChoosing {
                    Text("Let me think...")
                        .font(.custom("Chalkboard SE", size: 32))
                        .foregroundStyle(.gray)
                        .transition(.opacity)
                } else if let food = selectedFood {
                    Image(food.imageName)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .transition(.scale.combined(with: .opacity))

                    Text(food.name)
                        .font(.custom("Chalkboard SE", size: 38))
                        .foregroundStyle(.black)
                        .padding(.top, 8)
                        .transition(.opacity)
                } else {
                    Text("Today's Chef:\nPure Luck")
                        .font(.custom("Chalkboard SE", size: 38))
                        .multilineTextAlignment(.center)
                        .foregroundStyle(.gray)
                }

                Spacer()
                Spacer()

                if let food = selectedFood {
                    FindOnMapButton(foodName: food.name)
                        .padding(.bottom, 12)
                }

                Button {
                    withAnimation {
                        isChoosing = true
                        selectedFood = nil
                    }
                    Task {
                        try? await Task.sleep(for: .seconds(1.2))
                        withAnimation(.spring(duration: 0.4, bounce: 0.3)) {
                            isChoosing = false
                            selectedFood = Food.all.randomElement()
                            titleBouncing = true
                        }
                        try? await Task.sleep(for: .seconds(0.15))
                        titleBouncing = false
                    }
                } label: {
                    Text("Choose Your Meal")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundStyle(.white)
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color("WarmYellow"))
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                }
                .padding(.horizontal, 24)
                .padding(.bottom, 40)
            }
        }
    }
}

#Preview {
    RandomPickView()
}
