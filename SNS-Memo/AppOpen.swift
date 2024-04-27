//
//  AppOpen.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/26.
//

import GoogleMobileAds

class AppOpen: NSObject, GADFullScreenContentDelegate, ObservableObject {
    
    @Published var appOpenAdLoaded: Bool = false
    var appOpenAd: GADAppOpenAd?
    
    override init() {
        super.init()
        loadAppOpenAd()
    }
    
    func loadAppOpenAd() {
        let request = GADRequest()
        GADAppOpenAd.load(
            withAdUnitID: "ca-app-pub-3940256099942544/2934735716",
            request: request
        ) { appOpenAdIn, _ in
            self.appOpenAd = appOpenAdIn
            self.appOpenAd?.fullScreenContentDelegate = self
            self.appOpenAdLoaded = true
            print("🍊: 準備完了しました")
        }
    }

    
    func presentAppOpenAd() {
        guard let root = self.appOpenAd else { return }
        // UIWindowSceneを通じてrootViewControllerを取得する新しい方法
        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
              let rootViewController = windowScene.windows.first?.rootViewController else {
            print("ルートビューコントローラーが見つかりません。")
            return
        }
        root.present(fromRootViewController: rootViewController)
    }

    
    func ad(_ ad: GADFullScreenPresentingAd, didFailToPresentFullScreenContentWithError error: Error) {
        self.loadAppOpenAd()
        print("😭: エラー -> \(error)")
    }
    
    func adDidDismissFullScreenContent(_ ad: GADFullScreenPresentingAd) {
        self.loadAppOpenAd()
        print("🍅: 閉じました")
    }
}
