//
//  ViewController.swift
//  AddressApplication
//
//  Created by Dmitry Shcherbakov on 15.11.2020.
//

import UIKit

class AddressViewController: UIViewController {

    @IBOutlet var addressTextField: UITextField!
    
    private let networkAddressManager = NetworkAddressManager.shared

    @IBAction func pressedSearchAddress() {
        networkAddressManager.fetchAddress(
            forAddress: addressTextField.text ?? ""
        ) { addresses in
            DispatchQueue.main.async {
                if addresses.count == 0 {
                    self.showAlert(title: "Упс!",
                                   message: "Квартира не была найдена :(")
                    return
                }

                let address = addresses.first

                guard let flatArea = address?.flat_area,
                      let squareMeterPrice = address?.square_meter_price,
                      let flatPrice = address?.flat_price else {
                    self.showAlert(title: "Упс!",
                                   message: "Квартира не была найдена :(")
                    return
                }
                
                self.showAlert(
                    title: "Ура, квартира найдена!",
                    message: "Площадь квартиры: \(flatArea)\nРыночная стоимость " +
                        "м²: \(squareMeterPrice)\nРыночная стоимость квартиры: \(flatPrice)")
            }
        }
    }
    
    private func showAlert(title: String, message: String) {
        let alert = UIAlertController(title: title,
                                      message: message,
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "OK", style: .default)
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

