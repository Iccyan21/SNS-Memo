//
//  TermsView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/04/16.
//

import SwiftUI

struct TermsView: View {
    var body: some View {
        ScrollView {
            LazyVStack{
                Text("Terms of service Text")
                
            }
            .padding()
        }
        .navigationTitle("Terms of service Title")
    }
}

#Preview {
    TermsView()
}
