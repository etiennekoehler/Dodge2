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
import SceneKit

//--- Game Physics

struct PhysicsCatagory {
    static let ball             : UInt32 = 0x1 << 1  // 2
    static let edge1            : UInt32 = 0x1 << 2  // 4
    static let edge2            : UInt32 = 0x1 << 2
    static let wallAr           : UInt32 = 0x1 << 3  // 8
    static let wallBr           : UInt32 = 0x1 << 3
    static let wallAl           : UInt32 = 0x1 << 3
    static let wallBl           : UInt32 = 0x1 << 3
    static let score            : UInt32 = 0x1 << 4  //  16
    static let topNode          : UInt32 = 0x1 << 5  //  32
    static let islandRight      : UInt32 = 0x1 << 6  //  64
    static let islandLeft       : UInt32 = 0x1 << 7  // 128
    static let islandRight2     : UInt32 = 0x1 << 8  // 256
    static let islandLeft2      : UInt32 = 0x1 << 9  // 512
    static let smallWallRight   : UInt32 = 0x1 << 10 // 1024
    static let smallWallLeft    : UInt32 = 0x1 << 11 // 2048
    static let star1            : UInt32 = 0x1 << 12 // 4096
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
    var island  = SKShapeNode()
    var smallWallRight  = SKShapeNode()
    var smallWallLeft   = SKShapeNode()
    var fallBall        = SKShapeNode()
    var ballBar         = SKShapeNode()
    var scoreWall       = SKShapeNode()
    var highscoreWall   = SKShapeNode()
    var diamond         = SKShapeNode()
    var wallPairRight   = SKNode()
    var wallPairLeft    = SKNode()
    var wallChompRight  = SKNode()
    var wallChompLeft   = SKNode()
    var wallIslandLeft  = SKNode()
    var wallIslandLeft2 = SKNode()
    var wallIslandRight = SKNode()
    var wallIslandRight2 = SKNode()
    var outsideWalls    = SKNode()
    var star    = SKNode()
    var star1   = SKSpriteNode()
    var star2   = SKNode()
    var moveAndRemoveRight       = SKAction()
    var moveAndRemoveLeft        = SKAction()
    var moveAndRemoveChompRight  = SKAction()
    var moveAndRemoveChompLeft   = SKAction()
    var moveAndRemoveIslandLeft  = SKAction()
    var moveAndRemoveIslandRight = SKAction()
    var moveAndRemoveOutsideWall = SKAction()
    var moveAndRemoveStar        = SKAction()
    var restartBTN   = SKSpriteNode()
    var resetBTN     = SKSpriteNode()
    var restartBTN2   = SKSpriteNode()
    var resetBTN2    = SKSpriteNode()
    var homeBTN      = SKSpriteNode()
    var homeBTNPic   = SKSpriteNode()
    var endScoreLbl  = SKLabelNode()
    var endScoreLbl2 = SKLabelNode()
    var endScoreLbl3 = SKLabelNode()
    var endScoreLbl4 = SKLabelNode()
    var gameLabel    = SKSpriteNode()
    var gameLabel2   = SKSpriteNode()
    //var play       = SKSpriteNode()
    var playBTN      = SKSpriteNode()
    var playBTN2     = SKSpriteNode()
    var rateBTN      = SKSpriteNode()
    var rateBTN2     = SKSpriteNode()
    var musicBTN     = SKSpriteNode()
    var musicBTN2    = SKSpriteNode()
    var homeBTN1     = SKSpriteNode()
    var homeBTN2     = SKSpriteNode()
    var pauseBTN     = SKSpriteNode()
    var pauseBTNPic  = SKSpriteNode()
    var noAd         = SKSpriteNode()
    var noAdBTN      = SKSpriteNode()
    //let crashSound = NSURL(fileURLWithPath: (NSBundle.mainBundle().pathForResource("thePointSound", ofType: "mp3"))!)
    var touchPlayer  = AVAudioPlayer()
    var pointPlayer  = AVAudioPlayer()
    var deathPlayer  = AVAudioPlayer()
    var trackPlayer  = AVAudioPlayer()
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
    
    var ball_dir        = 5.0                                  // ball direction (-1,1)
    var ximpulse        = 0.0                                  // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var ximpMore        = 0.0                                  // impulse increases with score by    e.g. 20  [kg m/s]
    var yimpulse        = 0.0                                  // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var yimpMore        = 0.0                                  // impulse increases with score by    e.g. 20  [kg m/s]
    var xvelocity       = 0.0                                  // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var yvelocity       = -120.0                               // impulse increases with score by    e.g. 20  [kg m/s]
    var xgravity        = 1.0                                  // gravity of ball when mouse click   e.g. 2 [m/s2]
    var ygravity        = 3.0                                  // gravity of ball when mouse click   e.g. 2 [m/s2]
//  var xgravity        = 0.1                                  // simple option
//  var ygravity        = 1.0                                  // simple option
    var islandAcc       = 3.0                                  // acceleration of island
    var restartDelay    = 0.0                                  // delay for restart button to appear e.g. 3 [s]
    var restartSleep    = UInt32(0)                            // wait after restart button created  e.g. 3 [s]
    var velocityWall    = CGFloat(100)                         // wall y-speed
    var iRan            = 1
    let delayWalls      = SKAction.wait(forDuration: 3.0)      // time new walls (s)                 e.g. 3.0 [s]
    let delayHalf       = SKAction.wait(forDuration: 1.5)      // time for stars                     e.g. 1.5 [s]
    var wallDir1        = 1                                    // initial wall speed direction
    var wallDir         = 1                                    // initial wall speed direction
    var widthBallbarIni = 420                                  // length of fall ball bar (ini)
    var widthBallbar    = 420                                  // length of fall ball bar
    var islandVar       = 0.8
    var islandPosLeft   = 600
    var islandPosRight  = 450
    var ballColor       = 1
    var starVar         = CGFloat(-100)
    var xwallPos1:CGFloat  = 755.0 //755.0                     // position of left wall  e.g. 800
    var xwallPos2:CGFloat  = 300.0 //270.0                     // position of right wall e.g. 225
    var xwallShift:CGFloat = -150.0// -50.0                    // shift wall to see more of incoming red wall
    var xwallMoveI:CGFloat = 100.0
    var xwallMove          = [CGFloat(50.0), CGFloat(250.0)]   // move walls x-speed
    var gravityDirection = CGVector(dx: 0,dy: 0)               // gravity: normal (0,-9.8)
    var length = [50, 75]
    var Xran = Int()
    //var length = Int()
    
   // color schemes
    
    var greyWhite      = UIColor(red: 252/255, green: 252/255, blue: 247/255, alpha: 1.0)
    var scoreNodeColor = UIColor.clear
    var white          = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    var purple         = UIColor(red: 200/255, green: 200/255, blue: 255/255, alpha: 1.0)
    var red            = UIColor(red: 248/256, green: 73/256,  blue:  52/256, alpha: 1.0)//200 40 40
    var darkGrey       = UIColor(red:  77/255, green: 94/255,  blue:  95/255, alpha: 1.0) //65 65 65
    var lightGrey      = UIColor(red: 0.7569,  green: 0.7569,  blue: 0.7569,  alpha: 1.0)    /* #c1c1c1 */

