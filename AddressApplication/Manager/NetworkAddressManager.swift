//
//  NetworkAddressManager.swift
//  AddressApplication
//
//  Created by Dmitry Shcherbakov on 15.11.2020.
//

import Foundation
import Alamofire

class NetworkAddressManager {
    
    static let shared = NetworkAddressManager()
    
    private let token = "69a06b8d11a12af8b91908fcd07fa2b1d1152643"
    private let xSecret = "085b333c95a84ab70460c15d88b11c0e4fd286ca"
    private let urlStr = "https://cleaner.dadata.ru/api/v1/clean/address"
    
    private init() {}
    
    func fetchAddress(forAddress address: String, completion: @escaping (([Address]) -> Void)) {
        let headers: HTTPHeaders = ["Content-Type": "application/json",
                                    "Authorization": "Token \(token)",
                                    "X-Secret": "\(xSecret)"]
        let data = Data("[\"\(address)\"]".utf8)
        
        AF.upload(data, to: urlStr, method: .post, headers: headers)
            .validate()
            .responseJSON { dataResponse in
                switch dataResponse.result {
                case .success(let value):
                    let addresses = Address.getAddresses(from: value) ?? []
                    completion(addresses)
                case .failure(let error):
                    print(error)
                    completion([])
                }
            }
    }

}
