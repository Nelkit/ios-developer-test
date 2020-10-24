//
//  ParkingTimetLog.swift
//  iParking
//
//  Created by Nelkit Chavez on 23/10/20.
//

import Foundation
import RealmSwift

class ParkingTimetLog: Object{
    @objc dynamic var licensePlate: String = ""
    @objc dynamic var totalTime: Double = 0.0
    
    override static func primaryKey() -> String?{
        return "licensePlate"
    }
    
    convenience init(licensePlate: String, totalTime: Double) {
        self.init()
        self.licensePlate = licensePlate
        self.totalTime = totalTime
    }
}
