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
    @objc dynamic var currentlyParked: Bool = false
    @objc dynamic var entryDate = Date()
    @objc dynamic var exitDate = Date()
    @objc dynamic var vehicle: Vehicle?
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(currentlyParked: Bool, entryDate: Date, exitDate: Date, vehicle: Vehicle) {
        self.init()
        self.id = ParkingLog.nextID()
        self.currentlyParked = currentlyParked
        self.entryDate = entryDate
        self.exitDate = exitDate
        self.vehicle = vehicle
    }
    
    static func nextID() -> Int{
        let database = DatabaseManager()
        var nextId: Int = 1
        let topId: Int? = database.read(ParkingLog.self).max(ofProperty: "id")
        if let top: Int = topId{
            nextId = top+1
        }
        return nextId
    }
}

