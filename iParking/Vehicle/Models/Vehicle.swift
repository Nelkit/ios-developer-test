//
//  Vehicle.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

class Vehicle: Object{
    @objc dynamic var licensePlate: String = ""
    @objc var type: VehicleType?
    
    override static func primaryKey() -> String?{
        return "licensePlate"
    }
    
    convenience init(licensePlate: String, type: VehicleType) {
        self.init()
        self.licensePlate = licensePlate
        self.type = type
    }
}
