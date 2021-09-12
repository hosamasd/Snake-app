//
//  SnakeViewmModel.swift
//  Snake app
//
//  Created by hosam on 12/09/2021.
//

import SwiftUI

enum direction {
    case up, down, left, right
}

class SnakeViewmModel: ObservableObject {
   
    @Published var startPos : CGPoint = .zero // the start poisition of our swipe
    @Published var isStarted = true // did the user started the swipe?
    @Published var gameOver = false // for ending the game when the snake hits the screen borders
    @Published var dir = direction.down // the direction the snake is going to take
    @Published var posArray = [CGPoint(x: 0, y: 0)] // array of the snake's body positions
    @Published var foodPos = CGPoint(x: 0, y: 0) // the position of the food
    let snakeSize : CGFloat = 10 // width and height of the snake
    
    let minX = UIScreen.main.bounds.minX
    let maxX = UIScreen.main.bounds.maxX
    let minY = UIScreen.main.bounds.minY
    let maxY = UIScreen.main.bounds.maxY

    func changeRectPos() -> CGPoint {
            let rows = Int(maxX/snakeSize)
            let cols = Int(maxY/snakeSize)
            
            let randomX = Int.random(in: 1..<rows) * Int(snakeSize)
            let randomY = Int.random(in: 1..<cols) * Int(snakeSize)
            
            return CGPoint(x: randomX, y: randomY)
        }
    
    
    //checks whether the snake is inside or outside the screen borders, checks the direction of the user’s swipe, and then moves the snake in that direction
    
    func changeDirection () {
        if self.posArray[0].x < minX || self.posArray[0].x > maxX && !gameOver{
            gameOver.toggle()
        }
        else if self.posArray[0].y < minY || self.posArray[0].y > maxY  && !gameOver {
            gameOver.toggle()
        }
        var prev = posArray[0]
        if dir == .down {
            self.posArray[0].y += snakeSize
        } else if dir == .up {
            self.posArray[0].y -= snakeSize
        } else if dir == .left {
            self.posArray[0].x += snakeSize
        } else {
            self.posArray[0].x -= snakeSize
        }
        
        for index in 1..<posArray.count {
            let current = posArray[index]
            posArray[index] = prev
            prev = current
        }
    }
    
}
