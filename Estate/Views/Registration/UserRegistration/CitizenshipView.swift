//
//  SelectCountryView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.09.2023.
//

import SwiftUI
//import CountryPicker
import PopupView

struct CitizenshipView: View {
    @EnvironmentObject var vm: RegistrationViewModel
    @State private var isShowingCountryPicker = false
  

    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("[FirstName], where you from?".localized)
                        .foregroundColor(.black)
                        .font(.system(size: 28).weight(.bold))
                    
                    Spacer()
                }
                HStack{
                    Text("Before we begin, we'd like to get to know you better.".localized)
                    Spacer()
                }
                Button {
                    
                } label: {
                    Label("Why we ask".localized, systemImage: "info.circle")
                        .foregroundColor(.black)
                        .font(.system(size: 13).weight(.semibold))
                        .frame(maxWidth: .infinity)
                        .frame(height: 50)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                }
                
                VStack(alignment: .leading, spacing: 8){
                    Text("Citizenship".localized)
                    
                    if vm.countryCode.isEmpty {
                        HStack{
                            Image(systemName: "globe")
                                .foregroundColor(.blue)
                            
                            Text("Select your country".localized)
                                .foregroundColor(.gray)
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    isShowingCountryPicker.toggle()
                                }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 0.5))
                    } else {
                        HStack{
                            Text(countryFlag(vm.countryCode))
                            Text(Locale.current.localizedString(forRegionCode: vm.countryCode) ?? "")
                            Spacer()
                            Image(systemName: "chevron.down")
                                .foregroundColor(.gray)
                                .onTapGesture {
                                    isShowingCountryPicker.toggle()
                                }
                        }
                        .padding()
                        .background(RoundedRectangle(cornerRadius: 12)
                            .stroke(Color.gray, lineWidth: 0.5))
                    }
                    
                    
                }
                .padding(.vertical)
                Spacer()
                
                Button {
                    withAnimation{
                        vm.currentState =  vm.currentState.next()
                    }
                  
                } label: {
                    Text("Next".localized)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(vm.countryCode.isEmpty ? Color.gray :  Color.blue)
                        .cornerRadius(12)
                }
                .disabled(vm.countryCode.isEmpty)
                .padding(.bottom, 20)
            }
            .padding(.horizontal,24)
            .popup(isPresented: $isShowingCountryPicker, view: {
                List(NSLocale.isoCountryCodes, id: \.self) { countryCode in
                    HStack {
                        Text(countryFlag(countryCode))
                        Text(Locale.current.localizedString(forRegionCode: countryCode) ?? "")
                        Spacer()
                        Text(countryCode)
                    }
                    .onTapGesture {
                        isShowingCountryPicker.toggle()
                        vm.countryCode = countryCode //Locale.current.localizedString(forRegionCode: countryCode) ?? ""
                    }
                }
            })
        }
    
    }
    
    func countryFlag(_ countryCode: String) -> String {
      String(String.UnicodeScalarView(countryCode.unicodeScalars.compactMap {
        UnicodeScalar(127397 + $0.value)
      }))
    }
}

struct SelectCountryView_Previews: PreviewProvider {
    static var previews: some View {
        CitizenshipView()
            .environmentObject(RegistrationViewModel())
    }
}