    var score     = Int()
    var highscore = Int()
    var starCount = Int()
    
    let scoreLbl = SKLabelNode()
    let starLbl  = SKLabelNode()
 

//--- Start the game

    override func didMove(to view: SKView) {
  
        backgroundColor = greyWhite
        homeScene()
        
        self.physicsWorld.gravity = gravityDirection
        
        let HighscoreDefault = UserDefaults.standard
        if (HighscoreDefault.value(forKey: "highscore") != nil) {
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
            touchPlayer  = try AVAudioPlayer(contentsOf: touchSound, fileTypeHint: nil)
            pointPlayer  = try AVAudioPlayer(contentsOf: pointSound, fileTypeHint: nil)
            deathPlayer  = try AVAudioPlayer(contentsOf: deathSound, fileTypeHint: nil)
            trackPlayer  = try AVAudioPlayer(contentsOf: soundTrack, fileTypeHint: nil)
            buttonPlayer = try AVAudioPlayer(contentsOf: soundTrack, fileTypeHint: nil)
        }
 
        catch let error as NSError { print(error.description) }
 
        //audioPlayer.numberOfLoops = 0
        trackPlayer.numberOfLoops = -1
        
        touchPlayer.volume = 0.07    //0.07
        pointPlayer.volume = 0.3    //0.3
        deathPlayer.volume = 0.4    //0.4
        trackPlayer.volume = 0.3    //?

        touchPlayer.prepareToPlay()
        pointPlayer.prepareToPlay()
        deathPlayer.prepareToPlay()
        trackPlayer.prepareToPlay()
        
        trackPlayer.play()

        for family: String in UIFont.familyNames
        {
            print("\(family)")
            for names: String in UIFont.fontNames(forFamilyName: family)
            {
                print("== \(names)")
            }
        }
        if CGFloat(length[iRan]) == 50 {
            Xran = 0
        }
        else if CGFloat(length[iRan]) == 75   {
            Xran = 1
        }
    }
    
    /*func rotate360Degrees(duration: CFTimeInterval = 1.0, completionDelegate: AnyObject? = nil) {
        let rotateAnimation = CABasicAnimation(keyPath: "transform.rotation")
        rotateAnimation.fromValue = 0.0
        rotateAnimation.toValue = CGFloat(M_PI * 2.0)
        rotateAnimation.duration = duration
        
        if let delegate: AnyObject = completionDelegate {
            rotateAnimation.delegate = delegate
        }
        self.playBTN.addAnimation(rotateAnimation, forKey: nil)
    }
    */
//--- Restart the game
    
    func restartScene(){
        
        playState = 0
        removeAllChildren()
        removeAllActions()
        score = 0
        ball_dir = 5.0
        islandVar  = 0.8
        
        physicsWorld.gravity = CGVector(dx: 0,dy: 0)              // switch gravity off
        
        createScene()
    }
    
    
//--- Create Scene: edges, ball, score=0
    
    func createScene() {
        
        self.physicsWorld.contactDelegate = self

        //edge on the left
        edge1 = SKSpriteNode(imageNamed: "bar")
        edge1.setScale(0.5)
        edge1.size = CGSize(width: 1, height: 1000)
        edge1.position = CGPoint(x: self.frame.width * 0.29 - 2, y: edge1.frame.height * 0.4)
        edge1.physicsBody = SKPhysicsBody(rectangleOf: edge1.size)
        edge1.physicsBody?.affectedByGravity    = true
        edge1.physicsBody?.isDynamic            = false
        //edge1.physicsBody?.categoryBitMask    = PhysicsCatagory.edge1
        //edge1.physicsBody?.collisionBitMask   = 0
        //edge1.physicsBody?.contactTestBitMask = 0
        edge1.zPosition = 3
        self.addChild(edge1)
        
        //edge on the right
        edge2 = SKSpriteNode(imageNamed: "bar")
        edge2.setScale(0.5)
        edge2.size = CGSize(width: 1, height: 1000)
        edge2.position = CGPoint(x: self.frame.width * 0.71 + 2, y: edge2.frame.height * 0.4)
        edge2.physicsBody = SKPhysicsBody(rectangleOf: edge2.size)
        edge2.physicsBody?.affectedByGravity    = true
        edge2.physicsBody?.isDynamic            = false
        edge2.physicsBody?.categoryBitMask       = PhysicsCatagory.edge2
        //edge2.physicsBody?.collisionBitMask   = 0
        //edge2.physicsBody?.contactTestBitMask = 0
        edge2.zPosition = 3
        self.addChild(edge2)
        
        //shape to define ball
        
        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path   = CGMutablePath()
        
        path.move   (to: CGPoint(x: center.x + 25, y: center.y))
        path.addLine(to: CGPoint(x: center.x,      y: center.y + 25))
        path.addLine(to: CGPoint(x: center.x - 25, y: center.y))
        path.addLine(to: CGPoint(x: center.x,      y: center.y - 25))

        path.closeSubpath()
        ball = SKShapeNode(path: path)
    
        ball.lineWidth = 6
        ball.fillColor =  greyWhite
       
        if ballColor == 1 {
            ball.strokeColor = darkGrey
        }
        
        if ballColor == -1 {
            ball.strokeColor = darkGrey
        }
        
        ball.physicsBody = SKPhysicsBody(polygonFrom: path)
        ball.physicsBody?.isDynamic          = true
        ball.physicsBody?.affectedByGravity  = true
        ball.physicsBody?.mass               = 1
        ball.physicsBody?.friction           = 0.0
        ball.physicsBody?.linearDamping      = 0.0
        ball.physicsBody?.restitution        = 0.3                           // ball: bounciness (0,1)
        ball.physicsBody?.categoryBitMask    = PhysicsCatagory.ball
        ball.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.wallAr | PhysicsCatagory.wallBr
          | PhysicsCatagory.wallAl | PhysicsCatagory.wallBl | PhysicsCatagory.edge1 | PhysicsCatagory.edge2
          | PhysicsCatagory.smallWallLeft | PhysicsCatagory.smallWallRight
        ball.physicsBody?.contactTestBitMask = PhysicsCatagory.wallAr | PhysicsCatagory.wallBr | PhysicsCatagory.wallAl
          | PhysicsCatagory.wallBl | PhysicsCatagory.score | PhysicsCatagory.edge1 | PhysicsCatagory.edge2
          | PhysicsCatagory.smallWallLeft | PhysicsCatagory.smallWallRight
        ball.physicsBody!.usesPreciseCollisionDetection = true
        ball.physicsBody?.velocity = CGVector(dx: ximpulse / 2.0 , dy: 0)            // ball: initial velocity [m/s]
        ball.zPosition = 3
        
        self.addChild(ball)
        
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.5)
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "Outage-Regular"  //"GillSans-UltraBold"
        scoreLbl.zPosition = 4
        scoreLbl.fontSize = 70
        self.addChild(scoreLbl)
        
