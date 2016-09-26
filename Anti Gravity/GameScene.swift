//
//  GameScene.swift
//  Anti Gravity
//
//  Created by Etienne Köhler on 18/06/16.
//  Copyright (c) 2016 Moseby Inc. All rights reserved.
//

import SpriteKit
import UIKit
import AVFoundation


//--- Game Physics
struct PhysicsCatagory {
    static let ball    : UInt32 = 0x1 << 1
    static let ball2   : UInt32 = 0x1 << 1
    static let edge1   : UInt32 = 0x1 << 2
    static let edge2   : UInt32 = 0x1 << 2
    static let wallAr  : UInt32 = 0x1 << 2
    static let wallBr  : UInt32 = 0x1 << 2
    static let wallAl  : UInt32 = 0x1 << 2
    static let wallBl  : UInt32 = 0x1 << 2
    static let score   : UInt32 = 0x1 << 4
    static let fallBall   : UInt32 = 0x1 << 2
    static let ballBar   : UInt32 = 0x1 << 4
    static let topNode   : UInt32 = 0x1 << 2



}


//--- Game Top Level
class GameScene: SKScene, SKPhysicsContactDelegate {
    
    //Game Variables
    var ball    = SKShapeNode()
    var ball2   = SKShapeNode()
    var edge1   = SKSpriteNode()
    var edge2   = SKSpriteNode()
    var circle  = SKSpriteNode()
    var wallAr  = SKShapeNode()
    var wallBr  = SKShapeNode()
    var wallAl  = SKShapeNode()
    var wallBl  = SKShapeNode()
    var fallBall = SKShapeNode()
    var ballBar = SKShapeNode()
    var scoreWall  = SKShapeNode()
    var highscoreWall  = SKShapeNode()
    var wallPairRight  = SKNode()
    var wallPairLeft   = SKNode()
    var wallChompRight   = SKNode()
    var wallChompLeft   = SKNode()
    var moveAndRemoveRight = SKAction()
    var moveAndRemoveLeft  = SKAction()
    var moveAndRemoveChompRight = SKAction()
    var moveAndRemoveChompLeft  = SKAction()
    var restartBTN = SKSpriteNode()
    var resetBTN = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var endScoreLbl = SKLabelNode()
    var endScoreLbl2 = SKLabelNode()
    var endScoreLbl3 = SKLabelNode()
    var endScoreLbl4 = SKLabelNode()
    var gameLabel = SKSpriteNode()
    var gameLabel2 = SKSpriteNode()
    //var play    = SKSpriteNode()
    var playBTN = SKShapeNode()
    var pauseBTN = SKSpriteNode()
    var pauseBTNPic = SKSpriteNode()
    var noAd = SKSpriteNode()
    var noAdBTN = SKSpriteNode()
    //let crashSound  = NSURL(fileURLWithPath: (NSBundle.mainBundle().pathForResource("thePointSound", ofType: "mp3"))!)
    var touchPlayer = AVAudioPlayer()
    var pointPlayer = AVAudioPlayer()
    var deathPlayer = AVAudioPlayer()
    var trackPlayer = AVAudioPlayer()
    var buttonPlayer = AVAudioPlayer()

    var error: NSError?
    var playState = -1

    //--- playState ---
    //-1: home
    // 0: set
    // 1: play
    // 2: dead
    // 3: restart
    // 4: pause
    // 5: settings
    // 6: ads
    //-----------------
    
    var ball_dir = 4.5                                  // ball direction (-1,1)
    var ximpulse = 0.0                                  // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var ximpMore = 0.0                                  // impulse increases with score by    e.g. 20  [kg m/s]
    var yimpulse = 0.0                                  // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var yimpMore = 0.0                                  // impulse increases with score by    e.g. 20  [kg m/s]
    var xvelocity = 0.0                                 // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var yvelocity = -120.0                              // impulse increases with score by    e.g. 20  [kg m/s]
    var xgravity = 1.0                                  // gravity of ball when mouse click   e.g. 2 [m/s2]
    var ygravity = 3.0                                  // gravity of ball when mouse click   e.g. 2 [m/s2]
    var restartDelay = 0.0                              // delay for restart button to appear e.g. 3 [s]
    var restartSleep = UInt32(0)                        // wait after restart button created  e.g. 3 [s]
    var xwallPos1:CGFloat  = 755.0 //755.0              // position of left wall  e.g. 800
    var xwallPos2:CGFloat  = 300.0 //270.0              // position of right wall e.g. 225
    var xwallShift:CGFloat = -150.0// -50.0             // shift wall to see more of incoming red wall
    var xwallMove:CGFloat  = 100.0                      // move walls in xdir e.g. 200
    var xwallMoveI:CGFloat = 100.0
    var velocityWall = CGFloat(150)                     // wall speed e.g. 120
    let delayWalls   = SKAction.wait(forDuration: 3.0)  // time new walls (s)
    var wallDir1           = 1                          // initial wall speed direction
    var wallDir            = 1                          // initial wall speed direction
    var widthBallbarIni    = 420                        // length of fall ball bar (ini)
    var widthBallbar       = 420                        // length of fall ball bar
    

