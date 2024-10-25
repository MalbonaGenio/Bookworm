//
//  RatingView.swift
//  Bookworm
//
//  Created by Pau Valverde Molina on 10/22/24.
//

import SwiftUI

struct RatingView: View {
    //Bind the rating value so we can use it elswhere in another view
    @Binding var rating: Int
    
    //Properties from the rating
    var label = ""
    var maxRating = 5
    var offImage: Image?
    var onImage = Image(systemName: ("star.fill"))
    
    var offColor = Color.gray
    var onColor = Color.yellow
    
    
    
    
    var body: some View {
        HStack {
            if label.isEmpty == false {
                Text(label)
            }
            
            ForEach(1..<maxRating + 1, id: \.self) { number in
                Button {
                    rating = number
                } label: {
                    image(for: number)
                        .foregroundStyle(number > rating ? offColor : onColor)
                }
            }
        }
    }
    
    
    func image(for number: Int) -> Image {
        if number > rating {
            offImage ?? onImage
        } else {
            onImage
        }
    }
}

#Preview {
    RatingView(rating: .constant(4))
}
