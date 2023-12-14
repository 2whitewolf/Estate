//
//  TabBar.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 12.09.2023.
//

import SwiftUI

struct CustomTabBar: View {
    @EnvironmentObject var appVM: AppViewModel
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
        ZStack{
            Color.white.ignoresSafeArea()
            
            VStack(spacing:0){
                Group {
                    switch appVM.selectedTab {
                    case .properties:
                        PropertiesList()
                            .environmentObject(appVM)
                    case .portfolio:
                        PortfolioView()
                            .environmentObject(appVM)
                    case .wallet:
                        WalletView()
                            .environmentObject(appVM)
                    case .profile:
                        ProfileView()
                            .environmentObject(appVM)
                    }
                }
                Divider()
                    .background(Color.gray)
                HStack(spacing: 0) {
                    ForEach(Tabs.allCases, id: \.self) { i in
                        Button {
                            withAnimation(.easeInOut) {
                                appVM.selectedTab = i
                            }
                        } label: {
                            VStack(spacing: 4) {
                                Image(i.image + (appVM.selectedTab == i ? "On" : ""))
                                    .renderingMode(.template)
                                Text(i.title)
                                    .font(.system(size: 12))
                            }
                            .foregroundColor(appVM.selectedTab == i ? Color.blue : Color.black)
                            .frame(height: 80)
                            .frame(maxWidth: .infinity)
                        }
                    }
                }
                .background(Color.white)
                
            }
            .environmentObject(appVM)
        }
        
    }
    
}


#Preview {
    NavigationView {
        CustomTabBar()
            .environmentObject(AppViewModel())
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
