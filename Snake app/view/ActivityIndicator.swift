//
//  ActivityIndicator.swift
//  PlayIT
//
//  Created by hosam on 5/17/21.
//  Copyright © 2021 Bola Fayez. All rights reserved.
//

import SwiftUI

struct ActivityIndicator: View {
    @EnvironmentObject var vm:SnakeViewmModel
//    @ObservedObject var vm:SnakeViewmModel

    var body: some View {
        ZStack {
            
            Color.black.opacity(0.6).ignoresSafeArea(.all, edges: .all)

            
            VStack  {
                
                Spacer()
                
                VStack{
                    
                    ForEach(filters,id:\.self) {filter in

                        LanguageRowView(shows: .constant(false), title: filter)
                            .environmentObject(vm)
                }
                    
    //                Spacer()
                
            }
                
                Spacer()

            }
        }
    
}
}

struct SCartRowsView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        ActivityIndicator(vm: SnakeViewmModel())
    }
}

    

    var filters:[String] = ["HARD","NORMAL","SLOW"]
