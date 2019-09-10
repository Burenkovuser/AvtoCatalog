//
//  StorageManager.swift
//  AvtoCatalog
//
//  Created by Vasilii on 10/09/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import RealmSwift

let realmCar = try! Realm()

class StorageManager {
    static func SaveCar(_ cars: [Car]) {
        try! realmCar.write {
            realmCar.add(cars)
        }

    }
}
