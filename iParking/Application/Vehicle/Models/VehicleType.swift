//
//  VehicleType.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

class VehicleType: Object{
    @objc dynamic var code: String = "" // official, resident, no_resident
    @objc dynamic var descrip: String="" //Puede ser (oficial, residentes, no residentes)
    @objc dynamic var timefare: Double = 0.0
    
    override static func primaryKey() -> String?{
        return "code"
    }
    
    convenience init(code: String, descrip: String, fare: Double) {
        self.init()
        self.code = code
        self.descrip = descrip
        self.timefare = fare
    }
}
