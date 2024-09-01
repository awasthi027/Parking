//
//  Vehicle.swift
//  ParkingLot
//
//  Created by Ashish Awasthi on 01/09/24.
//

import Foundation
enum Size {
    case small, medium, large, compact
}

class Vehicle {

    let licensePlate: String
    let size: Size

    init(licensePlate: String, size: Size) {
        self.licensePlate = licensePlate
        self.size = size
    }
}
