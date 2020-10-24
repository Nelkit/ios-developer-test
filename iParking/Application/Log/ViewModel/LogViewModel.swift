//
//  LogViewModel.swift
//  iParking
//
//  Created by Nelkit Chavez on 23/10/20.
//

import Foundation
import RealmSwift

protocol LogViewDelegate {
    func onLogEntryVehicle(licensePlate: String)
    func onLogExitVehicle(licensePlate: String)
}

class LogViewModel {
    
    weak var view: LogView?
    
    init(view: LogView) {
        self.view = view
    }
    
    func calculateTimeInParking(_ dateEntry: Date, _ dateExit: Date) -> Double {
        let dateEntryMinutes = dateEntry.timeIntervalSinceReferenceDate/60
        let dateExitMinutes = dateExit.timeIntervalSinceReferenceDate/60

        return Double(dateExitMinutes - dateEntryMinutes)
    }
    
    func fareToPayment(log: ParkingLog) -> Double {
        let database = DatabaseManager()
        
        if let vehicleType = database.read(VehicleType.self).filter("code='\(VehicleTypeEnum.NoResident.rawValue)'").first{
            let duration = calculateTimeInParking(log.entryDate, log.exitDate)
            let vehicleFare = vehicleType.timefare
            let totalFare = duration * vehicleFare
            return totalFare
        }else{
            return 0.0
        }
    }
    
    func logTotalTime(log: ParkingLog) {
        let database = DatabaseManager()
        
        if let vehicle = log.vehicle{
            let duration = calculateTimeInParking(log.entryDate, log.exitDate)
            
            if let timeLog = database.read(ParkingTimetLog.self).filter("licensePlate='\(vehicle.licensePlate)'").first{
                database.realm.beginWrite()
                timeLog.totalTime = timeLog.totalTime + duration
                try! database.realm.commitWrite()
            }else{
                let timeLog = ParkingTimetLog(licensePlate: vehicle.licensePlate, totalTime: duration)
                database.create(timeLog)
            }
        }
        
        print(database.read(ParkingTimetLog.self))
    }
}

extension LogViewModel: LogViewDelegate{
    func onLogEntryVehicle(licensePlate: String) {
        let database = DatabaseManager()
        
        if database.read(ParkingLog.self).filter("vehicle.licensePlate='\(licensePlate)' AND currentlyParked=1").first != nil{
            self.view?.logEntryFail(msg: "El vehiculo actualmente esta adentro del parqueo")
            return
        }

        if let vehicle = database.read(Vehicle.self).filter("licensePlate='\(licensePlate)'").first{
            let newParkingLogEntry = ParkingLog(currentlyParked: true, entryDate: Date(), exitDate: Date(), vehicle: vehicle)
            
            database.create(newParkingLogEntry)
            
            self.view?.logEntrySuccess(vehicle: vehicle)
        }else{
            let vehicle = Vehicle()
            vehicle.licensePlate = licensePlate
            vehicle.type = database.read(VehicleType.self).filter("code='\(VehicleTypeEnum.NoResident.rawValue)'").first
            let newParkingLogEntry = ParkingLog(currentlyParked: true, entryDate: Date(), exitDate: Date(), vehicle: vehicle)
            
            database.create(newParkingLogEntry)
            
            self.view?.logEntrySuccess(vehicle: vehicle)
        }
        
        print(database.read(ParkingTimetLog.self))
    }
    
    func onLogExitVehicle(licensePlate: String) {
        let database = DatabaseManager()

        if let log = database.read(ParkingLog.self).filter("vehicle.licensePlate='\(licensePlate)' AND currentlyParked=1").first{
            database.realm.beginWrite()
            log.currentlyParked = false
            log.exitDate = Date()
            try! database.realm.commitWrite()
            
            if let vehicle = log.vehicle, let type = vehicle.type{
                switch type.code {
                case VehicleTypeEnum.Resident.rawValue:
                    logTotalTime(log: log)
                    break
                case VehicleTypeEnum.NoResident.rawValue:
                    let fare = fareToPayment(log: log)
                    self.view?.showTotalAmountToPay(amount: fare.format(toPlaces: 2))
                    break
                default:
                    break
                }
            }

            self.view?.logExitSuccess(log: log)
        }else{
            self.view?.logEntryFail(msg: "No Encontramos ningún registro de parqueo con esa placa")
        }
        
        print(database.read(ParkingLog.self))
    }
}