        starLbl.position = CGPoint(x: self.frame.width / 2 + 50, y: self.frame.height / 2 + self.frame.height / 2.5)
        starLbl.text = "\(starCount)"
        starLbl.fontName = "Outage-Regular"  //"GillSans-UltraBold"
        starLbl.zPosition = 4
        starLbl.fontSize = 70
        starLbl.fontColor = darkGrey
        //self.addChild(starLbl)

        createPauseBtn()
        
        let topNode = SKSpriteNode()
        topNode.size = CGSize(width: 850, height:3)
        topNode.position = CGPoint(x:self.frame.width/2, y:self.frame.height)
        topNode.physicsBody = SKPhysicsBody(rectangleOf: topNode.size)
        topNode.physicsBody?.affectedByGravity  = false
        topNode.physicsBody?.isDynamic          = false
        topNode.physicsBody?.categoryBitMask    = PhysicsCatagory.topNode
        topNode.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        topNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        topNode.color = SKColor.clear
        self.addChild(topNode)
    }

    
//--- Home screen
    
    func homeScene(){
        
        backgroundColor = greyWhite
        self.physicsWorld.gravity = gravityDirection
        
        //play button
        playBTN = SKSpriteNode(imageNamed: "playBTN2")
        playBTN.setScale(1.15)
        playBTN.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 30 )
        playBTN.zPosition = 5
        self.addChild(playBTN)
        
        //rate button
        rateBTN = SKSpriteNode(imageNamed: "rateBTN1")
        rateBTN.setScale(1.0)
        rateBTN.position = CGPoint(x: self.frame.width / 2 - 110, y:self.frame.height/2 - 150 )
        rateBTN.zPosition = 5
        self.addChild(rateBTN)
        /*
        //music button
        musicBTN = SKSpriteNode(imageNamed: "musicBTN_1")
        musicBTN.setScale(1.0)
        musicBTN.position = CGPoint(x: self.frame.width / 2 + 110, y:self.frame.height/2 - 150 )
        musicBTN.zPosition = 5
        self.addChild(musicBTN)*/
        createMusicBTN()

        //title
        gameLabel = SKSpriteNode(imageNamed: "dodgePic")
        gameLabel.setScale(1.11)
        gameLabel.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-130)
        gameLabel.zPosition = 5
        self.addChild(gameLabel)
        
        //no Ads
        noAd = SKSpriteNode(imageNamed: "ads")
        noAd.setScale(1.0)
        noAd.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 150)
        noAd.zPosition = 5
        self.addChild(noAd)
        
        //no Ads Button
        noAdBTN = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 110, height: 100))
        noAdBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 577)
        noAdBTN.zPosition = 4
        //self.addChild(self.noAdBTN)
        
        let center11 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path11   = CGMutablePath()
        
        path11.move   (to: CGPoint(x: center11.x + 25, y: center11.y))
        path11.addLine(to: CGPoint(x: center11.x,      y: center11.y + 25))
        path11.addLine(to: CGPoint(x: center11.x - 25, y: center11.y))
        path11.addLine(to: CGPoint(x: center11.x,      y: center11.y - 25))
        path11.closeSubpath()
        diamond = SKShapeNode(path: path11)
        
        diamond.physicsBody = SKPhysicsBody(polygonFrom: path11)
        diamond.physicsBody?.isDynamic          = false
        diamond.physicsBody?.affectedByGravity  = false
        diamond.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 )
        diamond.lineWidth = 6
        diamond.fillColor =  red
        diamond.strokeColor = red
        diamond.zPosition = 6
        
        self.addChild(diamond)
        
        
    }

    
//--- Create the no ads scene
    
    func createNoAds() {
        
    }

    
//--- Game label
    
    func createGameLabel() {
        //title
        gameLabel2 = SKSpriteNode(imageNamed: "dodgePic")
        gameLabel2.setScale(1.11)
        gameLabel2.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-120)
        gameLabel2.zPosition = 5
        self.addChild(gameLabel2)
    }


//--- create restart button
    
    func createRestartBTN2(){
        
        
        self.restartBTN2 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
        self.restartBTN2.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
        self.restartBTN2.zPosition = 4
        self.addChild(self.restartBTN2)

        self.resetBTN2 = SKSpriteNode(imageNamed: "Reset-Button2")
        self.resetBTN2.size = CGSize(width: 140, height: 140)
        self.resetBTN2.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
        self.resetBTN2.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN2.size)
        self.resetBTN2.physicsBody?.affectedByGravity = true
        self.resetBTN2.physicsBody?.isDynamic = false
        self.resetBTN2.zPosition = 7
        self.addChild(self.resetBTN2)
        
    }
    
    //--- create restart button
    
    func createRestartBTN(){
        
        delay(restartDelay) {
            self.restartBTN = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN.zPosition = 4
            self.addChild(self.restartBTN)
            
            self.resetBTN = SKSpriteNode(imageNamed: "Reset-Button")
            self.resetBTN.size = CGSize(width: 140, height: 140)
            self.resetBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN.size)
            self.resetBTN.physicsBody?.affectedByGravity = true
            self.resetBTN.physicsBody?.isDynamic = false
            self.resetBTN.zPosition = 6
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
    
    
//--- play button 2
    
    func createPlayBTN2() {
        playBTN2 = SKSpriteNode(imageNamed: "playBTN4")
        playBTN2.setScale(1.15)
        playBTN2.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 30)
        playBTN2.zPosition = 5
        self.addChild(playBTN2)
    }
    
//--- play button
    func createPlayBTN() {
        playBTN = SKSpriteNode(imageNamed: "playBTN2")
        playBTN.setScale(0.3)
        playBTN.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 )
        playBTN.zPosition = 5
        self.addChild(playBTN)
    }
    
//--- rate button 2
    
    func createRateBTN2() {
        rateBTN2 = SKSpriteNode(imageNamed: "rateBTN3")
        rateBTN2.setScale(1.0)
        rateBTN2.position = CGPoint(x: self.frame.width / 2 - 110, y:self.frame.height/2 - 150)
        rateBTN2.zPosition = 5
        self.addChild(rateBTN2)
    }
    
//--- music button 1
    
    func createMusicBTN() {
        musicBTN = SKSpriteNode(imageNamed: "musicBTN_1")
        musicBTN.setScale(1.0)
        musicBTN.position = CGPoint(x: self.frame.width / 2 + 110, y:self.frame.height/2 - 150 )
        musicBTN.zPosition = 5
        self.addChild(musicBTN)
    }
    
//--- music button 2
    
    func createMusicBTN2() {
        musicBTN2 = SKSpriteNode(imageNamed: "musicBTN_2")
        musicBTN2.setScale(1.0)
        musicBTN2.position = CGPoint(x: self.frame.width / 2 + 110, y:self.frame.height/2 - 150)
        musicBTN2.zPosition = 5
        self.addChild(musicBTN2)
    }

    
