//
//  ObjectsData.swift
//  Avsw_test
//
//  Created by Владислав on 19.10.2020.
//

import Foundation


struct ObjectsData {
    let name: String
    let surname: String
    let optional: String
}


class ObjectsInfo {
    static var shared = ObjectsInfo()
    var objects: [ObjectsData] = []
    var objectsEdit: ObjectsData? = nil
    var objectsEditIndex: Int? = nil
}