    //var gravityBehavior: UtapIGravityBehavior?
    var gravityDirection = CGVector(dx: 0,dy: 0)          // gravity: normal (0,-9.8)
    
    //var gravityX:CGFloat = 6
    //let impulseY:CGFloat = 4.0
    //let impulseX:CGFloat = 10.0
    
    // color schemes
    var greyWhite      = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    var scoreNodeColor = UIColor.clear
    var white      = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    var purple     = UIColor(red: 200/255, green: 200/255, blue: 255/255, alpha: 1.0)
    var red     = UIColor(red: 200/256, green: 40/256,  blue:  40/256, alpha: 1.0)
    var darkGrey     = UIColor(red:  73/255, green: 73/255,  blue:  73/255, alpha: 1.0)
    var lightGrey     = UIColor(red: 0.7569, green: 0.7569, blue: 0.7569, alpha: 1.0) /* #c1c1c1 */


    var score    = Int()
    var highscore = Int()
    
    let scoreLbl = SKLabelNode()
    //let tap      = SKLabelNode()
 
    
    
//--- Start the game
    override func didMove(to view: SKView) {
  
        backgroundColor = greyWhite
        homeScene()
        self.physicsWorld.gravity = gravityDirection
        
        let HighscoreDefault = UserDefaults.standard
        if(HighscoreDefault.value(forKey: "highscore") != nil) {
            highscore = HighscoreDefault.value(forKey: "highscore") as! NSInteger!
        
        
        }

        //--- Sounds
        
        let touchSound:URL = Bundle.main.url(forResource: "touchSoundOfficial2.0", withExtension: "mp3")!
        let pointSound:URL = Bundle.main.url(forResource: "pointSoundOfficial2.0", withExtension: "mp3")!
        let deathSound:URL = Bundle.main.url(forResource: "deathSoundOfficial", withExtension: "mp3")!
        let soundTrack:URL = Bundle.main.url(forResource: "trackSound", withExtension: "mp3")!
        //let buttonTrack:NSURL = NSBundle.mainBundle().URLForResource("buttonSound", withExtension: "mp3")!

        do
        {
            touchPlayer = try AVAudioPlayer(contentsOf: touchSound, fileTypeHint: nil)
            pointPlayer = try AVAudioPlayer(contentsOf: pointSound, fileTypeHint: nil)
            deathPlayer = try AVAudioPlayer(contentsOf: deathSound, fileTypeHint: nil)
            trackPlayer = try AVAudioPlayer(contentsOf: soundTrack, fileTypeHint: nil)
            buttonPlayer = try AVAudioPlayer(contentsOf: soundTrack, fileTypeHint: nil)
        }
        catch let error as NSError { print(error.description) }
        
        //audioPlayer.numberOfLoops = 0
        trackPlayer.numberOfLoops = -1
        
        touchPlayer.volume = 0.07
        pointPlayer.volume = 0.3
        deathPlayer.volume = 0.4
        trackPlayer.volume = 0.17

        touchPlayer.prepareToPlay()
        pointPlayer.prepareToPlay()
        deathPlayer.prepareToPlay()
        trackPlayer.prepareToPlay()
        
        trackPlayer.play()

        
//--- Slider
        let mySlider = UISlider(frame:CGRect(x: 10, y: 500, width: 300, height: 20))  // x, y, width, height
        mySlider.minimumValue = 0
        mySlider.maximumValue = 100
        mySlider.isContinuous = true
        mySlider.tintColor = UIColor.green
        mySlider.addTarget(self, action: #selector(GameScene.sliderValueDidChange(_:)), for: .valueChanged)
        
        //self.view!.addSubview(mySlider)
    
    }
    
    
//--- Slider value
    func sliderValueDidChange(_ sender:UISlider!)
    {
        print("Slider value changed")
        
        // Use this code below only if you want UISlider to snap to values step by step
        //let roundedStepValue = round(sender.value / step) * step
        //sender.value = roundedStepValue
        
        print("Slider step value \(Int(sender.value))")
        self.velocityWall = CGFloat(sender.value)*3
    }
    
    
//--- Restart the game
    func restartScene(){
        
        removeAllChildren()
        removeAllActions()
        score = 0
        ball_dir = 5
        
        physicsWorld.gravity = CGVector(dx: 0,dy: 0)              // switch gravity off
        
        createScene()

    }
    
    
//--- Create Scene: edges, ball, score=0
    //func createScene(ball: SKShapeNode) {
    func createScene() {
        
        self.physicsWorld.contactDelegate = self

        //edge on the left
        edge1 = SKSpriteNode(imageNamed: "bar")
        edge1.setScale(0.5)
        edge1.size = CGSize(width: 10, height: 1000)
        edge1.position = CGPoint(x: self.frame.width * 0.29, y: edge1.frame.height * 0.4)
        edge1.physicsBody = SKPhysicsBody(rectangleOf: edge1.size)
        edge1.physicsBody?.affectedByGravity = true
        edge1.physicsBody?.isDynamic = false
        //edge1.zPosition = 3
        self.addChild(edge1)    //make edge1
        
        //edge on the right
        edge2 = SKSpriteNode(imageNamed: "bar")
        edge2.setScale(0.5)
        edge2.size = CGSize(width: 10, height: 1000)
        edge2.position = CGPoint(x: self.frame.width * 0.71, y: edge2.frame.height * 0.4)
        edge2.physicsBody = SKPhysicsBody(rectangleOf: edge2.size)
        edge2.physicsBody?.affectedByGravity = true
        edge2.physicsBody?.isDynamic = false
        //edge2.zPosition = 3
        self.addChild(edge2)    //make edge2
        
        //shape to define ball
        
        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path   = CGMutablePath()
        
        path.move(to: CGPoint(x: center.x + 25, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y + 25))
        path.addLine(to: CGPoint(x: center.x - 25, y: center.y))
        path.addLine(to: CGPoint(x: center.x, y: center.y - 25))

        path.closeSubpath()
        ball = SKShapeNode(path: path)
        ball.strokeColor = red
        ball.lineWidth = 6
        ball.fillColor =  greyWhite

        ball.physicsBody = SKPhysicsBody(polygonFrom: path)

        ball.physicsBody?.isDynamic            = true
        ball.physicsBody?.affectedByGravity  = true
        ball.physicsBody?.mass               = 1
        ball.physicsBody?.friction           = 0.0
        ball.physicsBody?.linearDamping      = 0.0
        ball.physicsBody?.restitution        = 0.3                           // ball: bounciness (0,1)
        ball.physicsBody?.categoryBitMask    = PhysicsCatagory.ball
        ball.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.wallAr | PhysicsCatagory.wallBr | PhysicsCatagory.wallAl | PhysicsCatagory.wallBl
        ball.physicsBody?.contactTestBitMask = PhysicsCatagory.wallAr | PhysicsCatagory.wallBr | PhysicsCatagory.wallAl | PhysicsCatagory.wallBl | PhysicsCatagory.score
        ball.physicsBody!.usesPreciseCollisionDetection = true
        ball.physicsBody?.velocity = CGVector(dx: ximpulse / 2.0 , dy: 0)            // ball: initial velocity [m/s]
        ball.zPosition = 3
        
        self.addChild(ball)
        
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.5)
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "GillSans-UltraBold"
        scoreLbl.zPosition = 4
        scoreLbl.fontColor = darkGrey
        scoreLbl.fontSize = 60

        
        self.addChild(scoreLbl)
        createPauseBtn()
        
        let topNode = SKSpriteNode()
        topNode.size = CGSize(width: 850, height:3)
        topNode.position = CGPoint(x:self.frame.width/2, y:self.frame.height)
        topNode.physicsBody = SKPhysicsBody(rectangleOf: topNode.size)
        topNode.physicsBody?.affectedByGravity = false
        topNode.physicsBody?.isDynamic = false
        topNode.physicsBody?.categoryBitMask    = PhysicsCatagory.topNode
        topNode.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        topNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        topNode.color = SKColor.clear
        self.addChild(topNode)

    }

    
//--- home
    func homeScene(){
        
        backgroundColor = greyWhite
        
        //play label
        let center5 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path5   = CGMutablePath()
        
        path5.move(to: CGPoint(x: center5.x - 40, y: center5.y + 70))
        path5.addLine(to: CGPoint(x: center5.x - 40, y: center5.y - 30))
        path5.addLine(to: CGPoint(x: center5.x + 40, y: center5.y + 20))
        
        path5.closeSubpath()
        playBTN = SKShapeNode(path: path5)
        playBTN.strokeColor = red
        playBTN.lineWidth = 8
        playBTN.fillColor   = greyWhite
        playBTN.physicsBody = SKPhysicsBody(polygonFrom: path5)
        playBTN.physicsBody?.isDynamic = false
        self.addChild(playBTN)
        
        //title
        gameLabel = SKSpriteNode(imageNamed: "swiftPic")
        gameLabel.setScale(0.2)
        gameLabel.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-120)
        gameLabel.zPosition = 5
        self.addChild(gameLabel)
        
