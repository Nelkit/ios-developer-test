//
//  Menu.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation

protocol MenuPresentable {
    var id: Int? { get }
    var title: String? { get }
    var icon: String? { get }
}

struct Menu: MenuPresentable {
    var id: Int? = 0
    var title: String? = ""
    var icon: String? = ""
}
