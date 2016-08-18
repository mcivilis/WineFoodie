//
//  LCBOStore.swift
//  WineFoodie
//
//  Created by Masha on 2016-08-17.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

extension LCBOStore : JSONParselable {
    
    static func withJSON(json: [String : AnyObject]) -> LCBOStore? {
        guard
            let id = int(json, key: "id"),
            name = string(json, key: "name"),
            address = string(json, key: "address_line_1"),
            city = string(json, key: "city"),
            postalCode = string(json, key: "postal_code"),
            telephone = string(json, key: "telephone"),
            latitude = double(json, key: "latitude"),
            longitude = double(json, key: "longitude"),
            hasParking = bool(json, key: "has_parking"),
            distanceInMeters = int(json, key: "distance_in_meters"),
            quantity = int(json, key: "quantity")
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