//--- home button 1
    
    func createHomeBTN1() {
        delay(restartDelay) {
            self.homeBTN1 = SKSpriteNode(imageNamed: "homeBTN_1")
            self.homeBTN1.setScale(0.8)
            self.homeBTN1.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 577)
            self.homeBTN1.zPosition = 5
            self.addChild(self.homeBTN1)
        }
    }
    
    
//--- home button 2
    
    func createHomeBTN2() {
        homeBTN2 = SKSpriteNode(imageNamed: "homeBTN_2")
        homeBTN2.setScale(0.8)
        homeBTN2.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 577)
        homeBTN2.zPosition = 5
        self.addChild(homeBTN2)
    }


//--- end score
    
    func endScore(){
    
        if (score > highscore) {
                highscore = score
        }
    
        removeAllChildren()
    
        let HighscoreDefault = UserDefaults.standard
        HighscoreDefault.setValue(highscore, forKey: "highscore")
        HighscoreDefault.synchronize()
        
        let starCountDefault = UserDefaults.standard
        starCountDefault.setValue(starCount, forKey: "starCount")
        starCountDefault.synchronize()

        self.endScoreLbl = SKLabelNode(fontNamed: "GillSans-Bold")
        self.endScoreLbl.text       = "Score"
        self.endScoreLbl.fontSize   = 45
        self.endScoreLbl.fontColor  = self.greyWhite
        self.endScoreLbl.horizontalAlignmentMode = .center
        self.endScoreLbl.position   = CGPoint(x: self.frame.width / 2, y:self.frame.height-270)
        self.endScoreLbl.zPosition  = 5
        self.addChild(self.endScoreLbl)
        
        self.endScoreLbl2 = SKLabelNode(fontNamed: "GillSans-Bold")
        self.endScoreLbl2.text      = String(self.score)
        self.endScoreLbl2.fontSize  = 45
        self.endScoreLbl2.fontColor = self.red
        self.endScoreLbl2.horizontalAlignmentMode = .center
        self.endScoreLbl2.position  = CGPoint(x: self.frame.width / 2, y:self.frame.height-320)
        self.endScoreLbl2.zPosition = 5
        self.addChild(self.endScoreLbl2)
    
        self.endScoreLbl3 = SKLabelNode(fontNamed: "GillSans-Bold")
        self.endScoreLbl3.text      = "Highscore"
        self.endScoreLbl3.fontSize  = 45
        self.endScoreLbl3.fontColor = self.greyWhite
        self.endScoreLbl3.horizontalAlignmentMode = .center
        self.endScoreLbl3.position  = CGPoint(x: self.frame.width / 2, y:self.frame.height-420)
        self.endScoreLbl3.zPosition = 5
        self.addChild(self.endScoreLbl3)
    
        self.endScoreLbl4 = SKLabelNode(fontNamed: "GillSans-Bold")
        self.endScoreLbl4.text      = String(self.highscore)
        self.endScoreLbl4.fontSize  = 45
        self.endScoreLbl4.fontColor = self.darkGrey
        self.endScoreLbl4.horizontalAlignmentMode = .center
        self.endScoreLbl4.position  = CGPoint(x: self.frame.width / 2, y:self.frame.height-470)
        self.endScoreLbl4.zPosition = 5
        self.addChild(self.endScoreLbl4)
    
        //wall behind score
        
        let center6 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path6   = CGMutablePath()
    
        path6.move   (to: CGPoint(x: center6.x + 150,  y: center6.y))
        path6.addLine(to: CGPoint(x: center6.x + 125,  y: center6.y + 25))
        path6.addLine(to: CGPoint(x: center6.x - 1000, y: center6.y + 25))
        path6.addLine(to: CGPoint(x: center6.x - 1000, y: center6.y - 25))
        path6.addLine(to: CGPoint(x: center6.x + 125,  y: center6.y - 25))

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
        
        path7.move   (to: CGPoint(x: center7.x - 100,  y: center7.y))
        path7.addLine(to: CGPoint(x: center7.x - 125,  y: center7.y + 25))
        path7.addLine(to: CGPoint(x: center7.x + 1000, y: center7.y + 25))
        path7.addLine(to: CGPoint(x: center7.x + 1000, y: center7.y - 25))
        path7.addLine(to: CGPoint(x: center7.x - 125,  y: center7.y - 25))
        
        path7.closeSubpath()
        highscoreWall = SKShapeNode(path: path7)
        highscoreWall.strokeColor = darkGrey
        highscoreWall.fillColor   = darkGrey
        highscoreWall.position    = CGPoint(x: self.frame.width - 1080, y:self.frame.height-790)
        highscoreWall.physicsBody = SKPhysicsBody(polygonFrom: path7)
        highscoreWall.zPosition = 3
        highscoreWall.physicsBody?.isDynamic         = false
        highscoreWall.physicsBody?.affectedByGravity = false

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
        scoreNode.physicsBody?.affectedByGravity  = false
        scoreNode.physicsBody?.isDynamic          = false
        scoreNode.physicsBody?.categoryBitMask    = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask   = 0
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
        wallAr.physicsBody?.affectedByGravity   = false
        wallAr.physicsBody?.isDynamic          = false
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
        
        wallBr = SKShapeNode(path: path2)
        wallBr.strokeColor = darkGrey
        wallBr.fillColor   = darkGrey
        wallBr.position    = CGPoint(x: self.frame.width  - xwallPos1 + xwallShift - 30, y:frame.height-383)
        wallBr.physicsBody = SKPhysicsBody(polygonFrom: path2)
        wallBr.physicsBody?.affectedByGravity   = false
        wallBr.physicsBody?.isDynamic          = false
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
        scoreNode.physicsBody?.affectedByGravity  = false
        scoreNode.physicsBody?.isDynamic          = false
        scoreNode.physicsBody?.categoryBitMask    = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask   = 0
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
        wallAl.physicsBody?.affectedByGravity  = false
        wallAl.physicsBody?.isDynamic          = false
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
        wallBl.physicsBody?.affectedByGravity  = false
        wallBl.physicsBody?.isDynamic          = false
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
        scoreNode.physicsBody?.affectedByGravity  = false
        scoreNode.physicsBody?.isDynamic          = false
        scoreNode.physicsBody?.categoryBitMask     = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask   = 0
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
        wallAr.physicsBody?.affectedByGravity  = false
        wallAr.physicsBody?.isDynamic          = false
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
        
        wallBr = SKShapeNode(path: path2)
        wallBr.strokeColor = darkGrey
        wallBr.fillColor   = darkGrey
        wallBr.position    = CGPoint(x: self.frame.width / 2 - 400, y:frame.height-383)
        wallBr.physicsBody = SKPhysicsBody(polygonFrom: path2)
        wallBr.physicsBody?.affectedByGravity = false
        wallBr.physicsBody?.isDynamic = true
        wallBr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallBr
        wallBr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallBr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallBr.zPosition = 3
        
        wallChompLeft.addChild(wallBr)
        wallChompLeft.run(moveAndRemoveChompLeft)
        
        self.addChild(wallChompLeft)
    }

    
