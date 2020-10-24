//
//  VehicleViewModel.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

protocol VehicleViewDelegate {
    func onAddNewVehicle(licensePlate: String, vehicleTypeEnum: VehicleTypeEnum)
}

class VehicleViewModel {
    
    weak var view: VehicleView?
    var vehicles: Array<Vehicle> = Array<Vehicle>()
    
    init(view: VehicleView, vehicleTypeEnum: VehicleTypeEnum) {
        self.view = view
        let database = DatabaseManager()
        vehicles = Array<Vehicle>(database.read(Vehicle.self).filter("type.code='\(vehicleTypeEnum.rawValue)'"))
    }
    
}

extension VehicleViewModel: VehicleViewDelegate{
    func onAddNewVehicle(licensePlate: String, vehicleTypeEnum: VehicleTypeEnum) {
        let database = DatabaseManager()

        if let type = database.read(VehicleType.self).filter("code='\(vehicleTypeEnum.rawValue)'").first{
            let newVehicle = Vehicle(licensePlate: licensePlate, type: type)
            
            database.create(newVehicle)
            
            vehicles = []
            vehicles = Array<Vehicle>(database.read(Vehicle.self).filter("type.code='\(vehicleTypeEnum.rawValue)'"))
            
            self.view?.reloadItems()
        }
    }
}