        //no Ads
        noAd = SKSpriteNode(imageNamed: "ads")
        noAd.setScale(0.5)
        noAd.position = CGPoint(x: self.frame.width / 2 + 100 , y:self.frame.height-550)
        noAd.zPosition = 5
        self.addChild(noAd)
        
        //no Ads Button
        noAdBTN = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 110, height: 100))
        noAdBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 577)
        noAdBTN.zPosition = 4
        self.addChild(self.noAdBTN)


        
        
    }
    
    // create the no ads scene
    func createNoAds() {
    
    
    }
    
    func createGameLabel() {
    //title
    gameLabel2 = SKSpriteNode(imageNamed: "swiftPic")
    gameLabel2.setScale(0.2)
    gameLabel2.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-120)
    gameLabel2.zPosition = 5
    self.addChild(gameLabel2)
    }


//--- ballBar forming the fallBall
    func createBallBar() {
    
        let ballBar = SKSpriteNode()
        ballBar.size = CGSize(width: widthBallbar, height:8)
        ballBar.position = CGPoint(x:self.frame.width/2, y:self.frame.height-4)
        ballBar.physicsBody = SKPhysicsBody(rectangleOf: ballBar.size)
        ballBar.physicsBody?.affectedByGravity = false
        ballBar.physicsBody?.isDynamic = false
        ballBar.color = darkGrey
        ballBar.physicsBody?.categoryBitMask    = PhysicsCatagory.ballBar
        ballBar.physicsBody?.collisionBitMask = 0
        widthBallbar -= 5
        widthBallbar = max(widthBallbar,0)
        
        print("ballbar: ", widthBallbar)
        
        self.ballBar.removeFromParent()
        self.addChild(ballBar)
    
    }
 
    
