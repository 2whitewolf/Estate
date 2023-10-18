//
//  FinancialsView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI

struct FinancialsView: View {
    @State private var selected = 0
    
    var body: some View {
        VStack (alignment: .leading,spacing : 8){
            Text("Financials")
                .font(.system(size: 20).weight(.semibold))
                .foregroundColor(.black)
            Picker("What is your favorite color?", selection: $selected) {
                Text("Acquisition").tag(0)
                Text("Return on Investment").tag(1)
            }
            .pickerStyle(.segmented)
            if selected == 0 {
                FinancialsCellView(title: "Property Price", second: "AED 1,595,518")
                FinancialsCellView(title: "Investment needed (62%)", second: "AED 638,702.20")
                FinancialsCellView(title: "Transaction fee (4%)", second: "AED 63,870.22")
                FinancialsCellView(title: "[App Name] fee (2%)", second: "AED 31,510.48")
                FinancialsCellView(title: "Investment cost", second: "AED 734,507.53")
            } else {
                FinancialsCellView(title: "Annual Gross ROI (at least 10%)", second: "AED 1,595,518")
                FinancialsCellView(title: "Outgoings", second: "AED 638,702.20")
                FinancialsCellView(title: "Net Income", second: "AED 63,870.22")
            }
        }
        .modifier(CornerBackground())
    }
}

struct FinancialsView_Previews: PreviewProvider {
    static var previews: some View {
        FinancialsView()
    }
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
