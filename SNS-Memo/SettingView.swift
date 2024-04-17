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
        
        VStack{
            ZStack{
                Color.orange.edgesIgnoringSafeArea(.all)
                
            }.frame(height: 50)
            
            Spacer()
            
            VStack{
                List{
                    Section{
                        NavigationLink(destination: Text("広告削除")) {
                            Text("広告削除")
                                .foregroundColor(.black)
                        }
                    } header: {
                        Text("広告削除")
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
                            Text("ご意見・ご要望など")
                                .foregroundColor(.black)
                        })
                        HStack{
                            NavigationLink(destination: Text("レビューを書く")) {
                                Text("レビューを書く")
                                    .foregroundColor(.black)
                                
                                Spacer()
                                
                                
                            }
                        }
                        
                        NavigationLink(destination: TermsView()) {
                            Text("利用規約")
                                .foregroundColor(.black)
                            
                        }
                        NavigationLink(
                            destination: PrivacyPolicyView(),
                            label: {
                                Text("プライバシーポリシー").foregroundColor(.black)
                            })
                    } header: {
                        Text("アプリ情報")
                    }
                } //List
                .listStyle(.grouped)
            }
        }.navigationTitle("設定")
    }
}

#Preview {
    SettingView()
}
