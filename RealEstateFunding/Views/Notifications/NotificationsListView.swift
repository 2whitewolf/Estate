//
//  NotificationsListView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 18.09.2023.
//

import SwiftUI

struct NotificationsListView: View {
    @Environment(\.presentationMode) var presentation
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
              
                    Button {
                        presentation.wrappedValue.dismiss()
                    } label: {
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .padding(12)
                            .background(
                                Circle().stroke(Color.gray, lineWidth: 0.5)
                             
                            )
                    }
                 
                HStack{
                    Text("Notifications")
                        .foregroundColor(.black)
                        .font(.system(size: 34).weight(.bold))
                     Spacer()
                }
//                .padding(.top,50)
                .padding(.leading,22)
                
                
                ScrollView(showsIndicators: false) {
                    ForEach(1..<5) { i in
                        NotificationCell(title: "Terms & Conditions update", message: "Terms and Conditions” is the document governing the contractual relationship between the provider of a service and its user. On the web, this document is often also called “Terms of Service” (ToS), “Terms of Use”, EULA (“End-User License Agreement”), “General Conditions” or “Legal Notes", date: "15:35", link:  i == 3 ? "https://www.google.com" : "" )
                            .padding(.bottom,20)
                    }
                }
                
            }
            .padding(.horizontal,8)
            
        }
    }
}

struct NotificationsListView_Previews: PreviewProvider {
    static var previews: some View {
//        NavigationView {
            NotificationsListView()
//        }
    }
}


private struct NotificationCell: View {
    var title: String
    var message: String
    var date: String
    var link : String?
    var body: some View{

        VStack(alignment: .leading){
                HStack{
                   Text(title)
                        .foregroundColor(.black)
                        .font(.system(size: 20).weight(.semibold))
                     Spacer()
                     Text(date)
                        .foregroundColor(.gray)
                        .font(.system(size: 12))
                }
            
            Text(message)
                .foregroundColor(.black)
                .padding(.top,10)
            
            if let url = URL(string: link ?? "") {
//                Link(destination: url, : Text("Link Preview"))
                 Link("Link Preview", destination: url)
            }
            }
           
        .padding()
        .background(RoundedRectangle(cornerRadius: 12)
            .stroke(Color.gray, lineWidth: 0.5))
    }
}
