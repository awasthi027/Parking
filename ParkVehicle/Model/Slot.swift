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

enum SlotType {
    case undefined
    case small
    case large
    case extraLarge
}

enum VehicleMakeType: Int {
    case honda
    case tata
    case mahindra
    case maruti
}

public enum VehicleModeType: Int {
    case hBike1, hBike2, hBike3, mBike1, mhBike1
    case hCar1, tCar1, mhCar1, mCar1
    case mhMiniBus1, hMiniBus1, tMiniBus1
    case mhBus1, mhBus2, tBus1, tBus2
    case tTruck1, tTruck2,mhTruck1,mhTruck2
}

class BaseSlot: NSObject {
    var type: SlotType = .undefined
    internal var isOccupied: Bool = false
    internal var supportParkSlots: [VehicleMakeType: [VehicleModeType]] = [:]
    var inTime: TimeInterval = 0
    var outTime: TimeInterval = 0
    var feePerHour: Int = 0
    func isSlotAvailableForParking(_ make: VehicleMakeType, _ model: VehicleModeType) ->Bool {
        if !self.isOccupied, let modelList = self.supportParkSlots[make], modelList.contains(model) {
            return true
        }
        return false
    }
    func isSlotBooked(_ make: VehicleMakeType, _ model: VehicleModeType) ->Bool {
        if self.isOccupied, let modelList = self.supportParkSlots[make], modelList.contains(model) {
            return true
        }
        return false
    }
   internal var calculateParkingFee: Int {
        let diff = self.inTime - self.outTime
        let hours = diff / 3600
        let minutes = (diff - hours * 3600) / 60
        var fee = Int(hours) * self.feePerHour
        if minutes > 30 {
            fee += self.feePerHour
        }
        return fee
    }
    internal func updateInOrOutTime(isIn: Bool) {
        self.isOccupied = isIn
        if isIn {
            self.inTime = Date().timeIntervalSince1970
        }else {
            self.outTime = Date().timeIntervalSince1970
        }
    }
}

class SmallSlot: BaseSlot {
    override init() {
        super.init()
        self.type = .small
        self.supportParkSlots  = [.honda : [.hBike1,.hBike2,.hBike3],.maruti : [.mBike1],.mahindra : [.mhBike1]]
        self.feePerHour = 10
    }
}
class LargeSlot: BaseSlot {
    override init() {
        super.init()
        self.type = .large
        self.supportParkSlots  = [.honda : [.hCar1,.hMiniBus1],.maruti :
            [.mCar1],.mahindra : [.mhCar1,.mhMiniBus1], .tata : [.tCar1,.tMiniBus1]]
        self.feePerHour = 20
    }
}
class ExtraLargeSlot: BaseSlot {
    override init() {
        super.init()
        self.type = .extraLarge
        self.supportParkSlots  = [.mahindra : [.mhBus1,.mhBus2,.mhTruck1, .mhTruck2], .tata : [.tTruck1,.tTruck2,.tBus1,.tBus2]]
        self.feePerHour = 40
    }
}


