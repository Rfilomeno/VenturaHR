//
//  HomeStrategy.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import UIKit

public protocol HomeStrategyProtocol {
    static func getHomeStrategy(for user: User) -> UITabBarController
}

public class HomeStrategy: HomeStrategyProtocol{
    
    public static func getHomeStrategy(for user: User) -> UITabBarController{
        if user.type == .PJ {
            return PJHomeStrategy.getHomeStrategy(for: user)
        } else{
            return PFHomeStrategy.getHomeStrategy(for: user)
        }
    }
}
