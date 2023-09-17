//
// Result.swift
// SafeDriving
//
// Created by 澤木柊斗 on 2023/09/16.
//
import SwiftUI
struct Result: View {
  @State var excount: Double
  @State var midexcount: Double = 11.0
  @Environment(\.presentationMode) var presentation
  var body: some View {
    ZStack{
      Image("tittle")
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
        Text(String(format:"%.2f",0.3*midexcount + 2*excount))
          .font(.system(size: 40,weight: .black))
        Button{
          presentation.wrappedValue.dismiss()} label: {
          Text("測定画面に戻る")
            .fontWeight(.black)
        }
      }
    }
  }
}
struct Result_Previews: PreviewProvider {
  static var previews: some View {
    Result(excount: 0.0)
  }
}
