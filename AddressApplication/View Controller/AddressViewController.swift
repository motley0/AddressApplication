//
//  ViewController.swift
//  AddressApplication
//
//  Created by Dmitry Shcherbakov on 15.11.2020.
//

import UIKit

class AddressViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet var addressTextField: UITextField!
    
    private let networkAddressManager = NetworkAddressManager.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addressTextField.delegate = self
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
            super.touchesBegan(touches, with: event)
            view.endEditing(true)
    }

    @IBAction func pressedSearchAddress() {
        networkAddressManager.fetchAddress(
            forAddress: addressTextField.text ?? ""
        ) { addresses in
            DispatchQueue.main.async {
                if addresses.count > 0,
                   let address = addresses.first,
                   let flatArea = address.flatArea,
                   let squareMeterPrice = address.squareMeterPrice,
                   let flatPrice = address.flatPrice {
                    self.showAlert(
                        title: "Ура, квартира найдена!",
                        message: "Площадь квартиры: \(flatArea) м²\nСтоимость " +
                            "м²: \(squareMeterPrice) руб.\n" +
                            "Рыночная стоимость квартиры: \(flatPrice) руб.")
                    return
                }
                
                self.showAlert(title: "Упс!",
                               message: "Квартира не была найдена :(")
            }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        pressedSearchAddress()
        return true
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