//--- Create Island moving left and right   <====> starting left
    
    func createWallIslandLeft(){
        
        wallIslandLeft = SKNode()
        wallIslandLeft.name = "wallIslandLeft"
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 8500, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = greyWhite

        // island <====>
        
        let center8 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path8   = CGMutablePath()
        
        path8.move   (to: CGPoint(x: center8.x + CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y - 25))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y - 25))

        path8.closeSubpath()
        island = SKShapeNode(path: path8)
        island.strokeColor = red
        island.fillColor   = red
        island.position    = CGPoint(x: self.frame.width/2 - CGFloat(islandPosLeft), y:frame.height-383)
        island.physicsBody = SKPhysicsBody(polygonFrom: path8)
        island.physicsBody?.affectedByGravity = false
        island.physicsBody?.isDynamic = true
        island.physicsBody?.categoryBitMask    = PhysicsCatagory.islandLeft
        island.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.zPosition = 3
        
        wallIslandLeft.addChild(island)
        wallIslandLeft.addChild(scoreNode)
        wallIslandLeft.run(moveAndRemoveIslandLeft)
        
        self.addChild(wallIslandLeft)
    }
    
    
//--- 2 Create Island moving left and right   <====> starting left
    
    func createWallIslandLeft2(){
        
        wallIslandLeft2 = SKNode()
        wallIslandLeft2.name = "wallIslandLeft2"
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 8500, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = true
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = greyWhite
        
        // island <====>
        
        let center8 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path8   = CGMutablePath()
        
        path8.move   (to: CGPoint(x: center8.x + CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y - 25))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y - 25))
        
        path8.closeSubpath()
        island = SKShapeNode(path: path8)
        island.strokeColor = red
        island.fillColor   = red
        island.position    = CGPoint(x: self.frame.width/2 - CGFloat(islandPosLeft), y:frame.height-383)
        island.physicsBody = SKPhysicsBody(polygonFrom: path8)
        island.physicsBody?.affectedByGravity = false
        island.physicsBody?.isDynamic = true
        island.physicsBody?.categoryBitMask    = PhysicsCatagory.islandLeft2
        island.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.zPosition = 3
        
        wallIslandLeft2.addChild(island)
        wallIslandLeft2.addChild(scoreNode)
        wallIslandLeft2.run(moveAndRemoveIslandLeft)
        
        self.addChild(wallIslandLeft2)
    }
    

//--- Create Island moving left and right   <====> starting right
    
    func createWallIslandRight(){
        
        wallIslandRight = SKNode()
        wallIslandRight.name = "wallIslandRight"
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 8500, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = true
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = greyWhite
        
        // island <====>
        
        let center8 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path8   = CGMutablePath()
        
        path8.move   (to: CGPoint(x: center8.x + CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y - 25))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y - 25))
        
        path8.closeSubpath()
        island = SKShapeNode(path: path8)
        island.strokeColor = darkGrey
        island.fillColor   = darkGrey
        island.position    = CGPoint(x: self.frame.width/2 - CGFloat(islandPosRight), y:frame.height-383)
        island.physicsBody = SKPhysicsBody(polygonFrom: path8)
        island.physicsBody?.affectedByGravity = false
        island.physicsBody?.isDynamic = true
        island.physicsBody?.categoryBitMask    = PhysicsCatagory.islandRight
        island.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.zPosition = 3
        
        /*let force = SCNVector3(x: 10, y: 10 , z: 0)
        let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
        island.physicsBody?.applyForce(force, atPosition: position, impulse: true)*/
        
        wallIslandRight.addChild(island)
        wallIslandRight.addChild(scoreNode)
        wallIslandRight.run(moveAndRemoveIslandRight)
        
        self.addChild(wallIslandRight)
    }


    //--- Create Island moving left and right   <====> starting right
    
    func createWallIslandRight2(){
        
        wallIslandRight2 = SKNode()
        wallIslandRight2.name = "wallIslandRight2"
        
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 8500, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOf: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.isDynamic = true
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = greyWhite
        
        // island <====>
        
        let center8 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path8   = CGMutablePath()
        
        path8.move   (to: CGPoint(x: center8.x + CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]), y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y - 25))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y - 25))
        
        path8.closeSubpath()
        island = SKShapeNode(path: path8)
        island.strokeColor = darkGrey
        island.fillColor   = darkGrey
        island.position    = CGPoint(x: self.frame.width/2 - CGFloat(islandPosRight), y:frame.height-383)
        island.physicsBody = SKPhysicsBody(polygonFrom: path8)
        island.physicsBody?.affectedByGravity = false
        island.physicsBody?.isDynamic = true
        island.physicsBody?.categoryBitMask    = PhysicsCatagory.islandRight2
        island.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.smallWallRight | PhysicsCatagory.smallWallLeft
        island.zPosition = 3
        
        /*let force = SCNVector3(x: 10, y: 10 , z: 0)
         let position = SCNVector3(x: 0.05, y: 0.05, z: 0.05)
         island.physicsBody?.applyForce(force, atPosition: position, impulse: true)*/
        
        wallIslandRight2.addChild(island)
        wallIslandRight2.addChild(scoreNode)
        wallIslandRight2.run(moveAndRemoveIslandRight)
        
        self.addChild(wallIslandRight2)
    }
    

