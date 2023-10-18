//
//  PropertyLocationView.swift
//  RealEstateFunding
//
//  Created by iMacRoman on 20.09.2023.
//

import SwiftUI
import MapKit

struct PropertyLocationView: View {
    var coordinate: CLLocationCoordinate2D
    @State private var region = MKCoordinateRegion()

    func setRegion(_ coordinate: CLLocationCoordinate2D) {
        
       region = MKCoordinateRegion(
        center: coordinate,
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
      )
    }
     
    var body: some View {
        VStack(alignment: .leading){
            Text("Location")
                .foregroundColor(.black)
                .font(.system(size: 20).weight(.semibold))
            
            Text("Downtown Dubai, Dubai, United Arab Emirates")
                .foregroundColor(.gray)
                .font(.system(size: 13))
            Map(coordinateRegion: $region)
                .frame(height:224)
                .cornerRadius(12)
                .onAppear {
                    setRegion(coordinate)
                }
            
            Button{
                
            } label: {
                HStack{
                    Image(systemName: "mappin")
                    Text("View on  theMap")
                }
                    .foregroundColor(.blue)
                    .padding(.vertical)
                    .frame(maxWidth: .infinity)
                    .background(RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.blue,lineWidth: 0.5))
            }
        }
        .modifier(CornerBackground())
    }
}

struct PropertyLocationView_Previews: PreviewProvider {
    static var previews: some View {
        PropertyLocationView(coordinate: CLLocationCoordinate2D(latitude: 34.011_286, longitude: -116.166868))
    }
}
