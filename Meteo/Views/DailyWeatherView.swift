//
//  DailyWeatherView.swift
//  Meteo
//
//  Created by Georgina Jezabel Castillo Morales on 9/28/24.
//

import SwiftUI

struct DailyWeatherView: View {
    
    @ObservedObject var cityVM: CityViewViewModel
        
    var body: some View {
        ForEach(cityVM.weather.daily) { weather in
            LazyVStack{
                dailyCell(weather: weather )
                
            }
            
        }
    }
    
    private func dailyCell(weather: DailyWeather) -> some View {
        HStack{
            Text(cityVM.getDayFor(timestamp: weather.dt).uppercased())
                .frame(width: 50)
            
            Spacer()
            
            Text("\(cityVM.getTempFor(temp: weather.temp.max)) | \(cityVM.geTempFor(temp: weather.temp.min)) ºF")
                .frame(width: 150)
            
            Spacer()
            cityVM.getWeatherIconFor(icon: weather.weather.count > 0 ? weather.weather[0].icon: "sun.max.fill ")
        }
        .foregroundColor(.white)
        .padding(.horizontal)
        .paddig(.vertical,15)
        .background(RoundedRectangle(cornerRadius: 5).fill(LinearGradient( gradient: <#T##Gradient#>(colors: [Color(#colorLiteral(red: 0.4257491827, green: 0.821092546, blue: 1, alpha: 1) ), Color(#colorLiteral(red: 0.2961008549, green: 0.5802834034, blue: 0.724591732, alpha: 1))]), startPoint: .topLeading, endPoint: .bottomTrailing)))
        .shadow(radius: Color.white.opacity(0.1), radius: 2, x: -2, y: -2)
        .shadow(color: Color.black.opacity(0.2), radius: 2, x: 2, y:2)
    }
}

struct DailyWeatherView_PreviewProvider {
    static var previews: some View {
        ContentView(
        )
    }
}
