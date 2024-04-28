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
        NavigationStack{
            VStack{
                
                Spacer()
                
                VStack{
                    List{
                        Section{
                            NavigationLink(destination: Text("広告削除")) {
                                Text("Delete Removal")
                                    .foregroundColor(.black)
                            }
                        } header: {
                            Text("Delete Removal")
                        }
                        
                        
                        Section{
                            Button(action: {
                                // ここにメーラーを起動するコードを書く
                                let email = "ashitagogo123@gmail.com" // 送信先のメールアドレス
                                let subject = "ご意見・ご要望" // メールの件名
                                let body = "ご意見・ご要望など、お気軽にお寄せください。" // メールの本文
                                let encodedSubject = subject.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                let encodedBody = body.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) ?? ""
                                let mailtoURL = URL(string: "mailto:\(email)?subject=\(encodedSubject)&body=\(encodedBody)")!
                                openURL(mailtoURL)
                            }, label: {
                                Text("Opinions, Requests")
                                    .foregroundColor(.black)
                            })
                            HStack{
                                NavigationLink(destination: Text("write a review")) {
                                    Text("write a review")
                                        .foregroundColor(.black)
                                    
                                    Spacer()
                                    
                                    
                                }
                            }
                            
                            NavigationLink(destination: TermsView()) {
                                Text("terms of service")
                                    .foregroundColor(.black)
                                
                            }
                            NavigationLink(
                                destination: PrivacyPolicyView(),
                                label: {
                                    Text("Privacy policy").foregroundColor(.black)
                                })
                        } header: {
                            Text("Information")
                        }
                    } //List
                    .listStyle(.grouped)
                }
                AdMobBannerView()
                    .frame(height: 60)
            }
            .navigationTitle("SettingTitle")
            .toolbarBackground(Color.orange, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .toolbarTitleDisplayMode(.inlineLarge)
            // これで白色
            .toolbarColorScheme(.dark)
        }
    }
}

#Preview {
    SettingView()
}
