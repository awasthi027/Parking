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
enum FloorIndex: Int {
    case basement
    case first
    case second
    case third
    case undefined
}

class BaseFloor {
    var availableSSlot: Int = 0
    var availableLSlot: Int = 0
    var availableXLSlot: Int = 0
    var nSmallSlot: [SmallSlot] = []
    var nLargeSlot: [LargeSlot] = []
    var nExtraLargeSlot: [ExtraLargeSlot] = []
    /* Resevred slot for special catgeory person Like handcaft, disabled ect..*/
    var resevredSlot: [BaseSlot] = []
    var availableRSlot: Int = 0
    var floorIndex: FloorIndex = .undefined
}

class Basement: BaseFloor {
    override init() {
        super.init()
        self.floorIndex = .basement
        resevredSlot = [LargeSlot(), SmallSlot()]
        availableRSlot = resevredSlot.count
        self.nSmallSlot = [SmallSlot(),SmallSlot(),SmallSlot(),SmallSlot(),SmallSlot()]
        self.nLargeSlot = [LargeSlot(),LargeSlot(),LargeSlot()]
        self.nExtraLargeSlot =  [ExtraLargeSlot()]
        self.availableSSlot = self.nSmallSlot.count
        self.availableLSlot = self.nLargeSlot.count
        self.availableXLSlot = self.nExtraLargeSlot.count
    }
}

class FisrtFloor: BaseFloor {
    override init() {
        super.init()
        self.floorIndex = .first
        resevredSlot = [SmallSlot()]
        availableRSlot = resevredSlot.count
        self.nSmallSlot = [SmallSlot(),SmallSlot()]
        self.nLargeSlot = [LargeSlot(),LargeSlot(),LargeSlot()]
        self.nExtraLargeSlot =  [ExtraLargeSlot(),ExtraLargeSlot()]
        self.availableSSlot = self.nSmallSlot.count
        self.availableLSlot = self.nLargeSlot.count
        self.availableXLSlot = self.nExtraLargeSlot.count
    }
}

class SecondFloor: BaseFloor {
    override init() {
        super.init()
         self.floorIndex = .second
        resevredSlot = [ExtraLargeSlot()]
        availableRSlot = resevredSlot.count
        self.nSmallSlot = [SmallSlot(),SmallSlot()]
        self.nLargeSlot = [LargeSlot(),LargeSlot(),LargeSlot()]
        self.nExtraLargeSlot =  [ExtraLargeSlot(),ExtraLargeSlot()]
        self.availableSSlot = self.nSmallSlot.count
        self.availableLSlot = self.nLargeSlot.count
        self.availableXLSlot = self.nExtraLargeSlot.count
    }
}

class ThirdFloor: BaseFloor {
    override init() {
        super.init()
        self.floorIndex = .third
        self.nSmallSlot = [SmallSlot(),SmallSlot(),SmallSlot()]
        self.nLargeSlot = [LargeSlot(),LargeSlot()]
        self.nExtraLargeSlot =  [ExtraLargeSlot(),ExtraLargeSlot(),ExtraLargeSlot()]
        self.availableSSlot = self.nSmallSlot.count
        self.availableLSlot = self.nLargeSlot.count
        self.availableXLSlot = self.nExtraLargeSlot.count
    }
}
