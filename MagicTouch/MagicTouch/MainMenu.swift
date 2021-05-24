//
//  MainMenu.swift
//  MagicTouch
//
//  Created by Alumne on 23/5/21.
//

import Foundation
import GameKit

class MainMenu: SKScene, SKPhysicsContactDelegate {
    public var gameSceneController: GameViewController!
    private var playButton: SKShapeNode!
    private var playButtonText: SKLabelNode!
    private var scoreText: SKLabelNode!
    
    override func didMove(to view: SKView) {
        self.playButton = SKShapeNode(rect: CGRect(x: -150, y: -75, width: 300, height: 150))
        self.playButton.fillColor = UIColor.blue
        self.playButton.position = CGPoint(x: 0, y: 0)
        self.playButton.name = "playButton"
        self.playButton.zPosition = 1010
        self.addChild(self.playButton)
        
        self.playButtonText = SKLabelNode(fontNamed: "AvenirNext-Bold")
        self.playButtonText.text = "Play"
        self.playButtonText.name = "playButton"
        self.playButtonText.fontColor = UIColor.white
        self.playButton.addChild(self.playButtonText)
        self.playButtonText.position = CGPoint(x: 0, y: -20)
        self.playButtonText.fontSize = 60
        self.playButtonText.isUserInteractionEnabled = false
        
        self.scoreText = SKLabelNode(fontNamed: "AvenirNext-Bold")
        self.scoreText.fontColor = UIColor.white
        self.addChild(self.scoreText)
        self.scoreText.position = CGPoint(x: 0, y: self.size.height/2 - 200)
        self.scoreText.fontSize = 40
        self.scoreText.isUserInteractionEnabled = false
    }
    
    public func showScore(score: Int) {
        self.scoreText.text = "Score: " + String(score)
    }
    
    func touchDown(atPoint pos: CGPoint) {

    }

    func touchMoved(toPoint pos: CGPoint) {

    }

    func touchUp(atPoint pos: CGPoint) {

    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches {
            let node = self.atPoint(t.location(in :self))
            if (node.name == "playButton") {
                print("playButton")
                self.gameSceneController.loadScene(sceneName: "GameScene")
            }
          }
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

    }

    override func update(_ currentTime: TimeInterval) {
        
    }
}
