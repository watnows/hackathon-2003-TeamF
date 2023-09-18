//
//  ModalWindowView.swift
//  safedrive
//
//  Created by 澤木柊斗 on 2023/09/17.
//

import SwiftUI

struct ModalWindowView: View {
    @State var evaluation: String = "【初心者】"
    @State var evastate: String = "あなたは運転においてまだ経験が浅いかもしれません。安全な運転のためには、速度制限を厳守し、車間距離を保つことが大切です。運転に関する質問をインストラクターや経験豊富なドライバーに積極的に聞いて学びましょう。\nアドバイス：新しい道路や交通ルールに慣れるために練習が必要です。安全運転を心がけましょう。他のドライバーの行動に注意を払い、安全な運転に焦点を当てましょう。"
    var body: some View {
            VStack{
                Text(evaluation)
                    .fontWeight(.black)
                    .padding(.vertical, 22)
                    .frame(maxWidth: .infinity)
                    .font(.system(size: 30))
                    .background(Color.cyan)
                Text(evastate)
                    .padding(EdgeInsets(top: 20, leading: 10, bottom: 30, trailing: 10))
            }
            .background(Color.white)
            .cornerRadius(20)
            .shadow(radius: 25)
        }
    }

struct ModalWindowView_Previews: PreviewProvider {
    static var previews: some View {
        ModalWindowView()
    }
}
