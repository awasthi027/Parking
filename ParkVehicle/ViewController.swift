/*
******************************************************************
* COPYRIGHT (c) <<2020>> <<Ashish Awasthi. All rights reserved.>>*
*
 * All rights reserved                                           *
*
 * This software embodies materials and concepts which are       *
* confidential to <<Customer Name>> and is made available solely *
* pursuant to the terms of a written license agreement with      *
* <<Harman Product>>.                                            *
*
* Designed and Developed by Ashish Awasthi.                      *
.           *
*----------------------------------------------------------------*
* MODULE OR UNIT: ViewController                                 *
*
* PROGRAMMER :  Ashish Awasthi                                   *
* DATE       :  10/10/20.                                        *
* VERSION    :  1.0                                              *
*
*----------------------------------------------------------------*
*
* MODULE SUMMARY :  Independent class                            *
*
*
*
*
*----------------------------------------------------------------*
*
* TRACEABILITY RECORDS to SW requirements and detailed design :  *
* iOS 13 and onward
*
*
*----------------------------------------------------------------*
*
* MODIFICATION RECORDS                                           *
*
******************************************************************
*/

import UIKit
class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.invokeParkingTest()
        // Do any additional setup after loading the view.
    }
    func invokeParkingTest() {
        let factoryObj = ParkingFactory()
        factoryObj.delegate = self
        print("Public Total Available Slot: Small:- \(factoryObj.availableSmallSlot), Large:- \(factoryObj.availableLargeSlot), Extra Large:- \(factoryObj.availableExtraLargeSlot),Reseved Slot:- \(factoryObj.availableResveredSlot)")
        print("===========================================================================")
        var isParked = factoryObj.enterInParking(.honda, .hBike1)
        print("Bike Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.honda, .hCar1)
        print("Car Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.tata, .tTruck1)
        print("Truck Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhBus1)
        print("Bus Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhBus1, isReservedCategory: true)
        print("Reveverd Bus Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhBus1, isReservedCategory: true)
        print("Reveverd Bus Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhCar1, isReservedCategory: true)
        print("Reveverd Car Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhBike1, isReservedCategory: true)
        print("Reveverd Bike Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhBike1, isReservedCategory: true)
        print("Reveverd Bike Parked: \(isParked)")
        isParked = factoryObj.enterInParking(.mahindra, .mhBike1, isReservedCategory: true)
        print("Reveverd Bike Parked: \(isParked)")
        var fee = factoryObj.exitParking(.mahindra, .mhBike1, isReservedCategory: true)
        print("Reveverd Bike exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.mahindra, .mhBus1, isReservedCategory: true)
        print("Reveverd Bus exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.mahindra, .mhCar1, isReservedCategory: true)
        print("Reveverd car exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.mahindra, .mhBike1, isReservedCategory: true)
        print("Reveverd bike exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.honda, .hCar1)
        print("bike exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.honda, .hBike1)
        print("bike exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.tata, .tTruck1)
        print("Truck exit and Paid fee: \(fee)")
        fee = factoryObj.exitParking(.mahindra, .mhBus1)
        print("Bus exit and Paid fee: \(fee)")
    }
}

extension ViewController: SubscribeAvailableSlotsProtocol {
    func parkingFactory(_ factory: ParkingFactory, didUpdateSlots slots: (Int, Int, Int, Int)) {
        print("Public Available Slots Small:- \(slots.0), Large:- \(slots.1), Extra Large:- \(slots.2), Reseved Slot:- \(slots.3)")
    }
}
