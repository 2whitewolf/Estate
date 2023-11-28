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
    @Environment(\.presentationMode) var presentation
    @EnvironmentObject var appVM: AppViewModel
    @EnvironmentObject var vm: PropertiesViewModel
    @State var invest: Int = 500
    @FocusState private var isTextFieldFocused: Bool
    var isSmall: Binding<Bool> {
        Binding(get: {
            UIScreen.screenHeight < 700
        }) { (newVal) in
            
        }
    }
    
    let formatter: NumberFormatter = {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        return formatter
    }()
    var body: some View {
        ZStack {
            
            Color.white.ignoresSafeArea()
            VStack{
             
                    ScrollView(showsIndicators: false) {
                        ScrollViewReader { scrollReader in
                        ZStack(alignment: .top) {
                            TextField("", value: $invest, formatter: formatter)
                                .keyboardType(.numberPad)
                                .focused($isTextFieldFocused)
                                .foregroundColor(.white)
                                .font(.system(size: 28).weight(.bold))
                                .frame(width: 100)
                                .opacity(0)
                            
                            if let property = vm.propertyDetail {
                                if let image = property.images?.first?.path {
                                    
                                    WebImage(url: URL(string: "https://afehe-hwf.buzz/storage" + "/" + image)).placeholder(
                                        Image("propertyBackImage")
                                    )
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: UIScreen.screenWidth - 16)
                                    .frame(height:283)
                                    .cornerRadius(52)
                                  
                                    
                                    .onAppear{
                                        isTextFieldFocused = true
                                    }
                                }
                            }
                            
                            Color.black.opacity(0.64)
                                .cornerRadius(52)
                            imageOverlay
                                .padding(.top,55)
                        }
                        .padding(.top,8)
                       
                        .frame(height:283)
                        
                        propertyInfo
                           
                        
                        Button{
                            vm.getTransactionsCosts(userId: appVM.user?.id ?? 1, amount: Double(invest))
//                          vm.createInvoice(userId: appVM.user?.id ?? 1, amount: Double(invest))
                        } label: {
                            Text("Invest")
                                .foregroundColor(.white)
                                .padding()
                                .frame(maxWidth: .infinity)
                                .backgroundColor(.blue)
                                .cornerRadius(12)
                        }
                        .id(2)
                        .onAppear{
                            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                                scrollReader.scrollTo(2, anchor: .center)
                            }
                        }
                        Spacer()
                            
                            RoundedRectangle(cornerRadius: 20)
                                .fill(Color.white)
                                .frame(height: 250)
                               
                    }
                }
            }
            .ignoresSafeArea()
            .padding(.horizontal,8)
            .onAppear{
                if isPreview {
                    vm.propertyDetail = samplePropertyDetail.data?.property
                }
            }
        }
        .sheet(isPresented: $vm.openWebViewToPay) {
            WebRepresent(user: $appVM.user, url: vm.linkToPayment!)
                .onDisappear(perform: {
                    presentation.wrappedValue.dismiss()
                })
              }
    }
}

#Preview {
    InvestView()
        .environmentObject(PropertiesViewModel())
}


extension InvestView{
    var imageOverlay: some View {
        VStack{
            HStack{
                Button {
                    
                    presentation.wrappedValue.dismiss()
                    
                } label: {
                    Image(systemName: "arrow.left")
                        .foregroundColor(.white)
                        .padding(12)
                        .background(
                            Circle().fill(Color.black.opacity(0.5))
                        )
                }
                Spacer()
            }
            .padding(.horizontal)
            
            Text("Invest")
                .foregroundColor(.white)
                .font(.system(size: 15))
            
            Text("AED ")
                .font(.system(size: 15).weight(.semibold))
                .foregroundColor(.white)
            + Text("\(invest)")
                .foregroundColor(.white)
                .font(.system(size: 28).weight(.bold))
            HStack{
                ForEach([100,500,1000,5000], id: \.self) { i in
                    Text("+\(i) AED")
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .background(RoundedCorner()
                            .stroke(Color.white, lineWidth: 1))
                        .onTapGesture {
                            invest += i
                        }
                }
            }
            .foregroundColor(.white)
            .font(.system(size: 13))
            .padding(.top,50)
            
        }
        
    }
    
    
    var propertyInfo: some View {
        VStack{
            if let property = vm.propertyDetail {
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
        }
        .modifier(CornerBackground())
        .frame(height: 150)
    }
}
