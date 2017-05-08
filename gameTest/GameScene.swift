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
    
    override func sceneDidLoad() {
        self.lastUpdateTime = 0
        self.player = Player.init(imageNamed: "playerPlaceholder")
        self.player?.position = CGPoint(x: 100, y: 100)
        self.addChild(self.player!)

        self.playerBase = Base.init()
        self.playerBase?.createBase(baseHealth: 50)
        self.playerBase?.position = CGPoint(x: 200, y: 300)
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
        
        self.lastUpdateTime = currentTime
    }
}
