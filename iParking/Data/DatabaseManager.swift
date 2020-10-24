//
//  DatabaseManager.swift
//  iParking
//
//  Created by Nelkit Chavez on 22/10/20.
//

import Foundation
import RealmSwift

class DatabaseManager {

    private let NotificationError = Notification.Name.init(rawValue: "Realm")

    let realm: Realm
    init(realm: Realm = try! Realm()) {
        self.realm = realm
    }

    func create<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.add(object, update: .modified)
            }
        } catch {
            post(error)
        }
    }

    func create<T: Object>(_ objects: [T]) {
        do {
            try realm.write {
                realm.add(objects, update: .modified)
            }
        } catch {
            post(error)
        }
    }

    func read<T: Object>(_ object: T.Type) -> Results<T> {
        let result = realm.objects(object.self)
        return result
    }

    func update<T: Object>(_ object: T, with dictionary: [String: Any]) {
        do {
            try realm.write {
                for (key, value) in dictionary {
                    object.setValue(value, forKey: key)
                }
            }
        } catch {
            post(error)
        }
    }

    func delete<T: Object>(_ object: T) {
        do {
            try realm.write {
                realm.delete(object)
            }
        } catch {
            post(error)
        }
    }

    func post(_ error: Error) {
        NotificationCenter.default.post(name: NotificationError, object: error)
    }

    func observeRealErrors(in viewController: UIViewController, complation: @escaping (Error?) -> Void) {
        NotificationCenter.default.addObserver(forName: NotificationError, object: viewController, queue: nil) { (notification) in
            complation(notification.object as? Error)
        }
    }

    func stopObserveRealErrors(in viewController: UIViewController) {
        NotificationCenter.default.removeObserver(viewController, name: NotificationError, object: nil)
    }
}
