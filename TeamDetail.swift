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

    @NSManaged var zipcode: String?
    @NSManaged var phone: String?
    @NSManaged var city: String?
    @NSManaged var name: String?
    @NSManaged var coordinator: String?
    @NSManaged var email: String?
    @NSManaged var facility: String?
    @NSManaged var state: String?
    
    
    func csv() -> String {
        
        let coalescedZipcode = zipcode ?? ""
        let coalescedPhone = phone ?? ""
        let coalescedCity = city ?? ""
        let coalescedName = name ?? ""
        let coalescedCoordinator = coordinator ?? ""
        let coalescedEmail = email ?? ""
        let coalescedFacility = facility ?? ""
        let coalescedState = state ?? ""
        
        return "\(coalescedZipcode),\(coalescedPhone)," +
            "\(coalescedCity),\(coalescedName)," +
            "\(coalescedCoordinator),\(coalescedEmail)," +
        "\(coalescedFacility),\(coalescedState)\n"
    }

}
