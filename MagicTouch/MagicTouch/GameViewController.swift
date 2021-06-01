//
//  GameViewController.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {

    public var maxScore: Int = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        loadScene(sceneName: "MainMenu")
    }

    public func loadScene(sceneName: String) {
        if let view = self.view as? SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: sceneName) {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill

                // Present the scene
                view?.presentScene(scene)
            }

            if sceneName == "GameScene" {
                if let gameSceneView = view?.scene as? GameScene? {
                    gameSceneView?.gameSceneController = self
                }
            } else if sceneName == "MainMenu" {
                if let mainMenuView = view?.scene as? MainMenu? {
                    mainMenuView?.gameSceneController = self
                    mainMenuView?.showScore()
                }
            }

            view?.ignoresSiblingOrder = true
            view?.showsFPS = true
            view?.showsNodeCount = true
        }
    }

    public func refreshScore(newScore: Int) {
        maxScore = max(maxScore, newScore)
    }

    override var shouldAutorotate: Bool {
        return false
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
