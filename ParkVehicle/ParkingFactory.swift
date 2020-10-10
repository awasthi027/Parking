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

import Foundation

protocol SubscribeAvailableSlotsProtocol: class {
    func parkingFactory(_ factory: ParkingFactory, didUpdateSlots slots: (Int,Int, Int,Int))
}
class ParkingFactory {
    weak var delegate: SubscribeAvailableSlotsProtocol?
    
    private var nfloor: [BaseFloor] = []
    init() {
        self.nfloor = [Basement(),FisrtFloor(), SecondFloor(), ThirdFloor()]
    }
    
    public var availableSmallSlot: Int {
        var count: Int = 0
        self.nfloor.forEach { (floor) in
            count += floor.availableSSlot
        }
        return count
    }
    public var availableLargeSlot: Int {
        var count: Int = 0
        self.nfloor.forEach { (floor) in
            count += floor.availableLSlot
        }
        return count
    }
    public var availableExtraLargeSlot: Int {
        var count: Int = 0
        self.nfloor.forEach { (floor) in
            count += floor.availableXLSlot
        }
        return count
    }
    var availableResveredSlot: Int {
        var count: Int = 0
        self.nfloor.forEach { (floor) in
            count +=  floor.availableRSlot
        }
        return count
    }
    var availableSlotAtFloors: (Int, Int, Int, Int) {
        var availableS_L_XL_RSlot = (0,0,0, 0)
        self.nfloor.forEach { (floor) in
            availableS_L_XL_RSlot.0 += floor.availableSSlot
            availableS_L_XL_RSlot.1 += floor.availableLSlot
            availableS_L_XL_RSlot.2 += floor.availableXLSlot
            availableS_L_XL_RSlot.3 += floor.availableRSlot
        }
        return availableS_L_XL_RSlot
    }
    
    func availableSlotAtFloor(_ floorIndex: FloorIndex) ->(Int, Int, Int,Int) {
        var availableS_L_XL_RSlot = (0,0,0,0)
        if self.nfloor.count > floorIndex.rawValue {
            let floor = self.nfloor[floorIndex.rawValue]
            availableS_L_XL_RSlot.0 = floor.availableSSlot
            availableS_L_XL_RSlot.1 = floor.availableLSlot
            availableS_L_XL_RSlot.2 = floor.availableXLSlot
            availableS_L_XL_RSlot.3 = floor.availableRSlot
        }
        return availableS_L_XL_RSlot
    }

    public func enterInParking(_ make: VehicleMakeType, _ model: VehicleModeType, isReservedCategory: Bool = false) -> Bool {
        let item = self.parkingInOrOut(isIn: true, make, model,  isReservedCategory)
        if item.0 {
            self.delegate?.parkingFactory(self, didUpdateSlots: availableSlotAtFloors)
        }
        else {
            for index in stride(from: 0, to:  FloorIndex.undefined.rawValue, by: 1) {
                if let floor = FloorIndex.init(rawValue: index) {
                    let slots = self.availableSlotAtFloor(floor)
                print("Available float at floor:- \(index) Small:- \(slots.0), Large:- \(slots.1), Extra Large:- \(slots.2),Reseved Slot:- \(slots.3)")
                }
            }
        }
        return item.0
    }
    
    public func exitParking(_ make: VehicleMakeType, _ model: VehicleModeType, isReservedCategory: Bool = false) ->Int {
        let item = self.parkingInOrOut(isIn: false, make, model,  isReservedCategory)
        if item.0 {
           self.delegate?.parkingFactory(self, didUpdateSlots: availableSlotAtFloors)
        }
        return item.1
    }
    
    private func parkingInOrOut(isIn: Bool, _ make: VehicleMakeType, _ model: VehicleModeType, _ isReservedCategory: Bool) -> (Bool, Int) {
      
        for floor in self.nfloor {
            if isReservedCategory {
                for slot in floor.resevredSlot {
                    if slot.isSlotAvailableForParking(make, model), isIn {
                        slot.updateInOrOutTime(isIn: isIn)
                        floor.availableRSlot -= 1
                        return (true,0)
                    }
                    if !isIn, slot.isSlotBooked(make, model) {
                        slot.updateInOrOutTime(isIn: isIn)
                        floor.availableRSlot += 1
                        let fee = slot.calculateParkingFee
                        slot.inTime = 0
                        slot.outTime = 0
                        return (true,fee)
                    }
                }
                continue
            }
            for slot in floor.nSmallSlot {
                if slot.isSlotAvailableForParking(make, model), isIn {
                    slot.updateInOrOutTime(isIn: isIn)
                    floor.availableSSlot -= 1
                    return (true,0)
                }
                if !isIn, slot.isSlotBooked(make, model) {
                    slot.updateInOrOutTime(isIn: isIn)
                    floor.availableSSlot += 1
                    let fee = slot.calculateParkingFee
                    slot.inTime = 0
                    slot.outTime = 0
                    return (true,fee)
                }
                
            }
            for slot in floor.nLargeSlot {
                if slot.isSlotAvailableForParking(make, model), isIn {
                    slot.updateInOrOutTime(isIn: isIn)
                    floor.availableLSlot -= 1
                    return (true,0)
                }
                if !isIn, slot.isSlotBooked(make, model) {
                    slot.updateInOrOutTime(isIn: isIn)
                    floor.availableLSlot += 1
                    let fee = slot.calculateParkingFee
                    slot.inTime = 0
                    slot.outTime = 0
                    return (true,fee)
                }
            }
            for slot in floor.nExtraLargeSlot {
                if slot.isSlotAvailableForParking(make, model), isIn {
                    slot.updateInOrOutTime(isIn: isIn)
                    floor.availableXLSlot -= 1
                    return (true,0)
                }
                if !isIn, slot.isSlotBooked(make, model) {
                    slot.updateInOrOutTime(isIn: isIn)
                    floor.availableXLSlot += 1
                    let fee = slot.calculateParkingFee
                    slot.inTime = 0
                    slot.outTime = 0
                    return (true,fee)
                }
            }
        }
        return  (false,0)
    }
    
  
}


/* Want to extend the floor
 Step 1. Add floor Index
 Step 2. Create Floor Index class
 Example
 class FourthFloor: BaseFloor {
     override init() {
         super.init()
         self.nSmallSlot = [SmallSlot(),SmallSlot(),SmallSlot()]
         self.nLargeSlot = [LargeSlot(),LargeSlot()]
         self.nExtraLargeSlot =  [ExtraLargeSlot(),ExtraLargeSlot(),ExtraLargeSlot()]
         self.availableSSlot = self.nSmallSlot.count
         self.availableLSlot = self.nLargeSlot.count
         self.availableXLSlot = self.nExtraLargeSlot.count
     }
 }
*/