//--- Create Walls outside of Island  ==<   (<====>)   >==

    func createWallsOutsideRed(){
        
        outsideWalls = SKNode()
        outsideWalls.name = "outsideWalls"
        
        let center9 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path9   = CGMutablePath()
        
        path9.move   (to: CGPoint(x: center9.x - 100,  y: center9.y))
        path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y - 25))
        path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y - 25))
        path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y + 25))
        path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y + 25))
 
        /*
        path9.move   (to: CGPoint(x: center9.x - 100,  y: center9.y))
        path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y + 25))
        path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y + 25))
        path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y - 25))
        path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y - 25))
        */

        path9.closeSubpath()
        smallWallRight = SKShapeNode(path: path9)
        smallWallRight.strokeColor = red
        smallWallRight.fillColor   = red
        smallWallRight.position    = CGPoint(x: self.frame.width/2 - 220, y:frame.height-383)
        smallWallRight.physicsBody = SKPhysicsBody(polygonFrom: path9)
        smallWallRight.physicsBody?.affectedByGravity = false
        smallWallRight.physicsBody?.isDynamic = false
        smallWallRight.physicsBody?.categoryBitMask    = PhysicsCatagory.smallWallRight 
        smallWallRight.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallRight.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallRight.physicsBody!.usesPreciseCollisionDetection = true
        smallWallRight.zPosition = 3
        
        let center10 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path10   = CGMutablePath()
        
        path10.move   (to: CGPoint(x: center10.x + 100,  y: center10.y))
        path10.addLine(to: CGPoint(x: center10.x + 125,  y: center10.y + 25))
        path10.addLine(to: CGPoint(x: center10.x - 100,  y: center10.y + 25))
        path10.addLine(to: CGPoint(x: center10.x - 100,  y: center10.y - 25))
        path10.addLine(to: CGPoint(x: center10.x + 125,  y: center10.y - 25))
        
        path10.closeSubpath()
        smallWallLeft = SKShapeNode(path: path10)
        smallWallLeft.strokeColor = red
        smallWallLeft.fillColor   = red
        smallWallLeft.position    = CGPoint(x: self.frame.width/2 - 800, y:frame.height-383)
        smallWallLeft.physicsBody = SKPhysicsBody(polygonFrom: path10)
        smallWallLeft.physicsBody?.affectedByGravity = false
        smallWallLeft.physicsBody?.isDynamic = false
        smallWallLeft.physicsBody?.categoryBitMask    = PhysicsCatagory.smallWallLeft
        smallWallLeft.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallLeft.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallLeft.physicsBody!.usesPreciseCollisionDetection = true
        smallWallLeft.zPosition = 3
        
        outsideWalls.addChild(smallWallRight)

        outsideWalls.addChild(smallWallLeft)
        outsideWalls.run(moveAndRemoveOutsideWall)
        
        self.addChild(outsideWalls)
    }
    
    func createWallsOutsideGrey(){
        
        outsideWalls = SKNode()
        outsideWalls.name = "outsideWalls"
        
        let center9 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path9   = CGMutablePath()
        
        path9.move   (to: CGPoint(x: center9.x - 100,  y: center9.y))
        path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y - 25))
        path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y - 25))
        path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y + 25))
        path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y + 25))
        
        /*
         path9.move   (to: CGPoint(x: center9.x - 100,  y: center9.y))
         path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y + 25))
         path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y + 25))
         path9.addLine(to: CGPoint(x: center9.x + 100,  y: center9.y - 25))
         path9.addLine(to: CGPoint(x: center9.x - 125,  y: center9.y - 25))
         */
        
        path9.closeSubpath()
        smallWallRight = SKShapeNode(path: path9)
        smallWallRight.strokeColor = darkGrey
        smallWallRight.fillColor   = darkGrey
        smallWallRight.position    = CGPoint(x: self.frame.width/2 - 220, y:frame.height-383)
        smallWallRight.physicsBody = SKPhysicsBody(polygonFrom: path9)
        smallWallRight.physicsBody?.affectedByGravity = false
        smallWallRight.physicsBody?.isDynamic = false
        smallWallRight.physicsBody?.categoryBitMask    = PhysicsCatagory.smallWallRight
        smallWallRight.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallRight.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallRight.physicsBody!.usesPreciseCollisionDetection = true
        smallWallRight.zPosition = 3
        
        let center10 = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path10   = CGMutablePath()
        
        path10.move   (to: CGPoint(x: center10.x + 100,  y: center10.y))
        path10.addLine(to: CGPoint(x: center10.x + 125,  y: center10.y + 25))
        path10.addLine(to: CGPoint(x: center10.x - 100,  y: center10.y + 25))
        path10.addLine(to: CGPoint(x: center10.x - 100,  y: center10.y - 25))
        path10.addLine(to: CGPoint(x: center10.x + 125,  y: center10.y - 25))
        
        path10.closeSubpath()
        smallWallLeft = SKShapeNode(path: path10)
        smallWallLeft.strokeColor = darkGrey
        smallWallLeft.fillColor   = darkGrey
        smallWallLeft.position    = CGPoint(x: self.frame.width/2 - 800, y:frame.height-383)
        smallWallLeft.physicsBody = SKPhysicsBody(polygonFrom: path10)
        smallWallLeft.physicsBody?.affectedByGravity = false
        smallWallLeft.physicsBody?.isDynamic = false
        smallWallLeft.physicsBody?.categoryBitMask    = PhysicsCatagory.smallWallLeft
        smallWallLeft.physicsBody?.collisionBitMask   = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallLeft.physicsBody?.contactTestBitMask = PhysicsCatagory.ball | PhysicsCatagory.islandLeft | PhysicsCatagory.islandRight
        smallWallLeft.physicsBody!.usesPreciseCollisionDetection = true
        smallWallLeft.zPosition = 3
        
        outsideWalls.addChild(smallWallRight)
        
        outsideWalls.addChild(smallWallLeft)
        outsideWalls.run(moveAndRemoveOutsideWall)
        
        self.addChild(outsideWalls)
    }


    
//--- Stars
    
    func createStars() {
        //star = SKNode()
        //star.name = "star"
        star1 = SKSpriteNode(imageNamed: "star_2")
        star1.setScale(1.0)
        star1.size = CGSize(width: 40, height: 40)
        star1.position = CGPoint(x: self.frame.width / 2 + CGFloat(starVar) , y:self.frame.height / 2 + 383)
        star1.physicsBody = SKPhysicsBody(rectangleOf: star1.size)
        star1.physicsBody?.affectedByGravity = false
        star1.physicsBody?.isDynamic = false
        star1.physicsBody?.categoryBitMask = PhysicsCatagory.star1
        star1.physicsBody?.collisionBitMask = 0
        star1.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        star1.zPosition = 5
        //star.addChild(star1)
        star1.run(moveAndRemoveStar)
        self.addChild(star1)
        print("STAR")
    }
    
    
