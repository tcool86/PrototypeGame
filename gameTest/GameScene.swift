//
//  GameScene.swift
//  gameTest
//
//  Created by Timothy Cool on 5/5/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import SpriteKit
import GameplayKit

enum KeyPressed : UInt16 {
    case up    = 126
    case down  = 125
    case left  = 123
    case right = 124
    case space = 49
}

class GameScene: SKScene {
    
    var entities = [GKEntity]()
    var graphs = [String : GKGraph]()
    
    private var lastUpdateTime : TimeInterval = 0
    private var player : Player?
    private var playerBase : Base?
    private var interactionTime : TimeInterval = 0
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        self.player = Player.init(imageNamed: "playerPlaceholder")
        self.player?.position = CGPoint(x: 100, y: 100)
        self.addChild(self.player!)

        self.playerBase = Base.init()
        self.playerBase?.createBase(baseHealth: 50)
        self.playerBase?.position = CGPoint(x: 100, y: 0)
        self.addChild(self.playerBase!)
    }
    
    func touchDown(atPoint pos : CGPoint) {}
    
    func touchMoved(toPoint pos : CGPoint) {}
    
    func touchUp(atPoint pos : CGPoint) {}
    
    override func mouseDown(with event: NSEvent) {
        self.touchDown(atPoint: event.location(in: self))
    }
    
    override func mouseDragged(with event: NSEvent) {
        self.touchMoved(toPoint: event.location(in: self))
    }
    
    override func mouseUp(with event: NSEvent) {
        self.touchUp(atPoint: event.location(in: self))
    }
    
    override func keyDown(with event: NSEvent) {
        switch event.keyCode {
        case KeyPressed.up.rawValue:
            self.player?.fly(direction: .up)
        case KeyPressed.down.rawValue:
            self.player?.fly(direction: .down)
        case KeyPressed.left.rawValue:
            self.player?.fly(direction: .left)
        case KeyPressed.right.rawValue:
            self.player?.fly(direction: .right)
        case KeyPressed.space.rawValue:
            self.player?.special()

            default:
                print("keyDown: \(event.characters!) keyCode: \(event.keyCode)")
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        // Initialize _lastUpdateTime if it has not already been
        if (self.lastUpdateTime == 0) {
            self.lastUpdateTime = currentTime
        }
        
        // Calculate time since last update
        let dt = currentTime - self.lastUpdateTime
        
        // Update entities
        for entity in self.entities {
            entity.update(deltaTime: dt)
        }
        handleBasePlayer(dt)
        
        self.lastUpdateTime = currentTime
    }
    
    func handleBasePlayer(_ currentTime: TimeInterval) {
        let playerPosition : CGPoint = (player?.position)!
        let basePosition : CGPoint = (playerBase?.position)!
        let baseSize : CGSize = CGSize(width: 300, height: 300)
        let baseHitBox : CGRect = CGRect(x: basePosition.x - baseSize.width/2,
                                         y: basePosition.y - baseSize.height/2,
                                         width: baseSize.width,
                                         height: baseSize.height)
        
        if (baseHitBox.contains(playerPosition)) {
            interactionTime += currentTime
            let distance = hypotf(Float(playerPosition.x - basePosition.x),
                                  Float(playerPosition.y - basePosition.y))
            let timeDiff = (distance/100) + 0.1
            if (interactionTime > TimeInterval(timeDiff)) {
                print("Distance \(distance)")
                playerBase?.reduceBaseHealth(amount: 1)
                interactionTime = 0
            }
        }
    }
}
