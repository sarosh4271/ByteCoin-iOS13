//
//  ViewController.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UIPickerViewDataSource, UIPickerViewDelegate{
    
    var coinManager = CoinManager()
    
    @IBOutlet weak var currencyPicker: UIPickerView!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var currencyLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        currencyPicker.dataSource = self
        currencyPicker.delegate = self
        coinManager.delegate = self
        // Do any additional setup after loading the view.
    }


}


//MARK: - UIPickerViewDataSource

extension ViewController{
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        let selectedCurrencyName = coinManager.currencyArray[row]
        
       coinManager.getCoinPrice(for: selectedCurrencyName)
        currencyLabel.text = selectedCurrencyName
 
        print(selectedCurrencyName)
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return coinManager.currencyArray.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        let currencyList = coinManager.currencyArray[row]
        
        
        return currencyList
    }

}

//MARK: - CoinManagerDelegate
extension ViewController:CoinManagerDelegate{
    func didFailWithError(error: Error) {
        print(error)
    }
    func didUpdateCoin(_ coinManager: CoinManager, coin: CoinModel) {
        DispatchQueue.main.async {
            self.priceLabel.text = coin.coinRateString
        }
    }
}