//--- Mouse Click Began
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */

        print("Mouse Click: ",playState, ball_dir)

        // state -1: home ----------------------
        
        if playState == -1 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if playBTN.contains(location){
                    createPlayBTN2()
                    playBTN.removeFromParent()
                }
                
                if rateBTN.contains(location){
                    
                }
                
                if musicBTN.contains(location) && trackPlayer.volume == 0.3{
                    trackPlayer.volume = 0.0
                    print("---MusicBTN touch begin---", trackPlayer.volume)
                }
                
                else {
                    trackPlayer.volume = 0.3
                    print("-------MusicBTN2 touch begin-------", trackPlayer.volume)
                }
                
                if trackPlayer.volume == 0.0 && trackPlayer.volume == 0.3 {
                    print("-------HEY!!!-------", trackPlayer.volume)
                    
                }
                
                if noAdBTN.contains(location){
                    
                }
            }
        }
        
        // state 0: Set ----------------------
        
        if playState == 0 {
            backgroundColor = greyWhite

            /*
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
            */
            
            let spawnIslandLeft = SKAction.run({
                () in
                self.createWallIslandLeft()
                self.createWallsOutsideGrey()
            })
            
            let spawnIslandLeft2 = SKAction.run({
                () in
                self.createWallIslandLeft2()
                self.createWallsOutsideGrey()
            })
            
            let spawnIslandRight = SKAction.run({
                () in
                self.createWallIslandRight()
                self.createWallsOutsideRed()
            })
            
            let spawnIslandRight2 = SKAction.run({
                () in
                self.createWallIslandRight2()
                self.createWallsOutsideRed()
            })
            
            let spawnStar = SKAction.run({
                () in
                self.createStars()
            })

            //let spawnFallBall = SKAction.run({
            //    () in
            //    self.obstacle()
            //})
            
            wallDir = wallDir1
            
            // move walls down (called in functions createWallsRight and Left)
            
            let distanceWall = self.frame.width + wallPairRight.frame.width
            
            print("random: ", arc4random_uniform(3))
            //iRan = Int(arc4random_uniform(3))
            
            // right walls
            let moveWallRight        = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove[iRan], y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallRight      = SKAction.removeFromParent()
            moveAndRemoveRight       = SKAction.sequence([moveWallRight, removeWallRight])
            
            // left walls
            let moveWallLeft         = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove[iRan] * (-1), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallLeft       = SKAction.removeFromParent()
            moveAndRemoveLeft        = SKAction.sequence([moveWallLeft, removeWallLeft])
            
            // chomp wall right
            let moveWallChompRight   = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove[iRan] * (-0.5), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallChompRight = SKAction.removeFromParent()
            moveAndRemoveChompRight  = SKAction.sequence([moveWallChompRight, removeWallChompRight])
            
            // chomp wall left
            let moveWallChompLeft    = SKAction.moveBy(x: CGFloat(ball_dir) * xwallMove[iRan] * (0.5), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallChompLeft  = SKAction.removeFromParent()
            moveAndRemoveChompLeft   = SKAction.sequence([moveWallChompLeft, removeWallChompLeft])
            
            
            // island starting left
            let moveIslandLeft       = SKAction.moveBy(x: CGFloat(islandVar) * CGFloat(ball_dir) * xwallMove[Xran], y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeIslandLeft     = SKAction.removeFromParent()
            moveAndRemoveIslandLeft  = SKAction.sequence([moveIslandLeft, removeIslandLeft])
            
            // island starting right
            let moveIslandRight      = SKAction.moveBy(x: CGFloat(-islandVar) * CGFloat(ball_dir) * xwallMove[Xran], y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeIslandRight    = SKAction.removeFromParent()
            moveAndRemoveIslandRight = SKAction.sequence([moveIslandRight, removeIslandRight])
            


            // Outside Wall (outside of island)
            let moveOutsideWall      = SKAction.moveBy(x: 0, y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeOutsideWall    = SKAction.removeFromParent()
            moveAndRemoveOutsideWall = SKAction.sequence([moveOutsideWall, removeOutsideWall])
            
            // star
            let moveStar             = SKAction.moveBy(x: 0, y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeStar           = SKAction.removeFromParent()
            moveAndRemoveStar        = SKAction.sequence([moveStar, removeStar])
            
            // SEQUENCE
            let spawnDelay           = SKAction.sequence([/*spawnWallsRight, delayWalls, /*spawnFallBall,*/ spawnWallsLeft, delayWalls, spawnWallsChomp, delayWalls,*/
                spawnIslandLeft,  delayHalf, spawnStar, delayHalf, spawnIslandRight,  delayHalf, spawnStar, delayHalf,
                spawnIslandLeft2, delayHalf, spawnStar, delayHalf, spawnIslandRight2, delayHalf, spawnStar, delayHalf ])
                
//                spawnIslandRight , delayHalf, spawnStar, delayHalf, spawnIslandLeft,  delayHalf, spawnStar, delayHalf,
//                spawnIslandRight2, delayHalf, spawnStar, delayHalf, spawnIslandLeft2, delayHalf, spawnStar, delayHalf ])
            let spawnDelayForever    = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            //self.physicsWorld.gravity = CGVector(dx: CGFloat(islandAcc - xvelocity), dy: CGFloat(-ygravity))
            
            playState = 1

            print("Create walls, game started",playState)
        }
        
        // state 1: Play ----------------------
        
        if playState == 1 {
            
            ball_dir = ball_dir * (-1.0)

            ball.physicsBody?.velocity = CGVector(dx: ball_dir*xvelocity, dy: yvelocity)       // ball: initial velocity [m/s]
            
            //ball.physicsBody?.applyImpulse(CGVectorMake(CGFloat(ball_dir*(ximpulse+Double(score)*ximpMore)),
            //                                            CGFloat(          yimpulse+Double(score)*yimpMore))) // add impulse

            self.physicsWorld.gravity = CGVector(dx: CGFloat(ball_dir*xgravity), dy: CGFloat(ygravity))   // switch gravity
            
            //while island.position != CGPoint(x:self.frame.width/2 - CGFloat(islandPosLeft), y:frame.height-383) {
             //   self.xwallMove += 10
            //}
            
            touchPlayer.play()
            
            print("Press Ball Impulse: ",playState)
            
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
                    restartBTN.removeFromParent()
                    createRestartBTN2()
                }
 
                if homeBTN1.contains(location){
                    createHomeBTN2()
                    homeBTN1.removeFromParent()
                }
            }
        }
    }
   
    
//--- Mouse Click Ended
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        if playState == -1 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if playBTN.contains(location){
                    playState = 0
                    playBTN.removeFromParent()
                    playBTN2.removeFromParent()
                    rateBTN2.removeFromParent()
                    rateBTN.removeFromParent()
                    musicBTN.removeFromParent()
                    musicBTN2.removeFromParent()
                    gameLabel.removeFromParent()
                    noAd.removeFromParent()
                    noAdBTN.removeFromParent()
                    createScene()
                }
                
                if rateBTN.contains(location){
                }
                
                   
                if musicBTN.contains(location) && trackPlayer.volume == 0.0{
                    musicBTN.removeFromParent()
                    createMusicBTN2()
                    print("*** End Touch musicBTN ***", trackPlayer.volume)

                }
                
                if musicBTN2.contains(location) && trackPlayer.volume == 0.3{
                    musicBTN2.removeFromParent()
                    createMusicBTN()
                    print("*** End Touch musicBTN2 ***", trackPlayer.volume)
                }
            }
        }
        
        if playState == 3 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if restartBTN2.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    self.addChild(gameLabel)
                    playState = 0
                }
                
                if homeBTN1.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    playState = -1
                    homeScene()
                    score = 0
                }
            }
        }
    }
 
//--- TouchesMove
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        if playState == -1 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if playBTN.contains(location){
                        createPlayBTN()
                        playBTN2.removeFromParent()
                        playState = -1
                    
                }
            }
        }
    }

