//
//  GuideLines.swift
//  RecipeSearch
//
//  Created by chris on 14/12/2024.
//


// -----abondoned due to UI design updated--------

import SwiftUI

struct GuideLines: View {
    
   
    
    let links: [ExternalLink] = [
        ExternalLink(title: "ExternalLink1 12312412", url: "https://www.google.com"),
        ExternalLink(title: "ExternalLink2 asdfs", url: "https://www.google.com")
    ]
    
    var body: some View {

        
        VStack(alignment: .leading, spacing: 0) {
            Text("Guildlines")
               // .fontWeight(.bold)
            .font(.title2)
            .padding(.top, 15)
            .padding(.horizontal, 14)
            
                if !links.isEmpty {
                    ForEach(links, id: \.title) { link in
                        
                        HStack(spacing: 0) {
                            Text(link.title)
                                .foregroundStyle(Color.red)
                                //.border(Color.black)
                                .padding(.horizontal, 15)
                                .padding(.vertical, 10)
                            
                            Image(systemName: "chart.line.uptrend.xyaxis")
                                .foregroundStyle(Color.red)
                            
                            Spacer()
                        }
                    }
                }
        }
        //.border(Color.yellow)
    }
}

#Preview {
    GuideLines()
}
