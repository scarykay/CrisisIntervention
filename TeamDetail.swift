//
//  TeamDetail.swift
//  
//
//  Created by Mary K Paquette on 9/11/15.
//
//

import Foundation
import CoreData

class TeamDetail: NSManagedObject {

    @NSManaged var zipcode: NSNumber
    @NSManaged var phone: NSNumber
    @NSManaged var city: String
    @NSManaged var name: String
    @NSManaged var coordinator: String
    @NSManaged var email: String
    @NSManaged var facility: String
    @NSManaged var state: String

}
