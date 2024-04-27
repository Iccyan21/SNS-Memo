//
//  SNS_MemoApp.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI
import SwiftData
import GoogleMobileAds

class AppDelegate: NSObject, UIApplicationDelegate {
    func application(
        _ application: UIApplication,
        didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil
    ) -> Bool {
        GADMobileAds.sharedInstance().start(completionHandler: nil)
        return true
    }
}

@main
struct SNS_MemoApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    @StateObject var appOpen = AppOpen()
    var body: some Scene {
        WindowGroup {
            TabBarView()
                .modelContainer(for: [Room.self,Memo.self])
        }
        // アプリ起動時に広告を起動
        .onChange(of: appOpen.appOpenAdLoaded) { newValue in
            appOpen.presentAppOpenAd()
        }
    }
    init() {
        print(URL.applicationSupportDirectory.path(percentEncoded: false))
    }
}
