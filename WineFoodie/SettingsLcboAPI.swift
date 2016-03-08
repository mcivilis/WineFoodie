//
//  SettingsLcboAPI.swift
//  WineFoodie
//
//  Created by Maria Civilis on 2016-03-08.
//  Copyright © 2016 mcivilis. All rights reserved.
//

import Foundation

let lcboProductsAPI = "http://lcboapi.com/products"
let lcboQueryParameters = "?per_page=100?where_not=is_dead" //max page = 100
let lcboAPIKey = "?access_key=" + "MDpkZTFhZmYyNi1kOThlLTExZTUtYmZiNy02M2I1YzUwOTAwNjI6WUpVd0xQckJEVVdEWDBLVGJNeWFTZkpUOXVRQmhTU2x6WDMw"
let lcboSort = "&store_id=10" + "&order=inventory_count"
let lcboQueryCommand = "&q="

let lcboStoresAPI = "http://lcboapi.com/stores"
let storesPerPage = "&per_page=100"
