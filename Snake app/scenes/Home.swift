//
//  Home.swift
//  Snake app
//
//  Created by hosam on 12/09/2021.
//

import SwiftUI

struct Home: View {
    @StateObject var vm = SnakeViewmModel()
    let timer = Timer.publish(every: 0.1, on: .main, in: .common).autoconnect() // to updates the snake position every 0.1 second
    
    var body: some View {
        ZStack {
            Color.pink.opacity(0.3)
            ZStack {
                ForEach (0..<vm.posArray.count, id: \.self) { index in
                    Rectangle()
                        .frame(width: vm.snakeSize, height: vm.snakeSize)
                        .position(vm.posArray[index])
                }
                Rectangle()
                    .fill(Color.red)
                    .frame(width: vm.snakeSize, height: vm.snakeSize)
                    .position(vm.foodPos)
            }
            
            if self.vm.gameOver {
                Text("Game Over")
            }
        }
        
        .gesture(DragGesture()
                    .onChanged { gesture in
                        if vm.isStarted {
                            vm.startPos = gesture.location
                            vm.isStarted.toggle()
                        }
                    }
                    .onEnded {  gesture in
                        let xDist =  abs(gesture.location.x - vm.startPos.x)
                        let yDist =  abs(gesture.location.y - vm.startPos.y)
                        if vm.startPos.y <  gesture.location.y && yDist > xDist {
                            vm.dir = direction.down
                        }
                        else if vm.startPos.y >  gesture.location.y && yDist > xDist {
                            vm.dir = direction.up
                        }
                        else if vm.startPos.x > gesture.location.x && yDist < xDist {
                            vm.dir = direction.right
                        }
                        else if vm.startPos.x < gesture.location.x && yDist < xDist {
                            vm.dir = direction.left
                        }
                        vm.isStarted.toggle()
                    }
        )
        
        .onAppear() {
            vm.foodPos = vm.changeRectPos()
            vm.posArray[0] = vm.changeRectPos()
        }
        
        .onReceive(timer) { (_) in
            if !vm.gameOver {
                vm.changeDirection()
                if vm.posArray[0] == vm.foodPos {
                    vm.posArray.append(vm.posArray[0])
                    vm.foodPos = vm.changeRectPos()
                }
            }
        }
        .edgesIgnoringSafeArea(.all)
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
