//
//  TabBarView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI

struct TabBarView: View {
    var body: some View {
        TabView{
            ContentView()
                .tabItem {
                    Image(systemName: "house")
                    Text("HomeTab")
                }
        
            SettingView()
                .tabItem {
                    Image(systemName: "gearshape.fill")
                    Text("SettingTab")
                }
            
        }
    }
}

#Preview {
    TabBarView()
}
