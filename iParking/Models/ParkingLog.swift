//
//  ParkingLog.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

class ParkingLog: Object{
    @objc dynamic var id: Int = 0
    @objc dynamic var entryDate = Date()
    @objc dynamic var exitDate = Date()
    @objc dynamic var vehicle: Vehicle?
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
}