//--- create button
    func createBTN(){
        
        delay(restartDelay) {
        self.restartBTN = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 110, height: 100))
        self.restartBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 577)
        self.restartBTN.zPosition = 4
        self.addChild(self.restartBTN)
            
            
            self.resetBTN = SKSpriteNode(imageNamed: "Reset-Button")
            self.resetBTN.setScale(0.5)
            self.resetBTN.size = CGSize(width: 110, height: 100)
            self.resetBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 577)
            self.resetBTN.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN.size)
            self.resetBTN.physicsBody?.affectedByGravity = true
            self.resetBTN.physicsBody?.isDynamic = false
            self.resetBTN.zPosition = 7
            self.addChild(self.resetBTN)
        }
    }
    
//--- pause Button
    
    func createPauseBtn(){
    
        self.pauseBTN = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 50, height: 50))
        self.pauseBTN.position = CGPoint(x: self.frame.width - 340, y: self.frame.height - 40)
        self.pauseBTN.zPosition = 4
        self.addChild(self.pauseBTN)
        
        self.pauseBTNPic = SKSpriteNode(imageNamed: "pause")
        self.pauseBTNPic.size = CGSize(width: 50, height: 50)
        self.pauseBTNPic.position = CGPoint(x: self.frame.width - 340, y: self.frame.height  - 40)
        self.pauseBTNPic.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN.size)
        self.pauseBTNPic.physicsBody?.affectedByGravity = true
        self.pauseBTNPic.physicsBody?.isDynamic = false
        self.pauseBTNPic.zPosition = 7
        //self.addChild(self.pauseBTNPic)

    
    }
//--- end score
    func endScore(){
    
            if (score > highscore) {
                highscore = score
            }
        
            removeAllChildren()
        
            var HighscoreDefault = UserDefaults.standard
            HighscoreDefault.setValue(highscore, forKey: "highscore")
            HighscoreDefault.synchronize()
        

            self.endScoreLbl = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl.text       = "Score"
            self.endScoreLbl.fontSize   = 45
            self.endScoreLbl.fontColor = self.greyWhite
            self.endScoreLbl.horizontalAlignmentMode = .center
            self.endScoreLbl.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-270)
            self.endScoreLbl.zPosition = 5
            self.addChild(self.endScoreLbl)
            
            self.endScoreLbl2 = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl2.text       = String(self.score)
            self.endScoreLbl2.fontSize   = 45
            self.endScoreLbl2.fontColor = self.red
            self.endScoreLbl2.horizontalAlignmentMode = .center
            self.endScoreLbl2.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-320)
            self.endScoreLbl2.zPosition = 5
            self.addChild(self.endScoreLbl2)
        
            self.endScoreLbl3 = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl3.text       = "Highscore"
            self.endScoreLbl3.fontSize   = 45
            self.endScoreLbl3.fontColor = self.greyWhite
            self.endScoreLbl3.horizontalAlignmentMode = .center
            self.endScoreLbl3.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-420)
            self.endScoreLbl3.zPosition = 5
            self.addChild(self.endScoreLbl3)
        
            self.endScoreLbl4 = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl4.text       = String(self.highscore)
            self.endScoreLbl4.fontSize   = 45
            self.endScoreLbl4.fontColor = self.darkGrey
            self.endScoreLbl4.horizontalAlignmentMode = .center
            self.endScoreLbl4.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-470)
            self.endScoreLbl4.zPosition = 5
            self.addChild(self.endScoreLbl4)
        
            //wall behind score
            let center6 = CGPoint(x: self.frame.midX, y: self.frame.midY)
            let path6   = CGMutablePath()
        
            path6.move(to: CGPoint(x: center6.x + 150, y: center6.y))
            path6.addLine(to: CGPoint(x: center6.x + 125, y: center6.y + 25))
            path6.addLine(to: CGPoint(x: center6.x - 1000, y: center6.y + 25))
            path6.addLine(to: CGPoint(x: center6.x - 1000, y: center6.y - 25))
            path6.addLine(to: CGPoint(x: center6.x + 125, y: center6.y - 25))

            path6.closeSubpath()
            scoreWall = SKShapeNode(path: path6)
            scoreWall.strokeColor = red
            scoreWall.fillColor   = red
            scoreWall.position    = CGPoint(x: self.frame.width - 1000, y:self.frame.height-638)
            scoreWall.physicsBody = SKPhysicsBody(polygonFrom: path6)
            scoreWall.zPosition = 3
            scoreWall.physicsBody?.isDynamic            = false
            scoreWall.physicsBody?.affectedByGravity  = false


            self.addChild(self.scoreWall)

        
        //wall behind highscore
        let center7 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path7   = CGMutablePath()
        
        path7.move(to: CGPoint(x: center7.x - 100, y: center7.y))
        path7.addLine(to: CGPoint(x: center7.x - 125, y: center7.y + 25))
        path7.addLine(to: CGPoint(x: center7.x + 1000, y: center7.y + 25))
        path7.addLine(to: CGPoint(x: center7.x + 1000, y: center7.y - 25))
        path7.addLine(to: CGPoint(x: center7.x - 125, y: center7.y - 25))
        
        path7.closeSubpath()
        highscoreWall = SKShapeNode(path: path7)
        highscoreWall.strokeColor = darkGrey
        highscoreWall.fillColor   = darkGrey
        highscoreWall.position    = CGPoint(x: self.frame.width - 1080, y:self.frame.height-790)
        highscoreWall.physicsBody = SKPhysicsBody(polygonFrom: path7)
        highscoreWall.zPosition = 3
        highscoreWall.physicsBody?.isDynamic            = false
        highscoreWall.physicsBody?.affectedByGravity  = false

        
        self.addChild(self.highscoreWall)
        self.playState = 3
    
    }
    
