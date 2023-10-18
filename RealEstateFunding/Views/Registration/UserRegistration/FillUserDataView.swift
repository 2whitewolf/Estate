//
//  LoginView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.09.2023.
//

import SwiftUI
import iPhoneNumberField

struct FillUserDataView: View {
    @EnvironmentObject var vm:RegistrationViewModel

    @State var email: String = ""
    @State var date: Date = Date()
    @State var number: String = ""
    @State var promocode: String = ""
    @State var datePickerShow: Bool = false
//    @State var dateChanged
    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                
                Text("Start Investing Today.")
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.black)
                Text("In Less Than 5 Minutes, You Can Start Growing Your Wealth.")
                    .foregroundColor(.customGray)
            
                
              inputsView
                .padding(.top,40)
            
                Spacer()
                Button {
                    vm.currentState  = .from
                } label: {
                    Text("Next")
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(Color.blue)
                        .cornerRadius(12)
                }
                
            }
            .padding(.bottom, 20)
            .foregroundColor(.customGray)
            .padding(.horizontal,24)
            
            if datePickerShow {
                Color.black.opacity(0.7).ignoresSafeArea()
                datePickerView
                    .padding(.horizontal)
            }
        }
        .onAppear(perform: UIApplication.shared.addTapGestureRecognizer)
    }
}

struct FillUserDataView_Previews: PreviewProvider {
    static var previews: some View {
        FillUserDataView()
            .environmentObject(RegistrationViewModel())
    }
}


extension FillUserDataView {
    
    private var nameView : some View {
        TextField("John Smith", text: $email)
            .textFieldStyle(ImageWithLineStroke(title: "Full Name", image: Image("person")))
    }
    
    private var dateView: some View {
        VStack(alignment: .leading,spacing:4){
            Text("Date of Birth")
                .font(.system(size: 13))
            HStack{
                Image("calendar")
                Text(date.stringRepresentationOfYearMonthDay)
                 Spacer()
                Button{
                    withAnimation {
                        datePickerShow = true
                    }
                } label: {
                    Image(systemName: "chevron.down")
                        .foregroundColor(.gray)
                }
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(Color.customGray, lineWidth: 1)
            )
        }
    }
    
    private var phoneView: some View {
        VStack(alignment: .leading,spacing:4){
            Text("Phone Number")
                .font(.system(size: 13))
            HStack{
                Image("phone")
                iPhoneNumberField(text: $number)
                    .flagSelectable(true)
                
                    .foregroundColor(Color.black)
                    .flagHidden(false)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke( number.count > 0 ? Color.blue :  Color.customGray, lineWidth: 1)
            )
        }
    }
    
    private var referalView: some View {
        TextField("Promocode", text: $promocode)
            .textFieldStyle(ImageWithLineStroke(title: "Refferal Code",image: Image("discount")))
    }
    
    private var inputsView: some View {
        VStack(spacing: 16){
            nameView
            dateView
            phoneView
            referalView
        }
    }
    
    private var datePickerView: some View {
        VStack{
            DatePicker("", selection: $date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
            HStack{
                Spacer()
                
                Button{
                    withAnimation {
                        datePickerShow.toggle()
                    }
                } label: {
                    Text("Done")
                        .foregroundColor(.blue)
                }
                .padding()
            }
            
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}
