//
//  TabBar.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

struct CustomTabBar: View {
    @State var selectedTab: Tabs = .properties
    @State var firstLaunch: Bool = false

    
    var body: some View {
        ZStack{
            TabBarViewModifire {
                content
            }
            .navigationBarBackButtonHidden()
        }
    }
    @ViewBuilder
    private var content: some View {
//        ZStack{
//            Color.white.ignoresSafeArea()
//        
        VStack{
            Group {
                switch selectedTab {
                case .properties:
                    PropertiesList()
                case .portfolio:
                    PortfolioView()
                case .wallet:
                    WalletView()
                case .profile:
                    ProfileView()
                }
            }
            
            HStack(spacing: 0) {
                ForEach(Tabs.allCases, id: \.self) { i in
                    Button {
                        withAnimation(.easeInOut) {
                            selectedTab = i
                        }
                    } label: {
                        VStack(spacing: 4) {
                            Image(i.image + (selectedTab == i ? "On" : ""))
                                .renderingMode(.template)
                            Text(i.title)
                                .font(.system(size: 12))
                        }
                        .foregroundColor(selectedTab == i ? Color.blue : Color.black)
                        .frame(height: 80)
                        .frame(maxWidth: .infinity)
                    }
                }
            }
            .background(Color.white)
        }

        
    }
    
}

struct TabBar_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            CustomTabBar()
        }
    }
}


enum Tabs: String, CaseIterable {
    case properties, portfolio, wallet, profile
    
    var title: String {
        switch self {
        case .properties:
            return "Properties"
        case .portfolio:
            return "Portfolio"
        case .wallet:
            return "Wallet"
        case .profile:
            return "My Profile"
        }
    }
    
    var image: String {
        return self.rawValue
    }
}
