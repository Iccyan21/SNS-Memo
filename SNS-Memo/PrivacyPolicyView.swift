//
//  PrivacyPolicyView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/17.
//

import SwiftUI

struct PrivacyPolicyView: View {
    var body: some View {
        ScrollView {
            LazyVStack{
                Text("PrivacyPolicy Text")
                    .padding()
            }
        }
        .navigationTitle("PrivacyPolicy Title")
    }
}

#Preview {
    PrivacyPolicyView()
}
