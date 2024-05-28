//
//  SettingView.swift
//  SNS-Memo
//
//  Created by 水原　樹 on 2024/03/21.
//

import SwiftUI

struct SettingView: View {
    @Environment(\.openURL) var openURL
    
    var body: some View {
        NavigationStack {
            VStack {
                Spacer()
                
                VStack {
                    List {
                        Section {
                            NavigationLink(destination: Text("広告削除")) {
                                Text("Delete Removal")
                                    .foregroundColor(.primary)
                            }
                        } header: {
                            Text("Delete Removal")
                                .foregroundColor(.green)
                        }
                        
                        Section {
                            Button(action: {
                                let email = "ashitagogo123@gmail.com"
                                let subject = "ご意見・ご要望"
                                let body = "ご意見・ご要望など、お気軽にお寄せください。"
                                let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                let mailtoURL = URL(string: "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)")!
                                openURL(mailtoURL)
                            }, label: {
                                Text("Opinions, Requests")
                                    .foregroundColor(.primary)
                            })
                            
                            HStack {
                                NavigationLink(destination: Text("write a review")) {
                                    Text("write a review")
                                        .foregroundColor(.primary)
                                    
                                    Spacer()
                                }
                            }
                            
                            NavigationLink(destination: TermsView()) {
                                Text("terms of service")
                                    .foregroundColor(.primary)
                            }
                            
                            NavigationLink(
                                destination: PrivacyPolicyView(),
                                label: {
                                    Text("Privacy policy").foregroundColor(.primary)
                                })
                        } header: {
                            Text("Information")
                                .foregroundColor(.green)
                        }
                    }
                    .listStyle(.grouped)
                    .background(Color(UIColor.systemGray6))
                }
                
                AdMobBannerView()
                    .frame(height: 60)
            }
            .navigationTitle("SettingTitle")
            .toolbarBackground(Color.green, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark)
        }
    }
}

#Preview {
    SettingView()
}
