//
//  Home.swift
//  Snake app
//
//  Created by hosam on 12/09/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var vm = SnakeViewmModel()
//    @State var timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect() // to updates the snake position every 0.1 second
    
    var body: some View {
        ZStack {
            ZStack {
                Color.pink.opacity(0.3)
                ZStack {
                    
                    ForEach (0..<vm.posArray.count, id: \.self) { index in
                        
                        ZStack {
                            Rectangle()
                                .frame(width: vm.snakeSize, height: vm.snakeSize)
                                .position(vm.posArray[index])
                            
                        }
                    }
                    
                    
                    Rectangle()
                        .fill(Color.red)
                        .frame(width: vm.snakeSize, height: vm.snakeSize)
                        .position(vm.foodPos)
                }
                
                
                
                if self.vm.isPlaying {
                    Button(action: {withAnimation{
                        vm.timer = Timer.publish(every: vm.timeCount, on: .main, in: .common).autoconnect()
                        vm.isPlaying.toggle()
                    }}, label: {
                        Image(systemName: "play")
                            .font(.system(size: 50))
                            .foregroundColor(.green)
                    })
                }
                
                if self.vm.isSpeed {
                    Button(action: {withAnimation{
                        vm.changeGame.toggle()
                        self.vm.timer.upstream.connect().cancel()

                    }}, label: {
                        Text("SPEED ")
                            .font(.system(size: 30))
                            .fontWeight(.bold)
                            .foregroundColor(.gray)
                    })
                    .offset(x: -UIScreen.main.bounds.width/3, y: -UIScreen.main.bounds.height/2.5)
                }
            }
            .opacity(vm.changeGame ? 0 : 1)
            
            .gesture(DragGesture()
                        .onChanged (vm.onChanged(gesture:))
                        .onEnded(vm.onEnded(gesture:))
            )
            .onTapGesture(count: 3) {
                withAnimation{
                    if
                        vm.isPlaying   { return }
                vm.isPlaying=true
                self.vm.timer.upstream.connect().cancel()
                vm.isSpeed=true
                }
            }

            if vm.changeGame {
                
                ActivityIndicator()
                    .transition(.move(edge: .bottom))
                    .environmentObject(vm)
            }
        }
        .onAppear() {vm.onAppears()}
        
        .onReceive(vm.timer) { (_) in
            vm.onRecieve()
        }
        .edgesIgnoringSafeArea(.all)
        
        .alert(isPresented: $vm.gameOver, content: {
            Alert(title: Text("Game Result...."), message: Text("Game Over......."), dismissButton: .default(Text("Play Again ?"), action: {
                //reset all
                vm.playAgain()
            }))
    })
        
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

//self.timer = Timer.publish(every: 0.01, on: .main, in: .common).autoconnect()
