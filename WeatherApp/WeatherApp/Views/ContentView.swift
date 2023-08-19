//
//  ContentView.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 16/08/2023.
//

import SwiftUI

struct ContentView: View {
    
    @State var slash : Bool = true
    @StateObject var locationManager = LocationViewModle()
    @State var weather: ResponseBody?

    var weatherViewModle = WeatherViewModle ()
    var body: some View {
        VStack {
            if slash {
                
                LanchView()
                    .transition(.opacity)
                    .animation(.easeOut(duration: 1.5))
            }else{
                if let location = locationManager.location {
                    
                    if let weather = weather {
                        WeatherView(weather: weather)
                        
                    } else {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle (tint: .gray))
                        
                            .frame (maxWidth: 400, maxHeight:
                                        600)
                            .task {
                                do {
                                    weather = try await weatherViewModle.getCurrentWeather(latitude:location.latitude, longitude:location.longitude)
                                    
                                } catch {
                                    print("Error getting weather:\(error)")
                                    
                                }
                            }
                    }
                }else {
                    if locationManager.isLoading {
                        ProgressView()
                            .progressViewStyle(CircularProgressViewStyle (tint: .gray))
                        
                            .frame (maxWidth: .infinity, maxHeight:
                                    .infinity)
                    }else {
                        WelcomeView()
                            .environmentObject(locationManager)
                        
                    }
                    
                }
            }
            
                
        }
        
        .onAppear{
            
            DispatchQueue.main
                .asyncAfter(deadline: .now() + 3){
                    
                    withAnimation{
                        self.slash = false
                    }
                }
        }
      
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
