//
//  ObjectsData.swift
//  Avsw_test
//
//  Created by Владислав on 19.10.2020.
//

import Foundation
import CoreData

struct ObjectsData {
    let name: String
    let surname: String
    let optional: String
}


class ObjectsInfo {
    static var shared = ObjectsInfo()
    var objects: [NSManagedObject] = []
    var objectsEdit: NSManagedObject? = nil
    var objectsEditIndex: Int? = nil
}

