//
//  VehicleViewModel.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

protocol VehicleViewDelegate {
    func onAddNewVehicle(licensePlate: String)
}

class VehicleViewModel {
    
    weak var view: VehicleView?
    var notificationToken: NotificationToken? = nil
    var vehicles: [Vehicle] = []
    
    init(view: VehicleView) {
        self.view = view
        let database = DatabaseManager()
        
        let vehicleResults = database.read(Vehicle.self)
        
//        notificationToken = vehicleResults.observe({ [weak self] (changes: RealmCollectionChange) in
//            switch changes {
//            case .initial:
//                break
//            case .update(_, let deletions, let insertions, let modifications):
//                print(insertions)
//                break
//            case .error(let error):
//                break
//            }
//        })
        
        for vehicle in vehicleResults {
            vehicles.append(vehicle)
        }
    }
    
    deinit {
        notificationToken?.invalidate()
    }
    
}

extension VehicleViewModel: VehicleViewDelegate{
    func onAddNewVehicle(licensePlate: String) {
        let database = DatabaseManager()

        
        if let type = database.read(VehicleType.self).filter("code='official'").first{
            let newVehicle = Vehicle(licensePlate: licensePlate, type: type)

            database.create(newVehicle)
            
            
            vehicles = []
            let vehicleResults = database.read(Vehicle.self)
            for vehicle in vehicleResults {
                vehicles.append(vehicle)
            }
            
            self.view?.reloadItems()
        }
        
        

    }
}