//--- Create walls right ---->
    
    func createWallsRight(){
        
        wallPairRight = SKNode()
        wallPairRight.name = "wallPairRight"
        
        wallPairLeft = SKNode()
        wallPairLeft.name = "wallPairLeft"
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 850, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = scoreNodeColor

        
        
        //Ar: Left wall moving right  |=>
        
        let center1 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path1   = CGMutablePath()
        
        path1.move(to: CGPoint(x: center1.x + 150, y: center1.y))
        path1.addLine(to: CGPoint(x: center1.x + 125,  y: center1.y + 25))
        path1.addLine(to: CGPoint(x: center1.x - 1000, y: center1.y + 25))
        path1.addLine(to: CGPoint(x: center1.x - 1000, y: center1.y - 25))
        path1.addLine(to: CGPoint(x: center1.x + 125,  y: center1.y - 25))


        path1.closeSubpath()
        wallAr = SKShapeNode(path: path1)
        wallAr.strokeColor = red
        wallAr.fillColor   = red
        wallAr.position    = CGPoint(x: self.frame.width/2  - xwallPos1 + xwallShift + 30, y:frame.height-383)
        wallAr.physicsBody = SKPhysicsBody(polygonFrom: path1)
        wallAr.physicsBody?.affectedByGravity = false
        wallAr.physicsBody?.isDynamic = false
        wallAr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallAr
        wallAr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallAr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallAr.zPosition = 3
        
        //Br: Right wall moving right  >=|
        
        let center2 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path2   = CGMutablePath()
        
        path2.move(to: CGPoint(x: center2.x - 100, y: center2.y))
        path2.addLine(to: CGPoint(x: center2.x - 125,  y: center2.y + 25))
        path2.addLine(to: CGPoint(x: center2.x + 1000, y: center2.y + 25))
        path2.addLine(to: CGPoint(x: center2.x + 1000, y: center2.y - 25))
        path2.addLine(to: CGPoint(x: center2.x - 125,  y: center2.y - 25))
        
      //CGPathCloseSubpath(path2)
        wallBr = SKShapeNode(path: path2)
        wallBr.strokeColor = darkGrey
        wallBr.fillColor   = darkGrey
        wallBr.position    = CGPoint(x: self.frame.width  - xwallPos1 + xwallShift - 30, y:frame.height-383)
        wallBr.physicsBody = SKPhysicsBody(polygonFrom: path2)
        wallBr.physicsBody?.affectedByGravity = false
        wallBr.physicsBody?.isDynamic = false
        wallBr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallBr
        wallBr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallBr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallBr.zPosition = 3
        
        wallPairRight.addChild(wallAr)
        wallPairRight.addChild(wallBr)
        wallPairRight.addChild(scoreNode)
        wallPairRight.run(moveAndRemoveRight)
        
        self.addChild(wallPairRight)
    }
  
    
    //--- Create walls left <---------
    
    func createWallsLeft(){
        
        wallPairLeft = SKNode()
        wallPairLeft.name = "wallPairLeft"
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 850, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = scoreNodeColor
        
        //Al: Right wall moving left  <=|
        
        let center3 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path3   = CGMutablePath()
        
        path3.move(to: CGPoint(x: center3.x - 150, y: center3.y))
        path3.addLine(to: CGPoint(x: center3.x - 125,  y: center3.y + 25))
        path3.addLine(to: CGPoint(x: center3.x + 1000, y: center3.y + 25))
        path3.addLine(to: CGPoint(x: center3.x + 1000, y: center3.y - 25))
        path3.addLine(to: CGPoint(x: center3.x - 125,  y: center3.y - 25))
        
        path3.closeSubpath()
        wallAl = SKShapeNode(path: path3)
        wallAl.strokeColor = red
        wallAl.fillColor   = red
        wallAl.position    = CGPoint(x: self.frame.width  - xwallPos1 - xwallShift - 30, y:frame.height-383)
        wallAl.physicsBody = SKPhysicsBody(polygonFrom: path3)
        wallAl.physicsBody?.affectedByGravity = false
        wallAl.physicsBody?.isDynamic = false
        wallAl.physicsBody?.categoryBitMask    = PhysicsCatagory.wallAl
        wallAl.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallAl.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallAl.zPosition = 3
        
        //Bl: Left wall moving left  |=<
        
        let center4 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path4   = CGMutablePath()
        
        path4.move(to: CGPoint(x: center4.x + 100, y: center4.y))
        path4.addLine(to: CGPoint(x: center4.x + 125,  y: center4.y + 25))
        path4.addLine(to: CGPoint(x: center4.x - 1000, y: center4.y + 25))
        path4.addLine(to: CGPoint(x: center4.x - 1000, y: center4.y - 25))
        path4.addLine(to: CGPoint(x: center4.x + 125,  y: center4.y - 25))

        path4.closeSubpath()
        wallBl = SKShapeNode(path: path4)
        wallBl.strokeColor = darkGrey
        wallBl.fillColor   = darkGrey
        wallBl.position    = CGPoint(x: self.frame.width/2  - xwallPos1 - xwallShift + 30, y:frame.height-383)
        wallBl.physicsBody = SKPhysicsBody(polygonFrom: path4)
        wallBl.physicsBody?.affectedByGravity = false
        wallBl.physicsBody?.isDynamic = false
        wallBl.physicsBody?.categoryBitMask    = PhysicsCatagory.wallBl
        wallBl.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallBl.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallBl.zPosition = 3
        
        wallPairLeft.addChild(wallAl)
        wallPairLeft.addChild(wallBl)
        wallPairLeft.addChild(scoreNode)
        wallPairLeft.run(moveAndRemoveLeft)
        
        self.addChild(wallPairLeft)
    }
    
    //--- Create chomp wall that is moving right =====>   ( <===== )

    func createWallChompRight(){
        
        wallChompRight = SKNode()
        wallChompRight.name = "wallChompRight"
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 850, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = scoreNodeColor
        
        
        
        //Ar: Left wall moving right  |=>
        
        let center1 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path1   = CGMutablePath()
        
        path1.move(to: CGPoint(x: center1.x + 150, y: center1.y))
        path1.addLine(to: CGPoint(x: center1.x + 125,  y: center1.y + 25))
        path1.addLine(to: CGPoint(x: center1.x - 1000, y: center1.y + 25))
        path1.addLine(to: CGPoint(x: center1.x - 1000, y: center1.y - 25))
        path1.addLine(to: CGPoint(x: center1.x + 125,  y: center1.y - 25))
        
        
        path1.closeSubpath()
        wallAr = SKShapeNode(path: path1)
        wallAr.strokeColor = red
        wallAr.fillColor   = red
        wallAr.position    = CGPoint(x: self.frame.width/2  - 700, y:frame.height-383)
        wallAr.physicsBody = SKPhysicsBody(polygonFrom: path1)
        wallAr.physicsBody?.affectedByGravity = false
        wallAr.physicsBody?.isDynamic = false
        wallAr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallAr
        wallAr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallAr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallAr.zPosition = 3
        
        
        wallChompRight.addChild(wallAr)
        wallChompRight.addChild(scoreNode)
        wallChompRight.run(moveAndRemoveChompRight)
        
        self.addChild(wallChompRight)
    }
    
    //--- Create chomp wall that is moving left ( =====> )    <=====
    
    func createWallChompLeft(){
        
        wallChompLeft = SKNode()
        wallChompLeft.name = "wallChompLeft"
        
        
        //Br: Right wall moving left  >=|
        
        let center2 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path2   = CGMutablePath()
        
        path2.move(to: CGPoint(x: center2.x - 100, y: center2.y))
        path2.addLine(to: CGPoint(x: center2.x - 125,  y: center2.y + 25))
        path2.addLine(to: CGPoint(x: center2.x + 1000, y: center2.y + 25))
        path2.addLine(to: CGPoint(x: center2.x + 1000, y: center2.y - 25))
        path2.addLine(to: CGPoint(x: center2.x - 125,  y: center2.y - 25))
        
        //CGPathCloseSubpath(path2)
        wallBr = SKShapeNode(path: path2)
        wallBr.strokeColor = darkGrey
        wallBr.fillColor   = darkGrey
        wallBr.position    = CGPoint(x: self.frame.width / 2 - 400, y:frame.height-383)
        wallBr.physicsBody = SKPhysicsBody(polygonFrom: path2)
        wallBr.physicsBody?.affectedByGravity = false
        wallBr.physicsBody?.isDynamic = false
        wallBr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallBr
        wallBr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallBr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallBr.zPosition = 3
        
        wallChompLeft.addChild(wallBr)
        wallChompLeft.run(moveAndRemoveChompLeft)
        
        self.addChild(wallChompLeft)
    }


    //obstacle
    func obstacle() {
    
        fallBall = SKShapeNode(circleOfRadius: 30)
        fallBall.strokeColor = darkGrey
        fallBall.fillColor   = darkGrey
        fallBall.physicsBody?.mass = 100
        fallBall.position    = CGPoint(x: self.frame.width/2, y:frame.height)
        fallBall.physicsBody = SKPhysicsBody(circleOfRadius: 30)
        fallBall.physicsBody?.affectedByGravity = false
        fallBall.physicsBody?.isDynamic = true
        fallBall.physicsBody?.categoryBitMask    = PhysicsCatagory.fallBall
        fallBall.physicsBody?.collisionBitMask   = PhysicsCatagory.ball 
        fallBall.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        fallBall.physicsBody?.velocity           = CGVector(dx: 0 , dy: -300)
        fallBall.zPosition = 3

        widthBallbar = widthBallbarIni
        self.addChild(fallBall)
    
    }


