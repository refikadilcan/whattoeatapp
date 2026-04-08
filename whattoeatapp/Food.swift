import Foundation

struct Food {
    let name: String
    let imageName: String

    static let all: [Food] = [
        Food(name: "Burger", imageName: "burger"),
        Food(name: "Pizza", imageName: "pizza"),
        Food(name: "Kebab", imageName: "kebab"),
        Food(name: "Sushi", imageName: "sushi"),
        Food(name: "Italian Pasta", imageName: "pasta"),
        Food(name: "Taco", imageName: "taco"),
        Food(name: "Steak", imageName: "steak"),
        Food(name: "Falafel", imageName: "falafel"),
        Food(name: "Noodle / Ramen", imageName: "ramen"),
        Food(name: "Sandwich", imageName: "sandwich"),
        Food(name: "Fried Chicken", imageName: "friedchicken"),
    ]
}
