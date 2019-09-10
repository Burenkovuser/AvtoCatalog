//
//  Car.swift
//  AvtoCatalog
//
//  Created by Vasilii on 10/09/2019.
//  Copyright © 2019 Vasilii Burenkov. All rights reserved.
//

import RealmSwift

class Car: Object {
    @objc dynamic var manufacturer = ""
    @objc dynamic var model = ""
    @objc dynamic var year = ""
    @objc dynamic var bodyType = ""
}
