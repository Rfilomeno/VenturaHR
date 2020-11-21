//
//  Sizes.swift
//  AbasteceAi
//
//  Created by Jefferson S Batista on 25/04/18.
//  Copyright © 2018 iTerative. All rights reserved.
//

import UIKit

enum IPhoneModel {
    case iphone5
    case iphone678
    case iphone678plus
    case iphoneXXs
    case iphoneXr
    case iphoneXsMax
    case iPad
}

enum IPhoneHeight: CGFloat {
    case heightIphone5 = 325
    case heightIphone678X = 400
}

enum IPhoneScales: CGFloat {
    case scaleIphone5 = 0.8
    case scaleIphone678X = 1
}

struct DeviceSizes {
    
    // MARK: - IPHONE MODEL
    static let iphoneModel = { () -> IPhoneModel in
        if UIDevice().userInterfaceIdiom == .phone {
            switch UIScreen.main.nativeBounds.height {
            case 1136:
                return IPhoneModel.iphone5
            case 1334:
                return IPhoneModel.iphone678
            case 1920, 2208:
                return IPhoneModel.iphone678plus
            case 2436:
                return IPhoneModel.iphoneXXs
            case 1792:
                return IPhoneModel.iphoneXr
            case 2688:
                return IPhoneModel.iphoneXsMax
            default:
                return IPhoneModel.iPad
            }
        }else {
            return IPhoneModel.iPad
        }
    }()
    
    static func deviceHasTopNotch() -> Bool {
        if #available(iOS 11.0, tvOS 11.0, *) {
            return UIApplication.shared.delegate?.window??.safeAreaInsets.top ?? 0 > 20
        }
        return false
    }
    
    // MARK: - IPHONE HEIGHT
    static let iphoneHeight = { () -> CGFloat in
        switch iphoneModel {
        case IPhoneModel.iphone5:
            return IPhoneHeight.heightIphone5.rawValue
        case IPhoneModel.iphone678:
            return IPhoneHeight.heightIphone678X.rawValue
        case IPhoneModel.iphone678plus:
            return IPhoneHeight.heightIphone678X.rawValue
        case IPhoneModel.iphoneXXs:
            return IPhoneHeight.heightIphone678X.rawValue
        case IPhoneModel.iphoneXr:
            return IPhoneHeight.heightIphone678X.rawValue
        case IPhoneModel.iphoneXsMax:
            return IPhoneHeight.heightIphone678X.rawValue
        default:
            return IPhoneHeight.heightIphone678X.rawValue
        }
    }()
    
    // MARK: - IPHONE SCALE
    static let iphoneScale = { () -> CGFloat in
        switch iphoneModel {
        case IPhoneModel.iphone5:
            return IPhoneScales.scaleIphone5.rawValue
        case IPhoneModel.iphone678:
            return IPhoneScales.scaleIphone678X.rawValue
        case IPhoneModel.iphone678plus:
            return IPhoneScales.scaleIphone678X.rawValue
        case IPhoneModel.iphoneXXs:
            return IPhoneScales.scaleIphone678X.rawValue
        case IPhoneModel.iphoneXr:
            return IPhoneScales.scaleIphone678X.rawValue
        case IPhoneModel.iphoneXsMax:
            return IPhoneScales.scaleIphone678X.rawValue
        default:
            return IPhoneScales.scaleIphone678X.rawValue
        }
    }()
    
    static func isCompatibilityMode() -> Bool{
        if(DeviceSizes.iphoneModel == .iPad && (UIDevice.current.systemVersion as NSString).floatValue < 12.0){
            return true
        }
        return false
    }
}
