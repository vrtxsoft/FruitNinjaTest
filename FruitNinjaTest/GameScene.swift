//
//  GameScene.swift
//  FruitNinjaTest
//
//  Created by fawad farooq on 9/1/19.
//  Copyright © 2019 fawad farooq. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene ,SKPhysicsContactDelegate{
    
    let Fruits = ["pine","apple","banana","apple","pine","banana"]
    
    
    var levelTimerLabel = SKLabelNode(fontNamed: "ArialMT")
    
    //Immediately after leveTimerValue variable is set, update label's text
    var levelTimerValue: Int = 60 {
        didSet {
            levelTimerLabel.text = "Time left: \(levelTimerValue)"
        }
    }
    
    var nameCounter = 0
    var CreateCounter: Timer?
    
    
    var Circle : SKShapeNode!
    var pineAppleNode : SKSpriteNode!
    
    let fruitCategory  : UInt32 = 0x1 << 1
    let BladeCategory: UInt32 = 0x1 << 2
//    let RedBarCategory : UInt32 = 0x1 << 6
    
    
    override func didMove(to view: SKView) {
        
        
        physicsWorld.contactDelegate = self
        
        levelTimerLabel.fontColor = .black
        levelTimerLabel.fontSize = 40
        levelTimerLabel.position = CGPoint(x: size.width/2, y: size.height/2 + 350)
        levelTimerLabel.text = "Time left: \(levelTimerValue) sec."
        addChild(levelTimerLabel)
        
        let wait = SKAction.wait(forDuration: 1)
        
        let block = SKAction.run({
            [unowned self] in
            if self.levelTimerValue > 0 {
                self.levelTimerValue -= 1
            }else{
                
                self.removeAction(forKey: "countdown")
                self.CreateCounter?.invalidate()
                self.view?.isPaused = true
                print("Game End")
            }
        })
        
        let sequence = SKAction.sequence([wait,block])
        run(SKAction.repeatForever(sequence), withKey: "countdown")
        
        
        physicsWorld.speed = 0.5
        physicsWorld.gravity.dy = -4.0
        
        self.view?.isMultipleTouchEnabled = false
       
        CreateCounter = Timer.scheduledTimer(withTimeInterval: 10 , repeats: true, block: { (time) in
            self.createPineApple()
        })
        
    }
    
    
    func createPineApple() {
        
        if nameCounter == 7 {
            nameCounter = 0
        }
        
        nameCounter  += 1
        
        let fruitSprite = (Fruits.shuffled().randomElement())
//        print(fruitSprite)
        
        let randomNumer =  arc4random_uniform(10)
        let randomFloat = CGFloat.random(in: 0.7...1.5)
        let randomAngular = arc4random_uniform(2)
        let angularMotion : CGFloat = randomAngular == 0 ? 1 : -1
        
        
        
        let screenSize = UIScreen.main.bounds
        var ScreenWidth = CGFloat(arc4random_uniform(UInt32(screenSize.width)))
        
        pineAppleNode = SKSpriteNode(imageNamed: fruitSprite!)
        pineAppleNode.name = "pineNode\(String(nameCounter))"
        pineAppleNode.zPosition = 3.0;
        pineAppleNode.setScale(randomFloat)
        
        
        if ScreenWidth >= 1000 {
            ScreenWidth = 750
        }else if ScreenWidth <= 100{
            ScreenWidth = 200
        }
        
        pineAppleNode.position = CGPoint(x:ScreenWidth + CGFloat(arc4random_uniform(UInt32(50))) , y:UIScreen.main.bounds.height + pineAppleNode.size.height);
        
        pineAppleNode.physicsBody = SKPhysicsBody(rectangleOf: pineAppleNode.size)
        pineAppleNode.physicsBody?.allowsRotation = true
        pineAppleNode.physicsBody?.angularVelocity = 2  * angularMotion
        pineAppleNode.physicsBody?.categoryBitMask = fruitCategory
        pineAppleNode.physicsBody?.collisionBitMask = 0
        pineAppleNode.physicsBody?.contactTestBitMask = BladeCategory
        pineAppleNode.physicsBody?.affectedByGravity = true
        
        addChild(pineAppleNode)
        
    }
    
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let touch = touches.first as UITouch?
        let touchLocation = touch!.location(in: self)
        
        

        
        Circle = SKShapeNode(circleOfRadius: 40)
        Circle.position = touchLocation
        Circle.name = "CircleTap"
        Circle.strokeColor = .orange
        Circle.glowWidth = 10.0
        Circle.fillColor = SKColor.red
        Circle.zPosition = 5.0
        Circle.physicsBody = SKPhysicsBody(circleOfRadius: 40)
        Circle.physicsBody?.categoryBitMask = BladeCategory
        Circle.physicsBody?.contactTestBitMask = fruitCategory
//        Circle.physicsBody?.collisionBitMask
        Circle.physicsBody?.isDynamic = false //.physicsBody?.dynamic = true
        self.addChild(Circle)
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
    
        for touch in touches{
            
           let newTouch = touch.location(in: self)
            
            
            Circle.position = newTouch
        }
    }
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        Circle.removeFromParent()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        Circle.removeFromParent()
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
         print("Contact ocur")
        
         print("The \(contact.bodyA.node!.name!) entered in contact with the \(contact.bodyB.node!.name!)")
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        //        createPineApple()
//        print(pineAppleNode.name)
        
        
        for i in 1...7{
            
            if let rock = self.childNode(withName: "pineNode\(i)") {
            
                
                if rock.position.y <= 0 {
                    print(rock.name)
                    rock.removeFromParent()
                    
                    
                }
                
            }
            
            
            
        }
       
        
    }
    
    
}