//--- Collision: contact between ball, islands and walls
    
    func didBegin(_ contact: SKPhysicsContact) {
        let firstBody  = contact.bodyA
        let secondBody = contact.bodyB
        
        print("Contact between two bodies: ", firstBody.categoryBitMask, "  ", secondBody.categoryBitMask)
        
        if (playState == 1)
        {
            //star
            
            if firstBody.categoryBitMask == PhysicsCatagory.star1 && secondBody.categoryBitMask == PhysicsCatagory.ball {
                starCount  += 1
                firstBody.node?.removeFromParent()
                pointPlayer.play()
            }
            
            if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.star1 {
                starCount  += 1
                starLbl.text = "\(starCount)"
                secondBody.node?.removeFromParent()
                pointPlayer.play()
            }

            //score
            
            if firstBody.categoryBitMask == PhysicsCatagory.score && secondBody.categoryBitMask == PhysicsCatagory.ball {
                score  += 1
                wallDir = wallDir * (-1)
                ballColor = ballColor * (-1)
                print("ballColor", ballColor)
                scoreLbl.text = "\(score)"
                firstBody.node?.removeFromParent()
                
                if starVar == -100 {
                    starVar = 100
                }
                else {
                    starVar = -100
                }
                pointPlayer.play()
                
            }

            if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.score {
                score  += 1
                wallDir = wallDir * (-1)
                ballColor = ballColor * (-1)
                print("ballColor", ballColor)
                scoreLbl.text = "\(score)"
                secondBody.node?.removeFromParent()
                if starVar == -100 {
                    starVar = 100
                }
                else {
                    starVar = -100
                }
                pointPlayer.play()
            }
        
            //Left1: island change direction (island starting left hits right wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits right wall: ", distanceWall, velocityWall,abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft.run(moveIslandLeft)
            }
            
            //Left1: island change direction (island starting left hits left wall)

            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits left wall: ", distanceWall, velocityWall,abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft.run(moveIslandLeft)
            }

            //Right1: island change direction (island starting right hits left wall)
            
            if    firstBody.categoryBitMask == PhysicsCatagory.islandRight && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
              || secondBody.categoryBitMask == PhysicsCatagory.islandRight &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                print("---<<<---Right Island hits left wall: ", islandVar, ball_dir, xwallMove[iRan])
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight.run(moveIslandRight)
            }
        
            //Right1: island change direction (island starting right hits right wall)
            
            if    firstBody.categoryBitMask == PhysicsCatagory.islandRight && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
              || secondBody.categoryBitMask == PhysicsCatagory.islandRight &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                print("---<<<---Right Island hits right wall: ", islandVar, ball_dir, xwallMove[iRan])
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight.run(moveIslandRight)
            }
            
            //Left2: island change direction (island starting left hits right wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits right wall: ", distanceWall, velocityWall,abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft2.run(moveIslandLeft)
            }
            
            //Left2: island change direction (island starting left hits left wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits left wall: ", distanceWall, velocityWall,abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft2.run(moveIslandLeft)
            }
            
            //Right2: island change direction (island starting right hits left wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandRight2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                || secondBody.categoryBitMask == PhysicsCatagory.islandRight2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                print("---<<<---Right Island hits left wall: ", islandVar, ball_dir, xwallMove[iRan])
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight2.run(moveIslandRight)
            }
            
            //Right2: island change direction (island starting right hits right wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandRight2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                || secondBody.categoryBitMask == PhysicsCatagory.islandRight2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                print("---<<<---Right Island hits right wall: ", islandVar, ball_dir, xwallMove[iRan])
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * xwallMove[iRan], y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight2.run(moveIslandRight)
            }
            
            if      firstBody.categoryBitMask == PhysicsCatagory.ball
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
                && secondBody.categoryBitMask == PhysicsCatagory.islandLeft
                ||  firstBody.categoryBitMask == PhysicsCatagory.islandLeft
                && secondBody.categoryBitMask == PhysicsCatagory.ball
            
                ||  firstBody.categoryBitMask == PhysicsCatagory.ball
                && secondBody.categoryBitMask == PhysicsCatagory.islandRight
                ||  firstBody.categoryBitMask == PhysicsCatagory.islandRight
                && secondBody.categoryBitMask == PhysicsCatagory.ball
                
                ||  firstBody.categoryBitMask == PhysicsCatagory.ball
                && secondBody.categoryBitMask == PhysicsCatagory.islandLeft2
                ||  firstBody.categoryBitMask == PhysicsCatagory.islandLeft2
                && secondBody.categoryBitMask == PhysicsCatagory.ball
                
                ||  firstBody.categoryBitMask == PhysicsCatagory.ball
                && secondBody.categoryBitMask == PhysicsCatagory.islandRight2
                ||  firstBody.categoryBitMask == PhysicsCatagory.islandRight2
                && secondBody.categoryBitMask == PhysicsCatagory.ball
                
                ||  firstBody.categoryBitMask == PhysicsCatagory.ball
                && secondBody.categoryBitMask == PhysicsCatagory.topNode
                ||  firstBody.categoryBitMask == PhysicsCatagory.topNode
                && secondBody.categoryBitMask == PhysicsCatagory.ball
            
                ||  firstBody.categoryBitMask == PhysicsCatagory.ball
                && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                ||  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                && secondBody.categoryBitMask == PhysicsCatagory.ball

                ||  firstBody.categoryBitMask == PhysicsCatagory.ball
                && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                ||  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
                && secondBody.categoryBitMask == PhysicsCatagory.ball
            {
                playState = 2
                print("Collision with wall")
            
                deathPlayer.play()
            
                //star1.physicsBody?.affectedByGravity = false
                
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
                                                                        
                enumerateChildNodes(withName: "wallIslandLeft", using: {
                    (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })
                                                                        
                enumerateChildNodes(withName: "wallIslandRight", using: {
                    (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })
                                                                        
                enumerateChildNodes(withName: "outsideWalls", using: {
                    (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })
            
                enumerateChildNodes(withName: "star1", using: {
                    (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })

                delay(1){
                    //self.removeAllChildren()
                    self.wallPairRight.removeFromParent()
                    self.wallPairLeft.removeFromParent()
                    self.createRestartBTN()
                    self.createHomeBTN1()
                    self.endScore()
                    self.createGameLabel()
                }
            }
            
            //edge changes direction of ball
            
            if     firstBody.categoryBitMask == PhysicsCatagory.edge1 && secondBody.categoryBitMask == PhysicsCatagory.ball
                || firstBody.categoryBitMask == PhysicsCatagory.ball  && secondBody.categoryBitMask == PhysicsCatagory.edge1 {
                ball_dir = ball_dir * (-1.0)
                print("edgetouch ", ball_dir)
            }
            
            if     firstBody.categoryBitMask == PhysicsCatagory.edge2 && secondBody.categoryBitMask == PhysicsCatagory.ball
                || firstBody.categoryBitMask == PhysicsCatagory.ball  && secondBody.categoryBitMask == PhysicsCatagory.edge2 {
                ball_dir = ball_dir * (-1.0)
                print("edgetouch ", ball_dir)
            }
        }
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
        if ballColor == 1 {
            ball.strokeColor = red
            scoreLbl.fontColor = red
        }
        
        if ballColor == -1 {
            ball.strokeColor = darkGrey
            scoreLbl.fontColor = darkGrey
        }
        iRan = Int(arc4random_uniform(2))
        //iRan2 = Int(arc4random_uniform(3))
    }

}
