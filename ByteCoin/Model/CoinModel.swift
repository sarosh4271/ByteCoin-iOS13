//
//  CoinModel.swift
//  ByteCoin
//
//  Created by Sarosh Tahir on 10/11/2021.
//  Copyright © 2021 The App Brewery. All rights reserved.
//

import Foundation

struct CoinModel{
  
    let coinRate:Double
    
    var coinRateString:String{
        return String(format: "%.1f", coinRate)
    }
}
