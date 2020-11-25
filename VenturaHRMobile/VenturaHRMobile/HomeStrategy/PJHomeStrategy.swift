//
//  PJHomeStrategy.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 25/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import UIKit

public class PJHomeStrategy: HomeStrategyProtocol{
    public static func getHomeStrategy(for user: User) -> UITabBarController {
        let vc1 = UINavigationController(rootViewController: JobOpportunityListViewController(nibName: "JobOpportunityListViewController", bundle: nil))
        let vc2 = UINavigationController(rootViewController: CompanyHomeViewController(nibName: "CompanyHomeViewController", bundle: nil))
        vc1.title = "Vagas"
        vc2.title = "Empresa"

        let tabViewController = UITabBarController()
        tabViewController.setViewControllers([vc1, vc2], animated: false)
           
        if let items = tabViewController.tabBar.items {
            let images = ["house", "gear"]
               
            for x in 0..<items.count{
                items[x].image = UIImage(systemName: images[x])
            }
        }
        tabViewController.modalPresentationStyle = .fullScreen
        
        return tabViewController
        
    }
}
