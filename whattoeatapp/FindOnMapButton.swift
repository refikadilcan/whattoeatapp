import CoreLocation
import SwiftUI

struct FindOnMapButton: View {
    let foodName: String
    @State private var showingMapOptions = false
    @State private var isLocating = false
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        Button {
            isLocating = true
            locationManager.requestLocation()
        } label: {
            HStack(spacing: 6) {
                if isLocating {
                    ProgressView()
                        .tint(.white)
                } else {
                    Image(systemName: "map.fill")
                }
                Text(isLocating ? "Locating..." : "Find \(foodName) Nearby")
            }
            .font(.title3)
            .fontWeight(.semibold)
            .foregroundStyle(.white)
            .padding(.horizontal, 28)
            .padding(.vertical, 14)
            .background(Color("MapGreen"))
            .clipShape(RoundedRectangle(cornerRadius: 12))
        }
        .disabled(isLocating)
        .onChange(of: locationManager.locationReady) { ready in
            if ready && isLocating {
                isLocating = false
                showingMapOptions = true
            }
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
        let query = foodName
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? foodName

        if let coord = locationManager.location?.coordinate {
            if let url = URL(string: "maps://?q=\(query)&sll=\(coord.latitude),\(coord.longitude)&z=14") {
                UIApplication.shared.open(url)
            }
        } else {
            if let url = URL(string: "maps://?q=\(query)%20near%20me") {
                UIApplication.shared.open(url)
            }
        }
    }

    private func openGoogleMaps() {
        let query = foodName
            .addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? foodName

        if let coord = locationManager.location?.coordinate {
            let googleMapsApp = URL(string: "comgooglemaps://?q=\(query)&center=\(coord.latitude),\(coord.longitude)&zoom=14")
            let googleMapsWeb = URL(string: "https://www.google.com/maps/search/\(query)/@\(coord.latitude),\(coord.longitude),14z")

            if let appURL = googleMapsApp, UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else if let webURL = googleMapsWeb {
                UIApplication.shared.open(webURL)
            }
        } else {
            let fallbackQuery = "\(query)%20near%20me"
            let googleMapsApp = URL(string: "comgooglemaps://?q=\(fallbackQuery)")
            let googleMapsWeb = URL(string: "https://www.google.com/maps/search/\(fallbackQuery)")

            if let appURL = googleMapsApp, UIApplication.shared.canOpenURL(appURL) {
                UIApplication.shared.open(appURL)
            } else if let webURL = googleMapsWeb {
                UIApplication.shared.open(webURL)
            }
        }
    }
}

#Preview {
    FindOnMapButton(foodName: "Pizza")
}
