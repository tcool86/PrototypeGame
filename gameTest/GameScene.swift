//
//  GameScene.swift
//  gameTest
//
//  Created by Timothy Cool on 5/5/17.
//  Copyright © 2017 Timothy Cool. All rights reserved.
//

import SpriteKit
import GameplayKit
import Foundation

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
    var gameCamera : SKCameraNode = SKCameraNode()
    var stars = [Star]()
    
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
        self.playerBase?.createBase(baseHealth: 50, baseSize: 50)
        self.playerBase?.position = CGPoint(x: 100, y: 0)
        self.addChild(self.playerBase!)
    
        self.gameCamera.contains(self.player!)
        self.camera = self.gameCamera
        self.gameCamera.position = player!.position

        self.loadStars()
    }

    func loadStars() {
        guard let appDelegate = NSApplication.shared().delegate as? AppDelegate else {
            return
        }

        let managedContext = appDelegate.persistentContainer.viewContext
        let starFetch = Star.fetchRequestStar()
        managedContext.perform {
            self.stars = try! starFetch.execute()
            for star in self.stars {
                star.addStarToScene(scene: self)
            }
        }
    }
    
    func touchDown(atPoint pos : CGPoint) {
        createStar(position: pos)
    }
    
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
        self.gameCamera.position = player!.position
        
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
            let timeDiff = (distance/100) + 0.02
            if (interactionTime > TimeInterval(timeDiff)) {
                print("Distance \(distance)")
                playerBase?.reduceBaseHealth(amount: 1)
                interactionTime = 0
            }
        }
    }

    func createStar() {
        let randomPosition = self.randomPositionInUniverse()
        self.createStar(position: randomPosition)
    }

    func createStar(position:CGPoint) {
        let appDelegate = NSApplication.shared().delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let star = Star(entity: Star.entity(), insertInto: managedContext)
        star.brightness = 10 + Float(drand48()) * 65.0
        star.position = position as NSObject?
        star.power = Int64(Float(1000.00) + (Float(drand48()) * 3000.0))
        do {
            try managedContext.save()
        } catch {
            let contextError = error as NSError
            fatalError("Error: \(contextError), \(contextError.userInfo)")
        }
        appDelegate.saveContext()
        star.addStarToScene(scene: self)
    }

    func randomPositionInUniverse() -> CGPoint {
        let x = drand48() * 800
        let y = drand48() * 800
        return CGPoint(x: x, y: y)
    }

}
