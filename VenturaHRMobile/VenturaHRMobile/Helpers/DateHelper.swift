//
//  DateHelper.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 17/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation

public class DateHelper{
    
    
    static func getCurrentDate() -> String{
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    static func getExpirationDate() -> String{
        let date = Date()
        let expirationDate = Calendar.current.date(byAdding: .day, value: 15, to: date)
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: expirationDate ?? date)
        
    }
}
