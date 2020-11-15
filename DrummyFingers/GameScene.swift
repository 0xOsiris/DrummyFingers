//
//  GameScene.swift
//  DrummyFingers
//
//  Created by Leyton Taylor on 10/29/20.
//

import SpriteKit
import GameplayKit


//Declaration of Physics Categories
struct PhysicsCategory {
    static let None : UInt32 = 0
    static let Ball : UInt32 = 0x1 << 1
    static let Panel : UInt32 = 0x1 << 2
}


class GameScene: SKScene, SKPhysicsContactDelegate {
    var viewController: GameViewController!
    //GameScene Background
    var bgMain = SKSpriteNode()
    var ballPair = SKNode()
    //GameScene Buttons
    var rButton = SKSpriteNode()
    var pButton = SKSpriteNode()
    var yButton = SKSpriteNode()
    var bButton = SKSpriteNode()
    
    //GameScene Panels
    var rPanel = SKSpriteNode()
    var pPanel = SKSpriteNode()
    var yPanel = SKSpriteNode()
    var bPanel = SKSpriteNode()
    
    var blueEmitter = SKEmitterNode()
    var purpleEmitter = SKEmitterNode()
    var yellowEmitter = SKEmitterNode()
    var redEmitter = SKEmitterNode()
    
    override func didMove(to view: SKView){
        createScene()
    }
    
