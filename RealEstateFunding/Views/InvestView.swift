//
//  InvestView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 23.10.2023.
//

import SwiftUI
import SDWebImageSwiftUI



var isPreview: Bool {
    return ProcessInfo.processInfo.environment["XCODE_RUNNING_FOR_PREVIEWS"] == "1"
}


struct InvestView: View {
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var vm: PropertiesViewModel
    @State var invest: Int = 500
    @FocusState private var isTextFieldFocused: Bool
    
    
    let formatter: NumberFormatter = {
          let formatter = NumberFormatter()
          formatter.numberStyle = .decimal
          return formatter
      }()
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            VStack{
                
                if let property = vm.propertyDetail {
                    
                    if let image = property.images?.first?.path {
                        ZStack{
                            
                            TextField("", value: $invest, formatter: formatter)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocused)
                                .foregroundColor(.white)
                                .font(.system(size: 28).weight(.bold))
                                .frame(width: 100)
                                .opacity(0)
                                
                            WebImage(url: URL(string: "https://afehe-hwf.buzz/storage" + "/" + image)).placeholder(
                                Image("propertyBackImage")
                                
                            )
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .background(Color.gray)
                            .cornerRadius(52)
                            .padding(.top,8)
                            
                            Text("AED ")
                                .font(.system(size: 15).weight(.semibold))
                                .foregroundColor(.white)
                            + Text("\(invest)")
                                .foregroundColor(.white)
                                .font(.system(size: 28).weight(.bold))
                        }
                        .onAppear{
                            isTextFieldFocused = true
                        }
                        
                        
                    }
                    VStack{
                        
                        Text("\(property.bed ?? 0) Bed in " + (property.location ?? ""))
                            .foregroundColor(.black)
                            .font(.system(size: 20).weight(.semibold))
                        HStack{
                            HStack{
                                Image("graphic_icon")
                                VStack(alignment: .leading){
                                    Text("Annualised return")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    Text((property.annualProfit ?? "") + "%")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 17).weight(.semibold))
                                }
                            }
                            Spacer()
                            HStack{
                                Image("calendar_withBack")
                                VStack(alignment: .leading){
                                    Text("Investment Periiod")
                                        .font(.system(size: 13))
                                        .foregroundColor(.black)
                                    Text((property.period ?? "") + " Year")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 17).weight(.semibold))
                                }
                            }
                        }
                        
                        HStack{
                            ZStack(alignment: .leading){
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.lightGray)
                                RoundedRectangle(cornerRadius: 4)
                                    .fill(Color.blue)
                                    .frame(width: 50)
                            }
                            .frame(height: 4)
                            Text("\(property.completed ?? 0) %")
                                .font(.system(size: 12).weight(.medium))
                                .foregroundColor(.black)
                        }
                    }
                   
                    .modifier(CornerBackground())
                    .frame(height: 150)
                    
                }
                Spacer()
                Button{
                    vm.createInvoice(userId: appVM.user?.id ?? 14, amount: Double(invest))
                } label: {
                    Text("Invest")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .backgroundColor(.blue)
                        .cornerRadius(12)
                    
                }
            }
            .padding(.horizontal,8)
            .onAppear{
                if isPreview {
                    vm.propertyDetail = samplePropertyDetail.data?.property
                }
        }
        }
    }
}

#Preview {
    InvestView()
        .environmentObject(PropertiesViewModel())
}
