//
//  CupView.swift
//  SafeDriving
//
//  Created by 中川真一 on 2023/09/16.
//

import SwiftUI

var a:Int = 2

struct CupView1: View {
    var body: some View {
        Image("medicine_cup_water")
    }
}
struct CupView2: View {
    var body: some View {
        Image("water_hyoumenchouryoku3")
    }
}

struct CupView_Previews: PreviewProvider {
    static var previews: some View {
        if a==1{
            CupView1()
        }
        if a==2{
            CupView2()
        }
    }
}
