//
//  GameViewController.swift
//  DrummyFingers
//
//  Created by Leyton Taylor on 10/29/20.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    var scene: GameScene?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load 'GameScene.sks' as a GKScene. This provides gameplay related content
        // including entities and graphs.
        // Present the scene
        let view = self.view as! SKView
            
        scene = GameScene(fileNamed: "GameScene")
            
        scene?.scaleMode = .aspectFit
        scene!.viewController = self
        scene?.size = CGSize(width: view.bounds.size.width, height: view.bounds.size.height)
        
        
        view.presentScene(scene)
                    
                
        
        view.ignoresSiblingOrder = true
            
        
        
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
