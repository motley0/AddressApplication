//
//  Address.swift
//  AddressApplication
//
//  Created by Dmitry Shcherbakov on 15.11.2020.
//

import Foundation

struct Address {
    
    let flatArea: String?
    let squareMeterPrice: String?
    let flatPrice: String?
    
    init(addressesData: [String: Any]) {
        flatArea = addressesData["flat_area"] as? String
        squareMeterPrice = addressesData["square_meter_price"] as? String
        flatPrice = addressesData["flat_price"] as? String
    }
    
    static func getAddresses(from value: Any) -> [Address]? {
        guard let addressesData = value as? [[String: Any]] else { return nil }
        return addressesData.compactMap { Address(addressesData: $0) }
    }
}
