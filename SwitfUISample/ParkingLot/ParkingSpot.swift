//
//  ParkingSpot.swift
//  ParkingLot
//
//  Created by Ashish Awasthi on 01/09/24.
//


class ParkingSpot: Identifiable {

    let spotId: String
    let size: Size
    var isOccupied: Bool = false

    init(spotId: String, size: Size) {
        self.spotId = spotId
        self.size = size
    }

    func assignVehicle(_ vehicle: Vehicle) -> Bool {
        guard !isOccupied && vehicle.size == size else { return false }
        isOccupied = true
        return true
    }

    func removeVehicle() {
        isOccupied = false
    }
}
