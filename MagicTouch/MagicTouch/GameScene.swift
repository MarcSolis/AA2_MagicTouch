//
//  GameScene.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import SpriteKit
import GameplayKit
import CoreMotion

class GameScene: SKScene, SKPhysicsContactDelegate {

    private var gameModel: GameModel!
    //debug buttons
    private var button0: SKShapeNode!
    private var button1: SKShapeNode!
    private var button2: SKShapeNode!
    private var button3: SKShapeNode!
    private var button4: SKShapeNode!

    
    override func didMove(to view: SKView) {
        let buttonHeight = Int(-self.size.height/2 + 250)
        self.button0 = SKShapeNode(circleOfRadius: 50)
        self.button0.fillColor = UIColor.blue
        self.button0.position = CGPoint(x: Int(-self.size.width/6*2), y: buttonHeight)
        self.button0.name = "Button0"
        self.button0.zPosition = 1010
        self.addChild(self.button0)
        
        self.button1 = SKShapeNode(circleOfRadius: 50)
        self.button1.fillColor = UIColor.red
        self.button1.position = CGPoint(x: Int(-self.size.width/6*1), y: buttonHeight)
        self.button1.name = "Button1"
        self.button1.zPosition = 1010
        self.addChild(self.button1)
        
        self.button2 = SKShapeNode(circleOfRadius: 50)
        self.button2.fillColor = UIColor.green
        self.button2.position = CGPoint(x: Int(-self.size.width/6*0), y: buttonHeight)
        self.button2.name = "Button2"
        self.button2.zPosition = 1010
        self.addChild(self.button2)
        
        self.button3 = SKShapeNode(circleOfRadius: 50)
        self.button3.fillColor = UIColor.yellow
        self.button3.position = CGPoint(x: Int(self.size.width/6*1), y: buttonHeight)
        self.button3.name = "Button3"
        self.button3.zPosition = 1010
        self.addChild(self.button3)
        
        self.button4 = SKShapeNode(circleOfRadius: 50)
        self.button4.fillColor = UIColor.purple
        self.button4.position = CGPoint(x: Int(self.size.width/6*2), y: buttonHeight)
        self.button4.name = "Button4"
        self.button4.zPosition = 1010
        self.addChild(self.button4)
        
        self.physicsWorld.contactDelegate = self
        
        self.gameModel = GameModel(matchTime: 0, screenSize: self.size, context: self)
        let screenRatio = (self.size.width + self.size.height) * 0.1
        
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            self.gameModel.enemyPool.append(
                EnemyViewModel(
                    size: CGSize(width: screenRatio, height: screenRatio),
                    position: self.gameModel.disableEnemyPosition, disabledPosition: gameModel.disableEnemyPosition
                )
            )
            self.gameModel.enemyPool[index].addAsChild(context: self)
        }
        
        self.gameModel.enemyPool[getReusableEnemyIndex()].reuse(initialPos: self.gameModel.spawnEnemyPosition)
    }
    
    func getReusableEnemyIndex() -> Int {
        var selectedIndex = -1
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            if (!self.gameModel.enemyPool[index].model.active) {
                selectedIndex = index
            }
        }
        return selectedIndex
    }
    
    func destroyBaloons(id: Int){
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            if (self.gameModel.enemyPool[index].model.active) {
                self.gameModel.enemyPool[index].destroyBallons(id: id)
            }
        }
    }
    
    func endGame(){
        
    }
    
    func didBegin(_ contact: SKPhysicsContact) {
        if(contact.bodyA.node?.name == "Ground" &&
            contact.bodyB.node?.name == "Enemy") {
            endGame()
        }
        
        if(contact.bodyA.node?.name == "Enemy" &&
            contact.bodyB.node?.name == "Ground") {
            endGame()
        }
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
            if (node.name == "Button0") {
                print("Button0")
                destroyBaloons(id: 0)
            }
            else if (node.name == "Button1") {
                print("Button1")
                destroyBaloons(id: 1)
            }
            else if (node.name == "Button2") {
                print("Button2")
                destroyBaloons(id: 2)
            }
            else if (node.name == "Button3") {
                print("Button3")
                destroyBaloons(id: 3)
            }
            else if (node.name == "Button4") {
                print("Button4")
                destroyBaloons(id: 4)
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
        // Called before each frame is rendered
    }
}
