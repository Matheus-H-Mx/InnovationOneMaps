//
//
//  Address.swift
//
// InnovationOneMaps
//
//  Created by Matheus Henrique on 13/04/22.
//

import Foundation
import  Contacts
import CoreLocation

struct Address {
    var name: String
    var placework: CLPlacemark
    var postalAddres: CNPostalAddress           // endereço da lib 
    
    
    init (name: String, placework: CLPlacemark, postalAddress: CNPostalAddress) {
        
        self.name       = name
        self.placework  = placework
        self.postalAddres = postalAddress
        
    }
}
