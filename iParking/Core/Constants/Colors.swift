//
//  Colors.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import UIKit

class Colors {
    static func background () -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "Background")!
        }else{
            return UIColor.lightGray
        }
    }
    
    static func primary () -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "Primary")!
        }else{
            return UIColor.white
        }
    }
    
    static func primaryText () -> UIColor {
        if #available(iOS 13.0, *) {
            return UIColor(named: "PrimaryText")!
        }else{
            return UIColor.black
        }
    }
}
