//
//  Payment.swift
//  ParkingLot
//
//  Created by Ashish Awasthi on 01/09/24.
//

import Foundation

class Payment {
    enum PaymentMethod {
        case cash, card, mobile
    }

    let amount: Double
    let method: PaymentMethod

    init(amount: Double, method: PaymentMethod) {
        self.amount = amount
        self.method = method
    }

    func processPayment() -> Bool {
        // Implement payment processing logic here
        return true
    }
}
