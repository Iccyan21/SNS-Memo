//
//  TabBarView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI

struct TabBarView: View {
    init() {
        UITabBar.appearance().backgroundColor = UIColor.white
        UITabBar.appearance().unselectedItemTintColor = UIColor.gray
        UITabBar.appearance().tintColor = UIColor.systemGreen
    }
    
    var body: some View {
        TabView {
            ContentView()
                .tabItem {
                    VStack {
                        Image(systemName: "house")
                        Text("HomeTab")
                    }
                }
            
            SettingView()
                .tabItem {
                    VStack {
                        Image(systemName: "gearshape.fill")
                        Text("SettingTab")
                    }
                }
        }
        .accentColor(Color.green) // LINE風の緑色
    }
}

#Preview {
    TabBarView()
}

