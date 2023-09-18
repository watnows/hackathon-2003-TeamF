//
//  TitlePage.swift
//  SafeDriving
//
//  Created by 澤木柊斗 on 2023/09/16.
//

import SwiftUI

struct TitlePage: View {
    @State private var isAppear: Bool = false
    var body: some View {
        NavigationStack {
            ZStack{
                Text("SplashyDrive")
                    .zIndex(100)
                    .font(.system(size: 50))
                    .fontWeight(.black)
                    .foregroundColor(.white)
                    .shadow(radius: 8)
                    .padding(.bottom, 590)
                    .scaleEffect(isAppear ? 1.0: 0.6)
                Image("start")
                    .resizable()
                    .scaledToFill()
                    .edgesIgnoringSafeArea(.vertical)
                    Image("car")
                        .resizable()
                        .scaledToFit()
                        .scaleEffect(isAppear ? 0.8: 0.2)
                        .padding(.top, isAppear ? 340: 0)
                NavigationLink {
                    ContentView()
                }label: {
                    Text("Tap To Start!!")
                        .foregroundColor(.white)
                        .fontWeight(.black)
                        .font(.system(size: 30))
                        .scaleEffect(isAppear ? 1.2: 0.9)
                        .padding(.top, 600)
                        .animation(Animation.default
                            .repeatForever()
                            .speed(0.3)
                        )

                }
            }
            .onAppear {
                isAppear = true
            }
            .animation(.easeInOut(duration: 1.5), value: isAppear)

        }

    }
}

struct TitlePage_Previews: PreviewProvider {
    static var previews: some View {
        TitlePage()
    }
}
