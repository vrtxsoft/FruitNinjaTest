//
//  GameScene.swift
//  FruitNinjaTest
//
//  Created by fawad farooq on 9/1/19.
//  Copyright © 2019 fawad farooq. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    
   let Fruits = ["pine","apple","banana","apple","pine","banana"]
    
    var gameTimer: Timer?
    
    
    var Circle : SKShapeNode!
    var pineAppleNode : SKSpriteNode!
    
    let PineAppleCategory  : UInt32 = 0x1 << 1
    let BladeCategory: UInt32 = 0x1 << 2
    let RedBarCategory : UInt32 = 0x1 << 6

    
    override func didMove(to view: SKView) {
        physicsWorld.speed = 0.5
        
        // Get label node from scene and store it for use later
//        SKAction.removeFromParent()
        physicsWorld.gravity.dy = -4.0
        
        createPineApple()
        gameTimer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { (time) in
            
                            self.createPineApple()

            
//            for n in 1...2 {
//
//                self.createPineApple()
//            }
            
        })
        
    }
    
    
    func createPineApple() {

        let fruitSprite = (Fruits.shuffled().randomElement())
        print(fruitSprite)
        
        let randomNumer =  arc4random_uniform(10)
        let randomFloat = CGFloat.random(in: 0.7...1.5)
        let randomAngular = arc4random_uniform(2)
       let angularMotion : CGFloat = randomAngular == 0 ? 1 : -1
        
        
        
        let screenSize = UIScreen.main.bounds
        var ScreenWidth = CGFloat(arc4random_uniform(UInt32(screenSize.width)))
        
//        print("random nmber")
//        print(randomNumer)
//        print(ScreenWidth)
//        print("angularMotion")
//        print(angularMotion)
        
        
        pineAppleNode = SKSpriteNode(imageNamed: fruitSprite!)
        pineAppleNode.name = "pineNode"
        pineAppleNode.zPosition = 1.0;
//        pineAppleNode.lightingBitMask = 1
////        pineAppleNode.shadowedBitMask = 1
//        pineAppleNode.shadowCastBitMask = 1
        
        
 //        pineAppleNode.size.width = pineAppleNode.size.width / 6
//        pineAppleNode.size.height = pineAppleNode.size.height / 6
       
          pineAppleNode.setScale(randomFloat)
        
        
        
            if ScreenWidth >= 1000 {
//                print(ScreenWidth)
//            print("maximum")
                ScreenWidth = 750
                
            }else if ScreenWidth <= 100{
//                print(ScreenWidth)
//                print("Minnumin X")
                
                ScreenWidth = 200
        }
        
        
       
        
//        pineAppleNode.position = CGPoint(x:ScreenWidth , y:UIScreen.main.bounds.height + pineAppleNode.size.height + CGFloat.random(in: 0...200));
        pineAppleNode.position = CGPoint(x:ScreenWidth + CGFloat(arc4random_uniform(UInt32(50))) , y:UIScreen.main.bounds.height + pineAppleNode.size.height);
        
        pineAppleNode.physicsBody = SKPhysicsBody(rectangleOf: pineAppleNode.size)
        
//        pineAppleNode.physicsBody = SKPhysicsBody(circleOfRadius: max(pineAppleNode.size.width, pineAppleNode.size.height))
        
        pineAppleNode.physicsBody?.allowsRotation = true
       
        
        pineAppleNode.physicsBody?.angularVelocity = 2  * angularMotion
        
        
        pineAppleNode.physicsBody?.collisionBitMask = 0


         pineAppleNode.physicsBody?.contactTestBitMask = BladeCategory
//        pineAppleNode.physicsBody?.collisionBitMask = RedBarCategory
        pineAppleNode.physicsBody?.affectedByGravity = true
        
        addChild(pineAppleNode)

    }
    
    
//    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
//        let touch = touches.first as UITouch!
//        let touchLocation = touch.locationInNode(self)
//        let targetNode = nodeAtPoint(touchLocation) as! SKSpriteNode
//    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

        let touch = touches.first as UITouch?
        let touchLocation = touch!.location(in: self)

            Circle = SKShapeNode(circleOfRadius: 40)
            Circle.name = "CircleTap"
            Circle.strokeColor = SKColor.black
            Circle.glowWidth = 10.0
            Circle.fillColor = SKColor.yellow
            Circle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
            Circle.physicsBody?.isDynamic = true //.physicsBody?.dynamic = true
            self.addChild(Circle)
        

//        if targetNode.name == "pineNode" {
//
//            targetNode.removeFromParent()
//
//        }

    }
    
    
//    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
//        for touch in touches{
//            let location = touch.location(in: self)
//
//            let targetNode = atPoint(location)
//
//            if targetNode.name == "pineNode" {
//
//                targetNode.removeFromParent()
//
//            }
//
//
//
//        }
//    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
//        createPineApple()

        if let rock = self.childNode(withName: "pineNode") {
    
    
           
            if rock.position.y <= 0 {
                
                
                rock.removeFromParent()
                //                pineAppleNode.removeFromParent()
                
            }

//            if  !intersects(rock){
//                print("out of screen")
////
//
//            }

        }


    }
    
    
}
