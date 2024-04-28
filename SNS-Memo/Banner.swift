//
//  Banner.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/26.
//

import Foundation
import UIKit
import GoogleMobileAds
import SwiftUI

struct AdMobBannerView: UIViewRepresentable {
    func makeUIView(context: Context) -> GADBannerView {
        let banner = GADBannerView(adSize: GADAdSizeBanner)
        banner.adUnitID = "ca-app-pub-3940256099942544/2435281174"
        banner.rootViewController = UIApplication.shared.windows.first?.rootViewController
        banner.load(GADRequest())
        return banner
    }
    
    func updateUIView(_ uiView: GADBannerView, context: Context) {
        
    }
    
}
