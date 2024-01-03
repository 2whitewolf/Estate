//
//  FinancialsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI

struct FinancialsView: View {
    @State private var selected = 0
    @EnvironmentObject var vm: PropertiesViewModel
    @State var opened: Bool = false
    
    var body: some View {
        VStack (alignment: .leading,spacing : 8){
            Text("Financials".localized)
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(.black)
            Picker("What", selection: $selected) {
                Text("Acquisition".localized).tag(0)
                Text("Return on Investment".localized).tag(1)
            }
            .pickerStyle(.segmented)
            if let property = vm.propertyDetail {
                if selected == 0 {
                    FinancialsCellView(title: "Property Price".localized, second: "AED " +  (property.price?.rotate(1) ?? ""))
                    HStack{
                        Text("Transaction Costs".localized)
                            .font(.system(size: 13))
                        Button{
                            withAnimation(.linear) {
                                opened.toggle()
                            }
                        } label: {
                            Image(systemName: opened ? "chevron.up" : "chevron.down" )
                            
                        }
                         Spacer()
                        Text("123456")
                            .font(.system(size: 13).weight(.semibold))
                    }
                    .foregroundColor(.black)
                    if opened {
                        VStack(spacing : 8){
                            FinancialsCellView(title: "DLD fee (4%)", second: "AED " + (property.dldFee?.rotate(2) ?? ""))
                            FinancialsCellView(title: "DubX fee (4%)", second: "AED " + (property.dubXfee?.rotate(2) ?? ""))
                            FinancialsCellView(title: "Registration fee (2%)", second: "AED " + "\(property.registrationFee ?? 0)")
                        }
                        .padding(.leading)
                    }
                    FinancialsCellView(title: "Investment cost".localized, second: "")
                } else {
                    FinancialsCellView(title: "Annual Gross ROI (at least 10%)", second: "AED 1,595,518")
                    FinancialsCellView(title: "Outgoings".localized, second: "AED 638,702.20")
                    FinancialsCellView(title: "Net Income".localized, second: "AED 63,870.22")
                }
            }
        }
        .modifier(CornerBackground())
        .onAppear{
            if isPreview {
                vm.propertyDetail = samplePropertyDetail.data?.property
            }
        }
    }
        
}

#Preview {
        FinancialsView()
        .environmentObject(PropertiesViewModel())
    
}


fileprivate struct FinancialsCellView: View {
    var title: String
    var second: String
    var body: some View{
        HStack{
            Text(title)
                .font(.system(size: 13))
             Spacer()
            Text(second)
                .font(.system(size: 13).weight(.semibold))
        }
        .foregroundColor(.black)
    }
}
