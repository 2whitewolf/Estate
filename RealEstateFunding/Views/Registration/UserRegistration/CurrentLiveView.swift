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
    @State private var countryCode: String = ""
    @State private var isShowingCityPicker = false
    @State private var cityCode: String = ""
    @State var address: String = ""
    
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack{
                HStack{
                    Text("[FirstName], where do you currently live?")
                        .foregroundColor(.black)
                        .font(.system(size: 28).weight(.bold))
                    
                    Spacer()
                }
                HStack{
                    Text("Before we begin, we'd like to get to know you better.")
                    Spacer()
                }
                Button {
                    
                } label: {
                    Label("Why we ask", systemImage: "info.circle")
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
                    
                    TextField("Enter your address", text: $address)
                        .textFieldStyle(ImageWithLineStroke(title: "Addres",image: Image("address")))
                }
                .padding(.vertical)
                
                Text("If you are an expat living in the UAE, you will be asked to submit a proof of residency (Emirates ID and Passport Visa Page) upon completing your first investment.")
                    .foregroundColor(.gray)
                    .font(.system(size: 13))
                
                Spacer()
                
                Button {
                    withAnimation{
                        vm.currentState =  vm.currentState.next()
                    }
                  
                } label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
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
                        self.countryCode = countryCode //Locale.current.localizedString(forRegionCode: countryCode) ?? ""
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
        VStack(alignment: .leading, spacing: 8){
            Text("Country")
            
            if countryCode.isEmpty {
                HStack{
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                    
                    Text("Select your country")
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
                    Text(countryFlag(countryCode))
                    Text(Locale.current.localizedString(forRegionCode: countryCode) ?? "")
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
        VStack(alignment: .leading, spacing: 8){
            Text("City")
            
            if cityCode.isEmpty {
                HStack{
                    Image(systemName: "globe")
                        .foregroundColor(.blue)
                    
                    Text("Select your city")
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
                    Text(countryFlag(cityCode))
                    Text(Locale.current.localizedString(forRegionCode: cityCode) ?? "")
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
//        .padding(.vertical)
    }
}
