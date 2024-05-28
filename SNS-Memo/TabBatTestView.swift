//
//  TabBatTestView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/05/28.
//

import SwiftUI

struct TabBatTestView: View {
    var body: some View {
        TabView {
            NavigationStack {
                NavigationLink("Sun") {
                    Text("Hello Sun")
                        .toolbar(.hidden, for: .tabBar)
                }
                .navigationTitle(Text("Sun"))
            }
            .tabItem {
                Label("Sun", systemImage: "sun.max")
            }
            NavigationStack {
                NavigationLink("Moon") {
                    Text("Hello Moon")
                }
                .navigationTitle(Text("Moon"))
            }
            .tabItem {
                Label("Moon", systemImage: "moon.stars")
            }
        }
    }
}

#Preview {
    TabBatTestView()
}
