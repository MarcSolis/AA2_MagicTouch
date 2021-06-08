//
//  GameScene.swift
//  MagicTouch
//
//  Created by Alumne on 6/5/21.
//

import SpriteKit
import GameplayKit
import CoreMotion
import Vision
import CoreML

class GameScene: SKScene, SKPhysicsContactDelegate {

    private var gameModel: GameModel!
    public var gameSceneController: GameViewController!
    private var button0: SKShapeNode!
    private var button1: SKShapeNode!
    private var button2: SKShapeNode!
    private var button3: SKShapeNode!
    private var button4: SKShapeNode!
    private var score: SKLabelNode!
    private var multiplierText: SKLabelNode!

    override func didMove(to view: SKView) {

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

        initScore()
        initMultiplier()
        initTimer()
    }

    func initScore() {
        self.score = SKLabelNode(fontNamed: "AvenirNext-Bold")
        self.score.text = ("Score: " + String(self.gameModel.score))
        self.score.position = CGPoint(x: 0, y: self.size.height/2 - 200)
        self.score.zPosition = 2000
        self.score.fontColor = UIColor.black
        self.addChild(self.score)
    }

    func initMultiplier() {
        self.multiplierText = SKLabelNode(fontNamed: "AvenirNext-Bold")
        self.multiplierText.text = "x" + String(1)
        self.multiplierText.position = CGPoint(x: 200, y: self.size.height/2 - 400)
        self.multiplierText.zPosition = 2000
        self.multiplierText.fontColor = UIColor.white
        self.addChild(self.multiplierText)
    }

    func initTimer() {
        let increaseTimeAction = SKAction.run {
            self.gameModel.time += self.gameModel.timeRefreshRate
        }
        let waitForTimeAction = SKAction.wait(forDuration: TimeInterval(self.gameModel.timeRefreshRate))
        let timerActionGroup = SKAction.group([increaseTimeAction, waitForTimeAction])
        let runTimerAction = SKAction.repeatForever(timerActionGroup)
        run(runTimerAction, withKey: "TimerAction")
    }