//--- Mouse Click
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */

        print("Mouse Click: ",playState, ball_dir)

        // state -1: home ----------------------
        if playState == -1 {
            for touch in touches{
                let location = touch.location(in: self)
                
                if playBTN.contains(location){
                    playState = 0
                    playBTN.removeFromParent()
                    gameLabel.removeFromParent()
                    noAd.removeFromParent()
                    noAdBTN.removeFromParent()
                    createScene()
                }
                
                if noAdBTN.contains(location){
                    playState = 6
                    playBTN.removeFromParent()
                    gameLabel.removeFromParent()
                    noAd.removeFromParent()
                    noAdBTN.removeFromParent()
                    
                
                
                }
            }
        }
        
        // state 0: Set ----------------------
        if playState == 0 {
            backgroundColor = greyWhite
            let spawnWallsRight = SKAction.run({
                () in
                self.createWallsRight()
            })
            
            let spawnWallsLeft = SKAction.run({
                () in
                self.createWallsLeft()
            })
            
            let spawnWallsChomp = SKAction.run({
                () in
                self.createWallChompLeft()
                self.createWallChompRight()
            })
            
            let spawnFallBall = SKAction.run({
                () in
                self.obstacle()
            })

            
            var ballBarTimer = Timer.scheduledTimer(timeInterval: 0.2, target: self, selector: #selector(GameScene.createBallBar), userInfo: nil, repeats: true)
            wallDir = wallDir1
            
            // move walls down (called in functions createWallsRight and Left)
            
            let distanceWall = CGFloat(self.frame.width + wallPairRight.frame.width)
            
            // right walls
            let moveWallRight        = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove, y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallRight      = SKAction.removeFromParent()
            moveAndRemoveRight       = SKAction.sequence([moveWallRight, removeWallRight])
            
            // left walls
            let moveWallLeft         = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove * (-1), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallLeft       = SKAction.removeFromParent()
            moveAndRemoveLeft        = SKAction.sequence([moveWallLeft, removeWallLeft])
            
            // chomp wall right
            let moveWallChompRight   = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove * (-0.5), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallChompRight = SKAction.removeFromParent()
            moveAndRemoveChompRight  = SKAction.sequence([moveWallChompRight, removeWallChompRight])
            
            // chomp wall left
            let moveWallChompLeft    = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove * (0.5), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallChompLeft  = SKAction.removeFromParent()
            moveAndRemoveChompLeft   = SKAction.sequence([moveWallChompLeft, removeWallChompLeft])
            
            // sequence of making new walls (and fallBall)
            let spawnDelay           = SKAction.sequence([spawnWallsRight, delayWalls, spawnFallBall, spawnWallsLeft, delayWalls, spawnWallsChomp, delayWalls])
            let spawnDelayForever    = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            xwallMoveI       = xwallMove
            
            playState = 1

            print("Create walls, game started",playState)

        }
        
        // state 1: Play ----------------------
        if playState == 1 {
            
            ball_dir = ball_dir * (-1.0)

            ball.physicsBody?.velocity = CGVector(dx: ball_dir*xvelocity, dy: yvelocity)            // ball: initial velocity [m/s]
            
            //ball.physicsBody?.applyImpulse(CGVectorMake(CGFloat(ball_dir*(ximpulse+Double(score)*ximpMore)),
            //                                            CGFloat(          yimpulse+Double(score)*yimpMore))) // add impulse

            self.physicsWorld.gravity = CGVector(dx: CGFloat(ball_dir*xgravity), dy: CGFloat(ygravity))   // switch gravity
            
            touchPlayer.play()
            
            print("Press Ball Impulse: ",playState)
            
            
            // change wall speed
            
            if score >= 2 {
                xwallMoveI = xwallMoveI * (1.05)
            }
            
            print("xwallMove ------------------", score, xwallMoveI, wallDir, ball_dir)
            
            //touch pause button
            for touch in touches{
                let location = touch.location(in: self)
                
                if pauseBTN.contains(location){
                    playState = 4
                    removeAllChildren()
                    removeAllActions()
                    homeScene()
                
                }
            }
            


        }
        
        // state 2: Dead ----------------------
        if playState == 2 {
            //ball.physicsBody?.affectedByGravity = true
        }

        // state 3: Restart screen: Touch button to restart ----------------------
        if playState == 3 {
            for touch in touches{
                let location = touch.location(in: self)
            
                if restartBTN.contains(location){
                    print("Press Restart Button: ", playState)
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    self.addChild(gameLabel)
                    playState = 0
                }
            }
        }
    }

    