    func createScene() {
        
        
        //Initialization of Background for GameScene
//        bgMain = SKSpriteNode(imageNamed: "drummyMain")
//
//        bgMain.size.height = self.frame.size.height
//        bgMain.size.width = self.frame.size.width
//        bgMain.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
//        bgMain.zPosition = 2
        
        self.physicsWorld.contactDelegate = self
        self.physicsWorld.gravity = CGVector(dx: 0, dy: -7)
        
        
        blueEmitter = SKEmitterNode(fileNamed: "BluePart")!
        blueEmitter.zPosition = 3
        blueEmitter.isHidden = true
        purpleEmitter = SKEmitterNode(fileNamed: "PurpPart")!
        purpleEmitter.zPosition = 3
        purpleEmitter.isHidden = true
        redEmitter = SKEmitterNode(fileNamed: "RedPart")!
        redEmitter.zPosition = 3
        redEmitter.isHidden = true
        yellowEmitter = SKEmitterNode(fileNamed: "YelPart")!
        yellowEmitter.zPosition = 3
        yellowEmitter.isHidden = true
        //Initialization of rypb Buttons for GameScene
        pButton = SKSpriteNode(imageNamed: "buttonP")
        
        pButton.size.height = self.frame.size.width / 4
        pButton.size.width = self.frame.size.width / 4
        pButton.position = CGPoint(x: 0 + pButton.size.width / 2, y: 0 + pButton.size.height / 2)
        pButton.zPosition = 3
        
        rButton = SKSpriteNode(imageNamed: "buttonR")
        
        rButton.size.height = self.frame.size.width / 4
        rButton.size.width = self.frame.size.width / 4
        rButton.position = CGPoint(x: 0 + rButton.size.width + rButton.size.width / 2, y: 0 + rButton.size.height / 2)
        rButton.zPosition = 3
        
        yButton = SKSpriteNode(imageNamed: "buttonY")
        
        yButton.size.height = self.frame.size.width / 4
        yButton.size.width = self.frame.size.width / 4
        yButton.position = CGPoint(x: 0 + yButton.size.width * 2 + yButton.size.width / 2, y: 0 + yButton.size.height / 2)
        yButton.zPosition = 3
        
        bButton = SKSpriteNode(imageNamed: "buttonB")
        
        bButton.size.height = self.frame.size.width / 4
        bButton.size.width = self.frame.size.width / 4
        bButton.position = CGPoint(x: 0 + bButton.size.width * 3 + bButton.size.width / 2, y: 0 + bButton.size.height / 2)
        bButton.zPosition = 3
        
        //Initialize rypb Panels for GameScene
        pPanel = SKSpriteNode(imageNamed: "panelP")
        pPanel.size.height = self.frame.size.width / 16
        pPanel.size.width = self.frame.size.width / 4
        pPanel.position = CGPoint(x: 0 + pPanel.size.width / 2, y: 0 + pPanel.size.height + pButton.size.height)
        
        pPanel.zPosition = 3
        
        rPanel = SKSpriteNode(imageNamed: "panelR")
        rPanel.size.height = self.frame.size.width / 16
        rPanel.size.width = self.frame.size.width / 4
        rPanel.position = CGPoint(x: 0 + rPanel.size.width + rPanel.size.width / 2, y: 0 + rPanel.size.height + rButton.size.height)
        
        rPanel.zPosition = 3
        
        yPanel = SKSpriteNode(imageNamed: "panelY")
        yPanel.size.height = self.frame.size.width / 16
        yPanel.size.width = self.frame.size.width / 4
        yPanel.position = CGPoint(x: 0 + yPanel.size.width * 2 + yPanel.size.width / 2, y: 0 + yPanel.size.height + yButton.size.height)
        
        yPanel.zPosition = 3
        
        bPanel = SKSpriteNode(imageNamed: "panelB")
        bPanel.size.height = self.frame.size.width / 16
        bPanel.size.width = self.frame.size.width / 4
        bPanel.position = CGPoint(x: 0 + bPanel.size.width * 3 + bPanel.size.width / 2, y: 0 + bPanel.size.height + bButton.size.height)
        
        bPanel.zPosition = 3
        
        //Add all children to self
        self.addChild(bgMain)
        self.addChild(bPanel)
        self.addChild(pPanel)
        self.addChild(yPanel)
        self.addChild(rPanel)
        self.addChild(rButton)
        self.addChild(bButton)
        self.addChild(yButton)
        self.addChild(pButton)
        self.addChild(redEmitter)
        self.addChild(blueEmitter)
        self.addChild(yellowEmitter)
        self.addChild(purpleEmitter)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
       
        for touch in touches{
            
            let location = touch.location(in: self)
            var randInt = Int32.random(in: 0..<4)
            
            switch randInt{
                case 0:
                    spawnRedBall()
                case 1:
                    spawnBlueBall()
                case 2:
                    spawnPurpleBall()
                case 3:
                    spawnYellowBall()
                    
            default:
                break
            }
            
            if rButton.contains(_:location) {
                if rPanel.texture != SKTexture(imageNamed: "panelrF") {
                    rPanel.texture = SKTexture(imageNamed: "panelrF")
                    //Change physics to collide with ball
                    rPanel.physicsBody = SKPhysicsBody(rectangleOf: pPanel.size)

                    rPanel.physicsBody?.categoryBitMask = PhysicsCategory.Panel
                    rPanel.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                    rPanel.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                    rPanel.physicsBody?.affectedByGravity = false
                    rPanel.physicsBody?.isDynamic = false
                    
                    
                    pPanel.texture = SKTexture(imageNamed: "panelP")
                    pPanel.physicsBody = nil
                    
                    
                    yPanel.texture = SKTexture(imageNamed: "panelY")
                    yPanel.physicsBody = nil
                    
                    
                    bPanel.texture = SKTexture(imageNamed: "panelB")
                    bPanel.physicsBody = nil
                }
            }else if pButton.contains(_:location) {
                if pPanel.texture != SKTexture(imageNamed: "panelpF") {
                    pPanel.texture = SKTexture(imageNamed: "panelpF")
                    
                    //Change physics to collide with ball
                    pPanel.physicsBody = SKPhysicsBody(rectangleOf: pPanel.size)

                    pPanel.physicsBody?.categoryBitMask = PhysicsCategory.Panel
                    pPanel.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                    pPanel.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                    pPanel.physicsBody?.affectedByGravity = false
                    pPanel.physicsBody?.isDynamic = false
                    
                    rPanel.texture = SKTexture(imageNamed: "panelR")
                    rPanel.physicsBody = nil
                    
                    yPanel.texture = SKTexture(imageNamed: "panelY")
                    yPanel.physicsBody = nil
                    
                    bPanel.texture = SKTexture(imageNamed: "panelB")
                    bPanel.physicsBody = nil
                }
            }else if yButton.contains(_:location) {
                if yPanel.texture != SKTexture(imageNamed: "panelyF") {
                    yPanel.texture = SKTexture(imageNamed: "panelyF")
                    //Change physics to collide with ball
                    yPanel.physicsBody = SKPhysicsBody(rectangleOf: pPanel.size)

                    yPanel.physicsBody?.categoryBitMask = PhysicsCategory.Panel
                    yPanel.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                    yPanel.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                    yPanel.physicsBody?.affectedByGravity = false
                    yPanel.physicsBody?.isDynamic = false
                    
                    pPanel.texture = SKTexture(imageNamed: "panelP")
                    pPanel.physicsBody = nil
                    
                    rPanel.texture = SKTexture(imageNamed: "panelR")
                    rPanel.physicsBody = nil
                    
                    bPanel.texture = SKTexture(imageNamed: "panelB")
                    bPanel.physicsBody = nil
                }
            }else if bButton.contains(_:location) {
                if bPanel.texture != SKTexture(imageNamed: "panelbF") {
                    bPanel.texture = SKTexture(imageNamed: "panelbF")
                    //Change physics to collide with ball
                    bPanel.physicsBody = SKPhysicsBody(rectangleOf: pPanel.size)

                    bPanel.physicsBody?.categoryBitMask = PhysicsCategory.Panel
                    bPanel.physicsBody?.collisionBitMask = PhysicsCategory.Ball
                    bPanel.physicsBody?.contactTestBitMask = PhysicsCategory.Ball
                    bPanel.physicsBody?.affectedByGravity = false
                    bPanel.physicsBody?.isDynamic = false
                    
                    pPanel.texture = SKTexture(imageNamed: "panelP")
                    pPanel.physicsBody = nil
                    
                    yPanel.texture = SKTexture(imageNamed: "panelY")
                    yPanel.physicsBody = nil
                    
                    rPanel.texture = SKTexture(imageNamed: "panelR")
                    rPanel.physicsBody = nil
                }
            }
        }
        
        
    }
    
