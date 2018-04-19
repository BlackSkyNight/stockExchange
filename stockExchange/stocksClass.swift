//
//  stocksClass.swift
//  stockExchange
//
//  Created by Mateusz Matejczyk on 09.11.2017.
//  Copyright © 2017 Mateusz Matejczyk. All rights reserved.
//

import Foundation

struct stocksStruct
{
    var name = String()
    var price = Double()
    var volume = Int()
    var change = Double()
    var value = Int()
    var last24Price = [Double]()
    
    init()
    {
        
    }
    
    init(stockName: String, stockPrice: Double, stockVolume: Int, stockChange: Double, stockValue: Int)
    {
        self.name = stockName
        self.volume = stockValue
        self.value = stockValue
        
        randomData24Price(stockPrice: stockPrice)
        
        self.change = ((((last24Price[23] - last24Price[22]) / last24Price[23] * 100) * 100).rounded()) / 100
        self.price = last24Price[23]
    }
    
    mutating func randomData24Price(stockPrice: Double)
    {
        for _ in 0 ..< 24
        {
            let randomPrice = Double(arc4random_uniform(UInt32(stockPrice + (stockPrice / 2).rounded()) + UInt32((stockPrice / 3 * 4).rounded()))) + ((drand48() * 100).rounded()) / 100
            last24Price.append(randomPrice)
        }
    }
    
    func showLast24Price()
    {
        for price in last24Price
        {
            print(price)
        }
        print("last hour change: \(self.change)%")
    }
}
