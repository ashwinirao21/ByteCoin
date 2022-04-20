//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIPickerViewDataSource {
    
    @IBOutlet weak var bitcoinLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    @IBOutlet weak var currencyPicker: UIPickerView!
    
    var coinManager = CoinManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        
    }
    
}

//MARK: - UIPickerViewDelegate

extension ViewController : UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int { //no.of columns in pickerview
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int { //no.of rows in pickerview
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return coinManager.currencyArray[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let currency = coinManager.currencyArray[row]
        self.currencyLabel.text = currency
        coinManager.getCoinPrice(for: currency)
    }
    
}

//MARK: - CoinManagerDelegate

extension ViewController : CoinManagerDelegate {
    
    func getBitCoinPrice(of price: String) {
        DispatchQueue.main.async {
            self.bitcoinLabel.text = price
        }
    }
    
    func didFailWithError(error: Error) {
        print(error)
    }
    
}
