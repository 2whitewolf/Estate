//
//  Onboarding.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject var appVM: AppViewModel
     @State var index = 0
    var onboardings :[OnBoarding] = onboarding
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack{
                Image( onboardings[index].image)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.top)

                VStack{
                    Text( onboardings[index].title)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 34).weight(.bold))
                        .frame(height: 82)

                    Text( onboardings[index].message)
                        .multilineTextAlignment(.center)
                        .font(.system(size: 16))
                        .frame(height: 84)
                       
                    Button{
                        withAnimation {
                            if index == 1 {
                                appVM.currentState = .appStart
                            } else {
                                index = 1
                            }
//                            index = index == 0 ? 1 : 0
                        }
                    } label: {
                        Text("Continue")
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .frame(maxWidth: .infinity)
                            .frame(height:62)
                            .background(Color.blue)
                            .cornerRadius(12)
                    }
                    
                    HStack{
                        RoundedRectangle(cornerRadius: 12)
                            .fill(index == 0 ? Color.blue : Color.gray)
                            .frame(width:24, height: 3)
                        RoundedRectangle(cornerRadius: 12)
                            .fill(index == 1 ? Color.blue : Color.gray)
                            .frame(width:24, height: 3)
                    }
                }
//                .padding(.horizontal, 20)
                .padding(.bottom, 30)
            }
            .padding(.horizontal,24)
            
           
        }
    }
}

struct Onboarding_Previews: PreviewProvider {
    static var previews: some View {
       
            OnboardingView()
                .previewDevice(PreviewDevice(rawValue: "iPhone 14"))
                .previewDisplayName("iPhone 14")
            
            OnboardingView()
                .previewDevice(PreviewDevice(rawValue: "iPhone SE"))
                .previewDisplayName("iPhone SE")

    }
}


struct OnBoarding {
    var title: String
    var image: String
    var message: String
}


var onboarding: [OnBoarding] = [
    OnBoarding(title: "Safe & Secure",image:"onboardingImage1" ,message: "[AppName] is the first regulated real estate investment platform (REIP) in the Middle East. We are regulated by the Dubai Financial Services Authority (DFSA)"),
    OnBoarding(title: "Digital Property Investing",image:"onboardingImage2" ,message: "We handle the entire sales process, screen tenants and manage the property, saving you time and money!")
]
