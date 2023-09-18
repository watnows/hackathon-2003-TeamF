//
//  Result.swift
//  SafeDriving
//
//  Created by 澤木柊斗 on 2023/09/16.
//

import SwiftUI
enum evaluation {
    case eRank,dRank,cRank,bRank,aRank
    var evalState: String {
        switch self {
        case .eRank: return "あなたは運転においてまだ経験が浅いかもしれません。安全な運転のためには、速度制限を厳守し、車間距離を保つことが大切です。運転に関する質問をインストラクターや経験豊富なドライバーに積極的に聞いて学びましょう。\nアドバイス：新しい道路や交通ルールに慣れるために練習が必要です。安全運転を心がけましょう。他のドライバーの行動に注意を払い、安全な運転に焦点を当てましょう。"
        case .dRank:
            return "自分の運転技術に自信を持ちすぎています。スピード超過や危険な行動を避け、他のドライバーとの共有道路を尊重しましょう。自己評価が高いことは素晴らしいです。他のドライバーが予測できない行動をすることもあるため、注意を怠らないようにしましょう。 \nアドバイス：他のドライバーとの共有道路を尊重し、運転において過信せずに注意を払いましょう"
        case .cRank:
            return "運転が楽しいと感じます。新しい道路や車の機能に興味を持ち、運転を楽しむことができます。ただし、安全に優先度を置いて運転しましょう。周囲の交通状況を確認しながら楽しむことが大切です。運転好きならではの運転の楽しみを味わいつつ、ルールを守りましょう。 \nアドバイス：新しい道路や交通ルールに慣れるため、遠出してもしてみても良いですね。"
        case .bRank:
            return "安全が最優先です。速度制限や信号を守り、他のドライバーとの協力を大切にし、事故を防ぐために努力してしましょう。あなたは、他のドライバーの行動を予測し、予防的な運転を心がけています。運転前には車の点検を行い、正確な運転姿勢を保ちドライブを楽しみましょう。\nアドバイス：運転前には車の点検を欠かさずに行い、適切なメンテナンスを行いましょう。"
        case .aRank:
            return "あなたは運転のテクニックに精通しています。高度な運転スキルを持ち、安全かつスムーズに車を操作できます。しかし、テクニックに溺れず、常に安全運転の原則を守りましょう。他のドライバーとの協力や交通ルールの遵守が、高度なテクニックと調和することで、より安全な運転環境を築くことができます。\nアドバイス：他のドライバーとの共有道路での配慮を忘れずに。他の人々にも安全な運転の魅力を伝える一翼を担いましょう"
        }
    }
    var evalname: String {
        switch self {
        case .eRank: return "🔥【初心者】"
        case .dRank:
            return "【過信派】"
        case .cRank:
            return "🚗【運転好き】"
        case .bRank:
            return "【安全第一】"
        case .aRank:
            return "👑【運転テクニシャン】"
        }
    }
}
struct Result: View {

    @State var excount: Double
    @State var midexcount: Double = 11.0
    @State var count: Double = 0.0
    @State var delete: Bool = false
    @Environment(\.presentationMode) var presentation
    var evaluater: evaluation {
        if (100-(30*midexcount + 100*excount)/(count)) >= 90 {
            return .aRank
        } else if (100-(30*midexcount + 100*excount)/(count)) >= 70 {
            return .bRank
        } else if (100-(30*midexcount + 100*excount)/(count)) >= 50 {
            return .cRank
        } else if (100-(30*midexcount + 100*excount)/(count)) >= 20 {
            return .dRank
        } else {
            return .eRank
        }
    }
    
    var body: some View {
        ZStack{
            if delete == false {
                ZStack(alignment: .topLeading){
                    ModalWindowView(evaluation: evaluater.evalname,evastate: evaluater.evalState)
                    Button{
                        self.delete = true
                        print(delete)
                    } label: {
                        Image(systemName: "xmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 46)
                            .foregroundColor(.black)
                            .zIndex(2)
                    }
                }
                    .padding(.horizontal, 30)
                    .zIndex(100)
            }
            Image("title")
                .resizable()
                .scaledToFill()
                .edgesIgnoringSafeArea(.all)

            VStack{
                VStack{
                    Text("-0.4G以上")
                    Text(String(format: "%.2f", excount) + "秒")
                        .animation(.easeIn)
                }
                .font(.system(size: 25,weight: .black))
                .foregroundColor(.red)
                .padding(.bottom,10)
                VStack{
                    Text("−0.3G以上-0.4G以下")
                    Text(String(format: "%.2f", midexcount ) + "秒")
                        .animation(.easeIn)
                }
                .font(.system(size: 20,weight: .black))
                .padding(.bottom,20)
                Text("合計スコアは...")
                    .font(.system(size: 25,weight: .black))

                Text(String(format:"%.2f",(100-(30*midexcount  + 100*excount)/(count))))
                    .font(.system(size: 40,weight: .black))

                Button{
                    presentation.wrappedValue.dismiss()} label: {
                        Text("測定画面に戻る")
                            .fontWeight(.black)
                    }
            }
        }
        .animation(.easeIn(duration: 0.15), value: delete)
    }
}

struct Result_Previews: PreviewProvider {
    static var previews: some View {
        Result(excount: 0.0, delete: false)
    }
}
