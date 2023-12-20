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
    @StateObject var vm: PaymentViewModel
    
    @State var presentAgree: Bool = false
    
    @FocusState private var isTextFieldFocused: Bool
    
    @State var goNext: Bool = false
    
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
             NavigationLink("", destination: CheckoutInvetsmentView()
                .environmentObject(vm)
                .navigationBarHidden(true)
                .onDisappear{
                    goNext = false
                    presentAgree = false
                   
                }, isActive: $goNext)
            
            Color.white.ignoresSafeArea()
            VStack{
             
                    ScrollView(showsIndicators: false) {
                        ScrollViewReader { scrollReader in
                        ZStack(alignment: .top) {
                            TextField("", value: $vm.invest, formatter: formatter)
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
//                                    .frame(maxWidth: .infinity)
                                    .frame(height:283)
                                    .cornerRadius(52)
                                  
                                    
                                    .onAppear{
                                        isTextFieldFocused = true
                                    }
                                }
                            }
                                
                            
                          
//                                .padding(.top,55)
                        }
                       
                        .overlay(
                            ZStack{
                                Color.black.opacity(0.64)
                                    .cornerRadius(52)
                                imageOverlay
                            }
                        )
                        .padding(.top,16)
                       
                        .frame(height:283)
                        
                        propertyInfo
                                .padding(.top,8)
                           
                            Button{
                                presentAgree = true
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

        }
        .popup(isPresented: $presentAgree) {
            PaymentAgree(presentAgree:$presentAgree,goNext: $goNext)
               
        } customize: {
            $0
                .type(.floater(verticalPadding: 0, useSafeAreaInset: false))
                .position(.bottom)
                .closeOnTapOutside(true)
                .backgroundColor(.black.opacity(0.4))
        }
       
    }
}

#Preview {
    InvestView( vm: PaymentViewModel())
        
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
            + Text(vm.invest.rotate(0))
                .foregroundColor(.white)
                .font(.system(size: 28).weight(.bold))
            HStack{
                ForEach([100,500,1000,5000], id: \.self) { i in
                    Text("+" + i.rotate(0) + " AED")
                        .padding(.horizontal,8)
                        .padding(.vertical,5)
                        .background(RoundedCorner()
                            .stroke(Color.white, lineWidth: 1))
                        .onTapGesture {
                            vm.invest += i
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
