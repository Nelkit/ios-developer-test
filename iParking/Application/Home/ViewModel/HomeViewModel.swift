//
//  HomeViewModel.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation


protocol HomeViewDelegate {
    func resetMonth()
}

struct HomeViewModel {
    
    init() {
        let option1 = Menu(id: 1, title: "Registrar Entrada", icon: "entry_icon_80")
        let option2 = Menu(id: 2, title: "Registrar salida", icon: "exit_icon_80")
        let option3 = Menu(id: 3, title: "Da de alta vehículo oficial", icon: "official_icon_80")
        let option4 = Menu(id: 4, title: "Da de alta vehículo de residente", icon: "resident_icon_80")
        let option5 = Menu(id: 5, title: "Comienza mes", icon: "start_month_icon_80")
        let option6 = Menu(id: 6, title: "Pagos de residentes", icon: "payment_icon_80")
        options.append(contentsOf: [option1, option2, option3, option4, option5, option6])
        
    }
    
    var options: [MenuPresentable] = []
    
}

extension HomeViewModel: HomeViewDelegate{
    func resetMonth() {
        let database = DatabaseManager()
        let allOfficialLogs = database.read(ParkingLog.self).filter("vehicle.type.code = '\(VehicleTypeEnum.Official.rawValue)'")
        
        for log in allOfficialLogs{
            database.delete(log)
        }
        
        let allResidentLogs = database.read(ParkingTimetLog.self)
        database.realm.beginWrite()
        for timeLog in allResidentLogs{
            timeLog.totalTime = 0
        }
        try! database.realm.commitWrite()
        
        print(database.read(ParkingTimetLog.self))
    }
    
    
}


