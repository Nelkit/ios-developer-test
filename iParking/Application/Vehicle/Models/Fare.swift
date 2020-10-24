//
//  Fare.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

class Fare: Object{
    @objc dynamic var id: Int=0
    @objc dynamic var timefare: Double=0.0
    
    override static func primaryKey() -> String?{
        return "id"
    }
    
    convenience init(id: Int, timefare: Double) {
        self.init()
        self.id = id
        self.timefare = timefare
    }
    
}



