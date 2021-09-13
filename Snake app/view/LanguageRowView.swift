//
//  LanguageRowView.swift
//  MST XD
//
//  Created by hosam on 3/17/21.
//

import SwiftUI

struct LanguageRowView: View {
    
    @State var show = false
    @Binding var shows:Bool
    var title = "HARD"
    @EnvironmentObject var vm:SnakeViewmModel
    var body: some View {
        
        VStack{
            
            HStack {
                
                
                
                Text(title)
                    .fontWeight(.semibold)
                    .foregroundColor(.white.opacity(0.8))
//                    .foregroundColor(Color.black.opacity(0.7))
                
                Spacer()
                
                
                
                
                Button(action: {withAnimation
                {
                    vm.cheackGame(title: title  )
                    show.toggle()
//                    vm.changeGame.toggle()
                }
                }, label: {
                    
                    
                    ZStack {
                        
                        Circle()
                            .stroke(vm.isChosen == title ? Color.blue :  Color.gray,lineWidth: 1)
                            .frame(width: 25, height: 25)
                        
                        if vm.isChosen==title {
                            
                            Image(systemName: "checkmark.circle.fill")
                                .font(.system(size: 25))
                                .foregroundColor(.green)
                            
                        }
                    }
                })
                
            }
            .padding(.horizontal,6)
           
            Divider()
        }
        .padding(.horizontal)
        .padding()
        .background(Color.black)
        .cornerRadius(32)
        .padding(.horizontal)
    }
}

struct LanguageRowView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
//        LanguageRowView(show: true, shows: .constant(true), vm: SnakeViewmModel())
    }
}
