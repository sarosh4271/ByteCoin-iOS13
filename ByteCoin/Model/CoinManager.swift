//
//  CoinManager.swift
//  ByteCoin
//
//  Created by Angela Yu on 11/09/2019.
//  Copyright © 2019 The App Brewery. All rights reserved.
//

import UIKit

protocol CoinManagerDelegate{
    func didUpdateCoin(_ coinManager:CoinManager,coin:CoinModel)
    func didFailWithError(error:Error)
}

struct CoinManager {
    
    let baseURL = "https://rest.coinapi.io/v1/exchangerate/BTC"
    let apiKey = "3C50AF7D-391F-4127-8038-B14FCDA0DC7F"
    
    let currencyArray = ["AUD", "BRL","CAD","CNY","EUR","GBP","HKD","IDR","ILS","INR","JPY","MXN","NOK","NZD","PLN","RON","RUB","SEK","SGD","USD","ZAR"]

    var delegate:CoinManagerDelegate?
    
    func getCoinPrice(for currency:String){
        let urlString = "\(baseURL)/\(currency)?apikey=\(apiKey)"
        performReauest(with: urlString)
    }
    
    func performReauest(with urlString:String){
        if let url = URL(string: urlString){
            let session = URLSession(configuration: .default)
                let task = session.dataTask(with: url){(data,response,error) in
                if error != nil {
                    print("error! error! error! \(error!)")
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                   if let coin = self.parseJSON(safeData){
                        self.delegate?.didUpdateCoin(self,coin: coin)
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ coinData:Data) ->CoinModel? {
        let decoder = JSONDecoder()
        do {
            let decodedData = try decoder.decode(CoinData.self, from: coinData)
            let rateData = decodedData.rate
            let rate = CoinModel(coinRate: rateData)
            print("rate is : \(rate.coinRateString)")
            return rate
        }
        catch {
            print("error here!")
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
