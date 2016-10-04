//
//  LCBOStore.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-17.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension LCBOStore : JSONParselable {
    
    static func withJSON(_ json: [String : AnyObject]) -> LCBOStore? {
        guard
            let id = int(json, key: "id"),
            let name = string(json, key: "name"),
            let address = string(json, key: "address_line_1"),
            let city = string(json, key: "city"),
            let postalCode = string(json, key: "postal_code"),
            let telephone = string(json, key: "telephone"),
            let latitude = double(json, key: "latitude"),
            let longitude = double(json, key: "longitude"),
            let hasParking = bool(json, key: "has_parking"),
            let distanceInMeters = int(json, key: "distance_in_meters"),
            let quantity = int(json, key: "quantity")
            else {
                return nil
        }
        return LCBOStore(id: id,
                         name: name,
                         address: address,
                         city: city,
                         postalCode: postalCode,
                         telephone: telephone,
                         latitude: latitude,
                         longitude: longitude,
                         hasParking: hasParking,
                         distanceInMeters: distanceInMeters,
                         quantity: quantity)
    }
}
