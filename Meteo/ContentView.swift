//
//  ContentView.swift
//  Meteo
//
//  Created by Theo Blanchard on 9/13/24.
//


import SwiftUI

struct ContentView: View {
    @ObservedObject var cityVM = CityViewViewModel()

    var body: some View {
        ZStack(alignment: .bottom) {
            VStack(spacing: 0) {
                MenuHeaderView(cityVM: cityVM)
                ScrollView(showsIndicators: false) {
                    CityView(cityVM: cityVM)
                }
            }
            .padding(.top, 30)
        }
        .background(
            LinearGradient(gradient: Gradient(colors: [
                Color(#colorLiteral(red: 0.5388317108, green: 0.7777397037, blue: 1, alpha: 1)),
                Color(#colorLiteral(red: 0.2366411984, green: 0.6955710053, blue: 1, alpha: 1))
            ]), startPoint: .topLeading, endPoint: .bottomLeading)
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
