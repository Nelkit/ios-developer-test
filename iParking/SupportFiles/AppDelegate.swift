//
//  AppDelegate.swift
//  iParking
//
//  Created by Nelkit Chavez on 21/10/20.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        
        
        
        
        /// Inicializo con algunas tablas que necesito con valores para el ejemplo
        let database = DatabaseManager()
        
        
        /// Agrego los registros de tipos de Vehiculos
        let vehicleType1 = VehicleType(code: "official", descrip: "Oficiales", fare: 0.0)
        let vehicleType2 = VehicleType(code: "resident", descrip: "Residentes", fare: 0.05)
        let vehicleType3 = VehicleType(code: "no_resident", descrip: "No Residentes", fare: 0.5)
        
        /// Agrego los registros de tarifas a la tabla Fare
        
        for models in [ vehicleType1, vehicleType2, vehicleType3]{
            database.create(models)
        }
        
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

