//
//  Banner.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/26.
//

import GoogleMobileAds
import SwiftUI

struct BannerView: UIViewControllerRepresentable {
    func makeUIViewController(context _: Context) -> UIViewController {
        let viewController = GADBannerViewController()
        return viewController
    }
    
    func updateUIViewController(_: UIViewController, context _: Context) {}
}

class GADBannerViewController: UIViewController, GADBannerViewDelegate {
    var bannerView: GADBannerView!
    let adUnitID = "ca-app-pub-3940256099942544/2934735716"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        loadBanner()
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: nil) { [weak self] _ in
            guard let self else { return }
            self.loadBanner()
        }
    }
    
    private func loadBanner() {
        bannerView = GADBannerView(adSize: GADAdSizeBanner)
        bannerView.adUnitID = adUnitID
        
        bannerView.delegate = self
        bannerView.rootViewController = self
        
        let bannerWidth = view.frame.size.width
        bannerView.adSize = GADCurrentOrientationAnchoredAdaptiveBannerAdSizeWithWidth(bannerWidth)
        
        let request = GADRequest()
        request.scene = view.window?.windowScene
        bannerView.load(request)
        
        setAdView(bannerView)
    }
    
    func setAdView(_ view: GADBannerView) {
        bannerView = view
        self.view.addSubview(bannerView)
        bannerView.translatesAutoresizingMaskIntoConstraints = false
        let viewDictionary = ["_bannerView": bannerView!]
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "H:|[_bannerView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary
            )
        )
        self.view.addConstraints(
            NSLayoutConstraint.constraints(
                withVisualFormat: "V:|[_bannerView]|",
                options: NSLayoutConstraint.FormatOptions(rawValue: 0), metrics: nil, views: viewDictionary
            )
        )
    }
}

