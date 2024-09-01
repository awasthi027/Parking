//
//  ContentView.swift
//  ParkingLot
//
//  Created by Ashish Awasthi on 01/09/24.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var parkingLot = ObservableParkingLot()

    var body: some View {
        VStack {
            List(parkingLot.spots) { spot in
                Text("Spot \(spot.spotId): \(spot.isOccupied ? "Occupied" : "Available")")
            }
            .onAppear {
                // Add initial spots
                parkingLot.addSpot(ParkingSpot(spotId: "1", size: .small))
                parkingLot.addSpot(ParkingSpot(spotId: "2", size: .medium))
                parkingLot.addSpot(ParkingSpot(spotId: "3", size: .large))
            }
        }
    }
}

#Preview {
    ContentView()
}
