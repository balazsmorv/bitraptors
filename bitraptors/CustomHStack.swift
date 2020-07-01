//
//  CustomHStack.swift
//  bitraptors
//
//  Created by Morvay Balázs on 2020. 07. 01..
//  Copyright © 2020. BME AUT. All rights reserved.
//

import SwiftUI

struct CustomHStack: View {
    
    let name: String
    let value: String
    
    init(name: String, value: String?) {
        self.name = name
        self.value = value ?? "not available"
    }
    
    var body: some View {
        HStack {
            Text(name)
                .font(.body)
                .fontWeight(.regular)
                .shadow(radius: 20)
            Spacer()
            Text(value)
                .font(.body)
                .fontWeight(.light)
                .shadow(radius: 20)
        }.padding(.leading).padding(.trailing)
    }
}

struct CustomHStack_Previews: PreviewProvider {
    static var previews: some View {
        CustomHStack(name: "name", value: "value")
    }
}
