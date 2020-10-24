//
//  Extensions.swift
//  iParking
//
//  Created by Nelkit Chavez on 23/10/20.
//

import Foundation

// MARK: Double Extensions
extension Double {
    /// Rounds the double to decimal places value
    func format(toPlaces places:Int) -> String {
        return String(format: "%.\(places)f", self)
    }
}
