//
//  WelcomeView.swift
//  WeatherApp
//
//  Created by Diya Alowdah on 16/08/2023.
//
//Please share your current location to get the weather in your area
import SwiftUI
import CoreLocationUI

struct WelcomeView: View {
    @EnvironmentObject var locationManager:LocationViewModle
    var body: some View {
        ZStack {
            Color.gray.opacity(0.1)
                .ignoresSafeArea()
            VStack(spacing: -40) {
               Image("1")
                    .resizable()
                    .frame(width: 350,height: 300)
                Spacer(minLength: 150)
                    Text ("Access Location")
                    .font(.system(size:30).bold())
                        .padding ()
                        .multilineTextAlignment (.center)
                        .padding ()
                
                Text ("We need your location to get the weather")
                    .font(.system(size:30))
                    .multilineTextAlignment (.center)
                    .padding()
    //
                LocationButton (.shareMyCurrentLocation) {
                        locationManager.requestLocation ()
                            
                    }

                    .buttonStyle(PlainButtonStyle())
                    .background(Color.black)

                    .foregroundColor (.white)
                    .cornerRadius (10)


                    .frame(maxWidth:.infinity, maxHeight: .infinity)
                    
            }
        }

    }
}
struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}
