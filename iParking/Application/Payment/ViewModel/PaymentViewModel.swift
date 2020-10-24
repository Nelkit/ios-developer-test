//
//  PaymentViewModel.swift
//  iParking
//
//  Created by Nelkit Chavez on 23/10/20.
//

import Foundation

class PaymentViewModel {
    
    weak var view: PaymentView?
    var logList: Array<ParkingTimetLog> = Array<ParkingTimetLog>()
    
    init(view: PaymentView) {
        self.view = view
        let database = DatabaseManager()
        
        logList = Array<ParkingTimetLog>(database.read(ParkingTimetLog.self))
    }
    
}
