//
//  TextFiledStyle.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 13.09.2023.
//

import SwiftUI

struct ImageWithLineStroke: TextFieldStyle {
    var title: String
    var image: Image
    @State var isEditing: Bool = false
    @State var color: Color  = Color.gray
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 4){
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 13))
            HStack{
                image
                configuration  
                    .onTapGesture {
                        withAnimation {
                            //                                       isEditing = true
                            color = .blue
                        }
                    }
                //                    .onSubmit {
                //                        color =  .customGray
                //                    }
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: 0.5)
            )
        }
    }
}

struct TitleAndLineStroke: TextFieldStyle {
    var title: String
    @State var isEditing: Bool = false
    @State var color: Color  = Color.gray
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 4){
            Text(title)
                .foregroundColor(.black)
                .font(.system(size: 13))
            HStack{
                configuration
                    .onTapGesture {
                        withAnimation {
                            //                                       isEditing = true
                            color = .blue
                        }
                    }
                //                    .onSubmit {
                //                        color =  .customGray
                //                    }
                
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 12)
                .stroke(color, lineWidth: 0.5)
            )
        }
    }
}
