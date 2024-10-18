//
//  HourlyWeatherView.swift
//  Meteo
//
//  Created by Theo Blanchard on 9/28/24.
//

import SwiftUI

struct HourlyWeatherView: View {
    @ObservedObject var cityVM: CityViewViewModel
    
    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 20) {
                ForEach(cityVM.weather.hourly) { weather in
                    let icon = cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon : "sun.max.fill")
                    let hour = cityVM.getTimeFor(timestamp: weather.dt)
                    let temp = cityVM.getTempFor(temp: weather.temp)
                    getHourlyView(hour: hour, image: icon, temp: temp)
                }
            }
        }
    }
    
    private func getHourlyView(hour: String, image: Image, temp: String) -> some View {
        VStack(spacing: 20) {
            Text(hour)
            image
                .foregroundColor(.yellow)
            Text(temp)
        }
        .foregroundColor(.white)
        .padding()
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient(gradient: Gradient(colors: [Color(#colorLiteral(red: 0.4981541634, green: 0.889557302, blue: 1, alpha: 1)), Color(#colorLiteral(red: 0.1902901232, green: 0.4442581236, blue: 0.599514246, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomLeading)))
        .shadow(color: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y: 2)
    }
}

struct HourlyWeatherView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
