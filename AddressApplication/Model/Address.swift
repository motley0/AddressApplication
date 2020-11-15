//
//  Address.swift
//  AddressApplication
//
//  Created by Dmitry Shcherbakov on 15.11.2020.
//

import Foundation

struct Address: Decodable {
    let flat_area: String? // Площадь квартиры
    let square_meter_price: String? //Рыночная стоимость м²
    let flat_price: String? // Рыночная стоимость квартиры
}
