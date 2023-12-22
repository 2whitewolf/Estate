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
    @State var datePickerShow: Bool = false
    var button_enabled: Binding<Bool> {
        Binding(get: {
            !vm.name.isEmpty && !vm.number.isEmpty && !vm.promocode.isEmpty
        }) { (newVal) in

        }
    }

    var body: some View {
        ZStack{
            Color.white.ignoresSafeArea()
            VStack(alignment: .leading){
                
                Text("Start Investing Today.".localized)
                    .font(.system(size: 28).weight(.bold))
                    .foregroundColor(.black)
                Text("In Less Than 5 Minutes, You Can Start Growing Your Wealth.".localized)
                    .foregroundColor(.customGray)
            
                
              inputsView
                .padding(.top,40)
            
                Spacer()
                Button {
                    vm.currentState =  vm.currentState.next()
                } label: {
                    Text("Next".localized)
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity)
                        .frame(height: 60)
                        .background(button_enabled.wrappedValue ?  Color.blue : Color.gray)
                        .cornerRadius(12)
                       
                }
                .disabled(!button_enabled.wrappedValue)
                
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
        TextField("John Smith", text: $vm.name)
            .textFieldStyle(ImageWithLineStroke(title: "Full Name".localized, image: Image("person")))
    }
    
    private var dateView: some View {
        VStack(alignment: .leading,spacing:4){
            Text("Date of Birth".localized)
                .font(.system(size: 13))
            HStack{
                Image("calendar")
                Text(vm.date.stringRepresentationOfYearMonthDay)
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
                    .stroke(Color.customGray, lineWidth: 0.5)
            )
        }
    }
    
    private var phoneView: some View {
        VStack(alignment: .leading,spacing:4){
            Text("Phone Number".localized)
                .font(.system(size: 13))
            HStack{
                Image("phone")
                iPhoneNumberField(text: $vm.number)
                    .flagSelectable(true)
                
                    .foregroundColor(Color.black)
                    .flagHidden(false)
            }
            .padding()
            .frame(maxWidth: .infinity)
            .frame(height: 60)
            .background(
                RoundedRectangle(cornerRadius: 12)
                    .stroke( vm.number.count > 0 ? Color.blue :  Color.customGray, lineWidth: 0.5)
            )
        }
    }
    
    private var referalView: some View {
        TextField("Promocode".localized, text: $vm.promocode)
            .textFieldStyle(ImageWithLineStroke(title: "Refferal Code".localized ,image: Image("discount")))
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
            DatePicker("", selection: $vm.date, displayedComponents: .date)
                .datePickerStyle(.graphical)
                .padding()
            HStack{
                Spacer()
                
                Button{
                    withAnimation {
                        datePickerShow.toggle()
                    }
                } label: {
                    Text("Done".localized)
                        .foregroundColor(.blue)
                }
                .padding()
            }
            
        }
        .background(Color.white)
        .cornerRadius(12)
    }
}

