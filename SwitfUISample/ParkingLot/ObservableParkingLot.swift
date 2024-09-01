//
//  ObservableParkingLot.swift
//  ParkingLot
//
//  Created by Ashish Awasthi on 01/09/24.
//

import Foundation

class ObservableParkingLot: ObservableObject {
    
    @Published var spots: [ParkingSpot] = []

    func addSpot(_ spot: ParkingSpot) {
        spots.append(spot)
    }

    func findAvailableSpot(for vehicle: Vehicle) -> ParkingSpot? {
        return spots.first { $0.size == vehicle.size && !$0.isOccupied }
    }

    func parkVehicle(_ vehicle: Vehicle) -> Bool {
        guard let spot = findAvailableSpot(for: vehicle) else { return false }
        return spot.assignVehicle(vehicle)
    }

    func removeVehicle(from spotId: String) {
        if let spot = spots.first(where: { $0.spotId == spotId }) {
            spot.removeVehicle()
        }
    }
}
