//
//  HomeStrategy.swift
//  VenturaHRMobile
//
//  Created by Rodrigo Filomeno on 18/11/20.
//  Copyright © 2020 Rodrigo Filomeno. All rights reserved.
//

import Foundation
import UIKit

public class HomeStrategy{
    
    public static func getTabBar(for user:User) -> UITabBarController{
        if (user.type == .PJ){
            let vc1 = UINavigationController(rootViewController: JobOpportunityListViewController(nibName: "JobOpportunityListViewController", bundle: nil))
            let vc2 = UINavigationController(rootViewController: MyJobOpportunityViewController(nibName: "MyJobOpportunityViewController", bundle: nil))
            vc1.title = "Home"
            vc2.title = "New"

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
        } else {
            let vc1 = UINavigationController(rootViewController: JobOpportunityListViewController(nibName: "JobOpportunityListViewController", bundle: nil))
            let vc2 = UINavigationController(rootViewController: MyJobOpportunityViewController(nibName: "MyJobOpportunityViewController", bundle: nil))
            vc1.title = "Home"
            vc2.title = "New"

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
}
