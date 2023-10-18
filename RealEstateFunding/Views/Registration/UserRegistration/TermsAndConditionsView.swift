//
//  TermsAndConditionsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 02.10.2023.
//

import SwiftUI

struct TermsAndConditionsView: View {
    @EnvironmentObject var vm: RegistrationViewModel
    @State var agree: Bool = false
    var text: String = """
    • I have reviewed and understood the key risks and disclosures
    
    • I declare that I am acting on my own behalf.

    • I declare to the best of my belief and knowledge that all information provided to [AppName] is true and complete.

    • I understand that the statements made in this application will form the basis upon which I will become a client of [AppName] and that any material change may affect this.

    • I confirm at the time of this registration I'm not a citizen or resident of United States for tax purposes, if I'm, I'll not be investing more than $50,000.

    • I undertake to advise [AppName] in writing in the event of any material change to my circumstances from the date of this application until I cease to be client of [AppName].

    Further, I consent to [AppName] using all the information provided during this registration process for internal and external verification of my application.
    """
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Button{
                        
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
//                            .padding()
                            .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                            .frame(width:44, height:44)
                    }
                     Spacer()
                    Button{
                        
                    } label: {
                        Image(systemName: "rectangle.portrait.and.arrow.right")
                            .foregroundColor(.red)
                            .background(Circle().stroke(Color.gray, lineWidth: 0.5).frame(width:44, height:44))
                            .frame(width:44, height:44)
                    }
                }
                HStack{
                    Text("Terms and Conditions")
                        .font(.system(size: 28).weight(.bold))
                        .foregroundColor(.black)
                    Spacer()
                }
                ScrollView(showsIndicators: false){
                    Text(text)
                        .foregroundColor(.black)
                }
                 Text("Please review the key risks and disclosures")
                    .foregroundColor(.black)
               
                
                HStack{
                    ZStack{
                        Color.white
                            .frame(width:20,height:20)
                         RoundedRectangle(cornerRadius: 2)
                            .stroke(Color.blue,lineWidth: 1)
                            .frame(width:20,height:20)
                            
                        Image(systemName: "checkmark")
                            .foregroundColor(.blue)
                            .opacity(agree ? 1 : 0)
                    }
                    .onTapGesture {
                        withAnimation {
                            agree.toggle()
                        }
                    }
                    Text("Agree to declaration and T&Cs")
                        .font(.system(size: 15))
                     Spacer()
                }
                Button {
                    withAnimation{
                        vm.currentState = .investorTerms
                    }
                } label: {
                    Text("Accept")
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue)
                        .cornerRadius(14)
                }
                .padding(.bottom,48)
            }
            .padding(.horizontal,24)
        }
    }
}

#Preview {
    TermsAndConditionsView()
        .environmentObject(RegistrationViewModel())
}