    func getReusableEnemyIndex() -> Int {
        var selectedIndex = 0
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            if !self.gameModel.enemyPool[index].model.active {
                selectedIndex = index
            }
        }
        return selectedIndex
    }

    func destroyBaloons(identifier: Int) {
        var simultaneousEnemiesKilled: Int = 0
        var accumulatedExtraScore: Int = 0
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            if self.gameModel.enemyPool[index].model.active {
                let extraScore = self.gameModel.enemyPool[index].destroyBallons(identifier: identifier)
                if extraScore > 0 {
                    simultaneousEnemiesKilled += 1
                    accumulatedExtraScore += extraScore
                }
            }
        }
        if accumulatedExtraScore > 1 {
            self.multiplierText.text = "x" + String(simultaneousEnemiesKilled)
        }
        accumulatedExtraScore *= simultaneousEnemiesKilled
        self.gameModel.score += accumulatedExtraScore
    }

    func endGame() {
        gameSceneController.refreshScore(newScore: gameModel.score)
        gameSceneController.loadScene(sceneName: "MainMenu")
    }

    func updateScore() {
        self.score.text = "Score: " + String(self.gameModel.score)
    }

    func didBegin(_ contact: SKPhysicsContact) {
        if contact.bodyA.node?.name == "Ground" &&
            contact.bodyB.node?.name == "Enemy" {
            endGame()
        }

        if contact.bodyA.node?.name == "Enemy" &&
            contact.bodyB.node?.name == "Ground" {
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
        for touch in touches {
            let node = self.atPoint(touch.location(in: self))
            if node.name == "Button0" {
                print("Button0")
                destroyBaloons(identifier: 0)
                updateScore()
            } else if node.name == "Button1" {
                print("Button1")
                destroyBaloons(identifier: 1)
                updateScore()
            } else if node.name == "Button2" {
                print("Button2")
                destroyBaloons(identifier: 2)
                updateScore()
            } else if node.name == "Button3" {
                print("Button3")
                destroyBaloons(identifier: 3)
                updateScore()
            } else if node.name == "Button4" {
                print("Button4")
                destroyBaloons(identifier: 4)
                updateScore()
            } else {
                self.gameModel.strokePoints = []
                self.gameModel.bezierPath = UIBezierPath()
                self.gameModel.bezierPath.move(to: touch.location(in: self))
            }
          }
    }

    func pathTest() {
        let freeform = UIBezierPath()
        freeform.move(to: .zero)
        freeform.addLine(to: CGPoint(x: 100, y: 100))
        freeform.addLine(to: CGPoint(x: 50, y: 100))
        freeform.addLine(to: CGPoint(x: 100, y: 0))
        let image = renderPath(path: freeform, size: CGSize(width: 610, height: 610))

        let myNode = SKSpriteNode(texture: SKTexture(image: image!))
        myNode.zPosition = 2020
        self.addChild(myNode)

        UIColor.green.setStroke()
        freeform.lineWidth = 10
        freeform.stroke()
        let freeformNode = SKShapeNode(path: freeform.cgPath)
        freeformNode.zPosition = 2021
        freeformNode.strokeColor = UIColor.green
        freeformNode.lineWidth = 10

        self.addChild(freeformNode)
    }

    func renderPath(path: UIBezierPath, size: CGSize) -> UIImage? {
        return UIGraphicsImageRenderer(size: size).image { _ in
            UIColor.black.setStroke()
            path.lineWidth = 10
            path.stroke()
        }
    }

    func resizeImage(image: UIImage, newWidth: CGFloat) -> UIImage? {
        let newHeight = newWidth
        UIGraphicsBeginImageContext(CGSize(width: newWidth, height: newHeight))
        image.draw(in: CGRect(x: 0, y: 0, width: newWidth, height: newHeight))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }

    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for touch in touches {
            self.gameModel.bezierPath.addLine(to: touch.location(in: self))
        }

        UIColor.black.setStroke()
        self.gameModel.bezierPath.lineWidth = 10
        self.gameModel.bezierPath.stroke()

        self.gameModel.freeformNode.removeFromParent()
        self.gameModel.freeformNode = SKShapeNode(path: self.gameModel.bezierPath.cgPath)

        self.gameModel.freeformNode.zPosition = 2020
        self.gameModel.freeformNode.strokeColor = UIColor.green
        self.gameModel.freeformNode.lineWidth = 10
        self.addChild(self.gameModel.freeformNode)

    }
    var textNode: SKLabelNode!
    var myNode: SKSpriteNode!

    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        var image = UIImage.shapeImageWithBezierPath(
            bezierPath: self.gameModel.bezierPath, fillColor: .clear, strokeColor: .white, strokeWidth: 40
        )

        image = resizeImage(image: image!, newWidth: CGFloat(28))

        self.gameModel.freeformNode.removeFromParent()
        self.gameModel.bezierPath = UIBezierPath()

        var recognizedNumber = -1

        let model = MNISTClassifier()
        do {
            let input = try MNISTClassifierInput(imageWith: image!.cgImage!)
            let result = try model.prediction(input: input)
            recognizedNumber = Int(result.classLabel)
            print(_: result)
        } catch {
            recognizedNumber = -1
        }

        if recognizedNumber < 0 {return}

        destroyBaloons(identifier: recognizedNumber)
        updateScore()
    }

    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {

        let image = renderPath(path: self.gameModel.bezierPath, size: self.size)

        let myNode = SKSpriteNode(texture: SKTexture(image: image!))
        myNode.zPosition = 2020
        self.addChild(myNode)

        self.gameModel.freeformNode.removeFromParent()
        self.gameModel.bezierPath = UIBezierPath()
    }

    override func update(_ currentTime: TimeInterval) {
        let newVelocity = CGVector.sum(
            value1: self.gameModel.enemyStartSpeed,
            value2: CGVector(dx: 0, dy: -CGFloat(self.gameModel.time * self.gameModel.increaseSpeedByTimeMuttiplier))
        )
        (0...self.gameModel.enemyPoolSize).forEach { (index) in
            if self.gameModel.enemyPool[index].model.active {
                self.gameModel.enemyPool[index].updateSpeed(velocity: newVelocity)
            }
        }
        if self.gameModel.time - self.gameModel.lastSpawnedTime >= self.gameModel.spawnInterval {
            let horizontalVariation = Float.random(in: 0...Float(self.size.width/1.5)) - Float(self.size.width/1.5)/2
            self.gameModel.enemyPool[getReusableEnemyIndex()].reuse(
                initialPos: CGPoint(
                    x: CGFloat(horizontalVariation) + self.gameModel.spawnEnemyPosition.x,
                    y: self.gameModel.spawnEnemyPosition.y
                ),
                velocity: newVelocity
            )
            self.gameModel.lastSpawnedTime = self.gameModel.time
            self.gameModel.spawnInterval = Float.random(in: 2...5)
        }
    }
}
