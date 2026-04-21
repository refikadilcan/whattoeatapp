import SwiftUI

struct FindOnMapButton: View {
    let foodName: String
    @State private var showingMapOptions = false

    var body: some View {
        Button {
            showingMapOptions = true
        } label: {
            HStack(spacing: 6) {
                Image(systemName: "map.fill")
                Text("Find \(foodName) Nearby")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .background(Color("MapGreen"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .confirmationDialog(
            "Open With",
            isPresented: $showingMapOptions
        ) {
            Button("Apple Maps") {
                openAppleMaps()
            }
            Button("Google Maps") {
                openGoogleMaps()
            }
        }
    }

    private func openAppleMaps() {
        let query = "\(foodName) near me"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? foodName
        if let url = URL(string: "maps://?q=\(query)") {
            UIApplication.shared.open(url)
        }
    }

    private func openGoogleMaps() {
        let query = "\(foodName) near me"
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? foodName
        let googleMapsApp = URL(string: "comgooglemaps://?q=\(query)")
        let googleMapsWeb = URL(string: "https://www.google.com/maps/search/\(query)")

        if let appURL = googleMapsApp, UIApplication.shared.canOpenURL(appURL) {
            UIApplication.shared.open(appURL)
        } else if let webURL = googleMapsWeb {
            UIApplication.shared.open(webURL)
        }
    }
}

#Preview {
    FindOnMapButton(foodName: "Pizza")
}