    //Contanct method between panel and ball
    func didBegin(_ contact: SKPhysicsContact) {
            var rybpInt = UInt32()
        
            var firstBody = contact.bodyA
            var secondBody = contact.bodyB
                
            if firstBody.categoryBitMask == PhysicsCategory.Panel && secondBody.categoryBitMask == PhysicsCategory.Ball || firstBody.categoryBitMask == PhysicsCategory.Ball && secondBody.categoryBitMask == PhysicsCategory.Panel{
                
                    if (firstBody.node?.name == "blue" || secondBody.node?.name == "blue"){
                        
                        if(firstBody.node?.name == "blue"){
                            firstBody.node?.removeFromParent()
                        }else{
                            secondBody.node?.removeFromParent()
                        }
                        
                        blueEmitter.position = CGPoint(x: bPanel.position.x, y: bPanel.position.y + bPanel.size.height / 2)
                        blueEmitter.numParticlesToEmit = 25
                            
                        blueEmitter.isHidden = false
                        
                        blueEmitter.resetSimulation()
                    }
                    else if (firstBody.node?.name == "purple" || secondBody.node?.name == "purple"){
                        
                        if(firstBody.node?.name == "blue"){
                            firstBody.node?.removeFromParent()
                        }else{
                            secondBody.node?.removeFromParent()
                        }
                        
                        purpleEmitter.position = CGPoint(x: pPanel.position.x, y: bPanel.position.y + bPanel.size.height / 2)
                        purpleEmitter.numParticlesToEmit = 25
                        
                        purpleEmitter.isHidden = false
                        purpleEmitter.resetSimulation()
                    }else if (firstBody.node?.name == "red" || secondBody.node?.name == "red") {
                        
                        if(firstBody.node?.name == "blue"){
                            firstBody.node?.removeFromParent()
                        }else{
                            secondBody.node?.removeFromParent()
                        }
                        
                        redEmitter.position = CGPoint(x: rPanel.position.x, y: bPanel.position.y + bPanel.size.height / 2)
                        redEmitter.numParticlesToEmit = 25
                        
                        redEmitter.isHidden = false
                        redEmitter.resetSimulation()
                    }else if (firstBody.node?.name == "yellow" || secondBody.node?.name == "yellow"){
                        
                        if(firstBody.node?.name == "blue"){
                            firstBody.node?.removeFromParent()
                        }else{
                            secondBody.node?.removeFromParent()
                        }
                        
                        yellowEmitter.position = CGPoint(x: yPanel.position.x, y: bPanel.position.y + bPanel.size.height / 2)
                        yellowEmitter.numParticlesToEmit = 25
                        
                        yellowEmitter.isHidden = false
                        yellowEmitter.resetSimulation()
                    }
                    
                    
                
                    
                    
                    
            
            
        }
    }
    func spawnPurpleBall(){
        
        var ball = SKSpriteNode()
        
        
        
        
        
        ball = SKSpriteNode(imageNamed: "ballP")
        ball.position = CGPoint(x: self.frame.size.width, y: self.frame.size.height - self.frame.size.height / 4)
        
        
        ball.size = CGSize(width: self.frame.size.width / 16, height: self.frame.size.width / 16)
        
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.height / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Panel
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Panel
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.name = "purple"
        self.addChild(ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -3.25, dy: 6.9))
        

    }
    
    func spawnYellowBall(){
        
        var ball = SKSpriteNode()
        
        
        ball = SKSpriteNode(imageNamed: "ballY")
        ball.position = CGPoint(x: 0, y: self.frame.size.height - self.frame.size.height / 4)
        
        ball.size = CGSize(width: self.frame.size.width / 16, height: self.frame.size.width / 16)
        
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.height / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Panel
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Panel
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.name = "yellow"
        self.addChild(ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 2.315, dy: 6.9))
    
        
        
    }
    func spawnBlueBall(){
        
        var ball = SKSpriteNode()
        
        
        
        ball = SKSpriteNode(imageNamed: "ballB")
        ball.position = CGPoint(x: 0, y: self.frame.size.height - self.frame.size.height / 4)
        
        ball.size = CGSize(width: self.frame.size.width / 16, height: self.frame.size.width / 16)
        
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.height / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Panel
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Panel
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.name = "blue"
        
        self.addChild(ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: 3.25, dy: 6.9))
    
        
        
    }

    func spawnRedBall(){
        
        var ball = SKSpriteNode()
        
       
        
        
        ball = SKSpriteNode(imageNamed: "ballR")
        ball.position = CGPoint(x: self.frame.size.width, y: self.frame.size.height - self.frame.size.height / 4)
        
        ball.size = CGSize(width: self.frame.size.width / 16, height: self.frame.size.width / 16)
        
        
        ball.physicsBody = SKPhysicsBody(circleOfRadius: ball.frame.size.height / 2)
        ball.physicsBody?.categoryBitMask = PhysicsCategory.Ball
        ball.physicsBody?.collisionBitMask = PhysicsCategory.Panel
        ball.physicsBody?.contactTestBitMask = PhysicsCategory.Panel
        ball.physicsBody?.affectedByGravity = true
        ball.physicsBody?.isDynamic = true
        ball.name = "red"
        self.addChild(ball)
        
        ball.physicsBody?.applyImpulse(CGVector(dx: -2.315, dy: 6.9))
    
    }
    
    override func update(_ currentTime: TimeInterval) {
        
        
    }
}