//--- Collision: contact between ball and walls
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody  = contact.bodyA
        let secondBody = contact.bodyB
        
        if (playState == 1) {
        
        
        if firstBody.categoryBitMask == PhysicsCatagory.score && secondBody.categoryBitMask == PhysicsCatagory.ball{
            score  += 1
            wallDir = wallDir * (-1)
            print("Score1: ", score, wallDir)
            scoreLbl.text = "\(score)"
            //firstBody.node?.removeFromParent()
            pointPlayer.play()
            
        }
        else if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.score {
            score  += 1
            wallDir = wallDir * (-1)
            print("Score2: ", score, wallDir)
            scoreLbl.text = "\(score)"
            //secondBody.node?.removeFromParent()
            pointPlayer.play()
        }
        else if firstBody.categoryBitMask == PhysicsCatagory.ball
            && secondBody.categoryBitMask == PhysicsCatagory.wallAr
            ||  firstBody.categoryBitMask == PhysicsCatagory.wallAr
            && secondBody.categoryBitMask == PhysicsCatagory.ball
            ||  firstBody.categoryBitMask == PhysicsCatagory.ball
            && secondBody.categoryBitMask == PhysicsCatagory.wallBr
            ||  firstBody.categoryBitMask == PhysicsCatagory.wallBr
            && secondBody.categoryBitMask == PhysicsCatagory.ball
            ||  firstBody.categoryBitMask == PhysicsCatagory.ball
            && secondBody.categoryBitMask == PhysicsCatagory.wallAl
            ||  firstBody.categoryBitMask == PhysicsCatagory.wallAl
            && secondBody.categoryBitMask == PhysicsCatagory.ball
            ||  firstBody.categoryBitMask == PhysicsCatagory.ball
            && secondBody.categoryBitMask == PhysicsCatagory.wallBl
            ||  firstBody.categoryBitMask == PhysicsCatagory.wallBl
            && secondBody.categoryBitMask == PhysicsCatagory.ball
            ||  firstBody.categoryBitMask == PhysicsCatagory.ball
            && secondBody.categoryBitMask == PhysicsCatagory.fallBall
            ||  firstBody.categoryBitMask == PhysicsCatagory.fallBall
            && secondBody.categoryBitMask == PhysicsCatagory.ball
            ||  firstBody.categoryBitMask == PhysicsCatagory.ball
            && secondBody.categoryBitMask == PhysicsCatagory.topNode
            ||  firstBody.categoryBitMask == PhysicsCatagory.topNode
            && secondBody.categoryBitMask == PhysicsCatagory.ball
                                                                    {
            
        
            playState = 2
            print("Collision with wall")
            
            deathPlayer.play()
            
            //ball.physicsBody?.affectedByGravity = true
                
            self.physicsWorld.gravity = CGVector(dx: CGFloat(0), dy: CGFloat(-3))     // switch gravity: fall down on collision
                
            enumerateChildNodes(withName: "wallPairRight", using: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            })
            
            enumerateChildNodes(withName: "wallPairLeft", using: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            })
                                                                        
            enumerateChildNodes(withName: "wallChompRight", using: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            })
                                                                
            enumerateChildNodes(withName: "wallChompLeft", using: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            })


            
  
                                                                        
            
            delay(1){
                //self.removeAllChildren()
                self.wallPairRight.removeFromParent()
                self.wallPairLeft.removeFromParent()
                self.createBTN()
                self.endScore()
                self.createGameLabel()
                                                                        }
            }}

}
    

//--- Delay [s]
    func delay(_ delay: Double, closure: @escaping ()->()) {
        DispatchQueue.main.asyncAfter(
            deadline: DispatchTime.now() + Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC),
            execute: closure
        )
    }
    
    
//--- Update
    override func update(_ currentTime: TimeInterval) {
        
           }
}
