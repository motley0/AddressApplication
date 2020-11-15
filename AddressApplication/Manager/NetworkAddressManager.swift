//
//  NetworkAddressManager.swift
//  AddressApplication
//
//  Created by Dmitry Shcherbakov on 15.11.2020.
//

import Foundation

class NetworkAddressManager {
    
    static let shared = NetworkAddressManager()
    
    private let token = "69a06b8d11a12af8b91908fcd07fa2b1d1152643"
    private let xSecret = "085b333c95a84ab70460c15d88b11c0e4fd286ca"
    private let urlStr = "https://cleaner.dadata.ru/api/v1/clean/address"
    
    func fetchAddress(forAddress address: String, onCompletion: @escaping (([Address]) -> Void)) {
        guard let url = URL(string: urlStr) else { return }
        let request = createURLRequest(url: url, address: address)
        
        URLSession.shared.dataTask(with: request) { (data, _, _) in
            if let data = data {
                let addresses = self.parseJSON(data: data)
                onCompletion(addresses)
            } else {
                onCompletion([])
            }
        }.resume()
    }
    
    private func createURLRequest(url: URL, address: String) -> URLRequest {
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Token \(token)", forHTTPHeaderField: "Authorization")
        request.setValue("\(xSecret)", forHTTPHeaderField: "X-Secret")
        request.httpBody = "[\"\(address)\"]".data(using: .utf8)
        
        return request
    }
    
    private func parseJSON(data: Data) -> [Address] {
        do {
           return try JSONDecoder().decode([Address].self, from: data)
        } catch let error {
            print(error)
            return []
        }
    }
    
    private init() {}

}
