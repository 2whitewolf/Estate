//
//  CurrentLiveView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 27.10.2023.
//

import SwiftUI
import PopupView

struct CurrentLiveView: View {
    
    @EnvironmentObject var vm: RegistrationViewModel
    @State private var isShowingCountryPicker = false
    @State private var isShowingCityPicker = false

    var button_enabled: Binding<Bool> {
        Binding(get: {
            !vm.currentCountryCode.isEmpty && !vm.cityCode.isEmpty && !vm.address.isEmpty
        }) { (newVal) in

        }
    }

    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("[FirstName], where do you currently live?".localized)
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
                        .padding(.vertical,9)
                        .background(Color.blue.opacity(0.1))
                        .cornerRadius(12)
                }
                VStack(spacing: 16){
                    selectCountry
                    
                    selectCity
                    
                    TextField("Enter your address".localized, text: $vm.address)
                        .textFieldStyle(ImageWithLineStroke(title: "Addres".localized,image: Image("address")))
                }
                .padding(.vertical)
                
                Text("If you are an expat living in the UAE, you will be asked to submit a proof of residency (Emirates ID and Passport Visa Page) upon completing your first investment.".localized)
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                
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
                        .background(button_enabled.wrappedValue ? Color.blue : Color.gray)
                        .cornerRadius(12)
                }
                .disabled(!button_enabled.wrappedValue)
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
                        vm.currentCountryCode = countryCode //Locale.current.localizedString(forRegionCode: countryCode) ?? ""
                    }
                }
            })
            .popup(isPresented: $isShowingCityPicker, view: {
                List(vm.cities, id: \.self) { city in
                    HStack {
                        Text(city)
                        Spacer()
                    }
                    .onTapGesture {
                        isShowingCityPicker.toggle()
                        vm.cityCode = city//Locale.current.localizedString(forRegionCode: countryCode) ?? ""
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

#Preview {
    CurrentLiveView()
        .environmentObject(RegistrationViewModel())
}


extension CurrentLiveView {
    private var selectCountry: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("Country".localized)
                .font(.system(size: 13))
            
            if vm.currentCountryCode.isEmpty {
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
                    Text(countryFlag(vm.currentCountryCode))
                    Text(Locale.current.localizedString(forRegionCode: vm.currentCountryCode) ?? "")
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
//        .padding(.vertical)
    }
    
    
    private var selectCity: some View {
        VStack(alignment: .leading, spacing: 4){
            Text("City".localized)
                .font(.system(size: 13))
            
            if vm.cityCode.isEmpty {
                HStack{
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                    
                    Text("Select your city".localized)
                        .foregroundColor(.gray)
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            isShowingCityPicker.toggle()
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            } else {
                HStack{
                    Text(vm.cityCode)
                    Text(Locale.current.localizedString(forRegionCode: vm.cityCode) ?? "")
                    Spacer()
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                        .onTapGesture {
                            isShowingCityPicker.toggle()
                        }
                }
                .padding()
                .background(RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.gray, lineWidth: 0.5))
            }
        }
    }
}
