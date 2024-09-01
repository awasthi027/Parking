//
//  User.swift
//  ParkingLot
//
//  Created by Ashish Awasthi on 01/09/24.
//

import Foundation

class User {
    let userId: String
    let name: String
    var vehicle: Vehicle?

    init(userId: String, name: String, vehicle: Vehicle?) {
        self.userId = userId
        self.name = name
        self.vehicle = vehicle
    }

    func parkVehicle(in lot: ParkingLot) -> Bool {
        guard let vehicle = vehicle else { return false }
        return lot.parkVehicle(vehicle)
    }

    func removeVehicle(from lot: ParkingLot, spotId: String) {
        lot.removeVehicle(from: spotId)
    }
}
