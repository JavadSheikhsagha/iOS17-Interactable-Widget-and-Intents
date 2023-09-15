//
//  SharedViews.swift
//  iOS 17 Interactable Widgets
//
//  Created by Javad on 9/15/23.
//

import Foundation
import SwiftUI

struct NetworkImage: View {

    let url: URL?

  var body: some View {

    Group {
     if let url = url, let imageData = try? Data(contentsOf: url),
       let uiImage = UIImage(data: imageData) {

       Image(uiImage: uiImage)
         .resizable()
         .aspectRatio(contentMode: .fill)
      }
      else {
       Image("placeholder-image")
      }
    }
  }

}
