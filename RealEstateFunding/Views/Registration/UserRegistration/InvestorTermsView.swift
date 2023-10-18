//
//  InvestorTermsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 02.10.2023.
//

import SwiftUI

struct InvestorTermsView: View {
    @EnvironmentObject var vm: RegistrationViewModel
    @State var agree: Bool = false
    var text: String = """
    16.1 This Agreement and any non-contractual obligations arising out of or in connection with the Site shall be governed by and interpreted in accordance with the laws of England and Wales.
   
   
   16.2 Any dispute, controversy or claim arising out of or in connection with this Agreement, or the breach, termination or invalidity thereof, shall be settled by the ADGM courts and you agree to submit to the exclusive jurisdiction of the ADGM courts.   
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
                            Text("Investor Terms and Conditions")
                                .font(.system(size: 28).weight(.bold))
                                .foregroundColor(.black)
                            Spacer()
                        }
                        
                        Text(text)
                            .foregroundColor(.black)
                        //                }
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
                            Text("Agree to Investor T&Cs")
                                .font(.system(size: 15))
                            Spacer()
                        }
                        Spacer()
                        Button {
                            withAnimation {
                                vm.registrationCompleted.toggle()
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
    InvestorTermsView()
        .environmentObject(RegistrationViewModel())
}
