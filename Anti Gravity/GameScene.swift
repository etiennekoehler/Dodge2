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
    var bigBar  = SKShapeNode()
    var circle  = SKSpriteNode()
    var wallAr  = SKShapeNode()
    var wallBr  = SKShapeNode()
    var wallAl  = SKShapeNode()
    var wallBl  = SKShapeNode()
    var island  = SKShapeNode()
    var smallWallRight   = SKShapeNode()
    var smallWallLeft    = SKShapeNode()
    var fallBall         = SKShapeNode()
    var ballBar          = SKShapeNode()
    var scoreWall        = SKShapeNode()
    var highscoreWall    = SKShapeNode()
    var diamond          = SKShapeNode()
    var starPic          = SKSpriteNode()
    var boxGold          = SKSpriteNode()
    var wallPairRight    = SKNode()
    var wallPairLeft     = SKNode()
    var wallChompRight   = SKNode()
    var wallChompLeft    = SKNode()
    var wallIslandLeft   = SKNode()
    var wallIslandLeft2  = SKNode()
    var wallIslandRight  = SKNode()
    var wallIslandRight2 = SKNode()
    var outsideWalls     = SKNode()
    var corner1  = SKNode()
    var corner2  = SKNode()
    var corner3  = SKNode()
    var corner4  = SKNode()
    var star     = SKNode()
    var star1    = SKSpriteNode()
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
    var restartBTN2  = SKSpriteNode()
    var resetBTN2    = SKSpriteNode()
    var restartBTN22 = SKSpriteNode()
    var resetBTN22   = SKSpriteNode()
    var restartBTN3  = SKSpriteNode()
    var resetBTN3    = SKSpriteNode()
    var restartBTN4  = SKSpriteNode()
    var resetBTN4    = SKSpriteNode()
    var restartBTN5  = SKSpriteNode()
    var resetBTN5    = SKSpriteNode()
    var restartBTN6  = SKSpriteNode()
    var resetBTN6    = SKSpriteNode()
    var backBTN1     = SKSpriteNode()
    var backBTN2     = SKSpriteNode()
    var backBTN3     = SKSpriteNode()
    var backBTN4     = SKSpriteNode()
    var backBTN5     = SKSpriteNode()
    var backBTN6     = SKSpriteNode()
    var colorBTN1    = SKSpriteNode()
    var colorBTN2    = SKSpriteNode()
    var colorBTN3    = SKSpriteNode()
    var colorBTN4    = SKSpriteNode()
    var colorBTN5    = SKSpriteNode()
    var colorBTN6    = SKSpriteNode()
    var colorBTN1Gold   = SKSpriteNode()
    var colorBTN2Gold   = SKSpriteNode()
    var colorBTN3Gold   = SKSpriteNode()
    var colorBTN4Gold   = SKSpriteNode()
    var colorBTN5Gold   = SKSpriteNode()
    var colorBTN6Gold   = SKSpriteNode()
    var colorHex1    = SKSpriteNode()
    var colorHex2    = SKSpriteNode()
    var colorHex3    = SKSpriteNode()
    var colorHex4    = SKSpriteNode()
    var colorHex5    = SKSpriteNode()
    var colorHex6    = SKSpriteNode()
    var buyColorBTN  = SKSpriteNode()
    var selectBTN1   = SKSpriteNode()
    var selectBTN2   = SKSpriteNode()
    var homeBTN1     = SKSpriteNode()
    var homeBTN2     = SKSpriteNode()
    var homeBTN3     = SKSpriteNode()
    var homeBTN4     = SKSpriteNode()
    var homeBTN5     = SKSpriteNode()
    var homeBTN6     = SKSpriteNode()
    var homeBTNPic   = SKSpriteNode()
    var endScoreLbl  = SKLabelNode()
    var endScoreLbl2 = SKLabelNode()
    var endScoreLbl3 = SKLabelNode()
    var endScoreLbl4 = SKLabelNode()
    var gameLabel    = SKSpriteNode()
    var gameLabel2   = SKSpriteNode()
    var gameLabel22  = SKSpriteNode()
    var gameLabel3   = SKSpriteNode()
    var gameLabel4   = SKSpriteNode()
    var gameLabel5   = SKSpriteNode()
    var gameLabel6   = SKSpriteNode()
    var playBTN      = SKSpriteNode()
    var playBTN2     = SKSpriteNode()
    var playBTN22    = SKSpriteNode()
    var playBTN3     = SKSpriteNode()
    var playBTN4     = SKSpriteNode()
    var playBTN5     = SKSpriteNode()
    var playBTN6     = SKSpriteNode()
    var rateBTN      = SKSpriteNode()
    var rateBTN2     = SKSpriteNode()
    var rateBTN22    = SKSpriteNode()
    var rateBTN3     = SKSpriteNode()
    var rateBTN4     = SKSpriteNode()
    var rateBTN5     = SKSpriteNode()
    var rateBTN6     = SKSpriteNode()
    var musicBTN     = SKSpriteNode()
    var musicBTN22   = SKSpriteNode()
    var musicBTN3    = SKSpriteNode()
    var musicBTN4    = SKSpriteNode()
    var musicBTN5    = SKSpriteNode()
    var musicBTN6    = SKSpriteNode()
    var musicBTN2    = SKSpriteNode()
    var musicBTNCross22    = SKSpriteNode()
    var musicBTNCross3     = SKSpriteNode()
    var musicBTNCross4     = SKSpriteNode()
    var musicBTNCross5     = SKSpriteNode()
    var musicBTNCross6     = SKSpriteNode()
    var buyBTNHome1  = SKSpriteNode()
    var buyBTNHome2  = SKSpriteNode()
    var buyBTNHome3  = SKSpriteNode()
    var buyBTNHome4  = SKSpriteNode()
    var buyBTNHome5  = SKSpriteNode()
    var buyBTNHome6  = SKSpriteNode()
    var buyBTNRest1  = SKSpriteNode()
    var buyBTNRest2  = SKSpriteNode()
    var buyBTNRest3  = SKSpriteNode()
    var buyBTNRest4  = SKSpriteNode()
    var buyBTNRest5  = SKSpriteNode()
    var buyBTNRest6  = SKSpriteNode()
    var pauseBTN     = SKSpriteNode()
    var pauseBTNPic  = SKSpriteNode()
    var noAd         = SKSpriteNode()
    var noAdBTN      = SKSpriteNode()
    var noAdBTN22    = SKSpriteNode()
    var noAdBTN3     = SKSpriteNode()
    var noAdBTN4     = SKSpriteNode()
    var noAdBTN5     = SKSpriteNode()
    var noAdBTN6     = SKSpriteNode()
    //let crashSound = NSURL(fileURLWithPath: (NSBundle.mainBundle().pathForResource("thePointSound", ofType: "mp3"))!)
    var touchPlayer  = AVAudioPlayer()
    var pointPlayer  = AVAudioPlayer()
    var deathPlayer  = AVAudioPlayer()
    var trackPlayer  = AVAudioPlayer()
    var buttonPlayer = AVAudioPlayer()

    var error: NSError?
    var playState = -1
    var colorVar  = 1
    var wallSpeed = 400

    var scrollView: UIScrollView!
    //var buttons: List<UIButton>!

    //--- playState ---
    //-1: home
    // 0: set
    // 1: play
    // 2: dead
    // 3: restart
    // 4: pause
    // 5: buy skin
    // 6: settings
    // 7: ads
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
    var ballColor       = 1
    var starVar         = Int(arc4random_uniform(200))
    var xwallPos1:CGFloat  = 755.0 //755.0                     // position of left wall  e.g. 800
    var xwallPos2:CGFloat  = 300.0 //270.0                     // position of right wall e.g. 225
    var xwallShift:CGFloat = -150.0// -50.0                    // shift wall to see more of incoming red wall//var xwallMoveI:CGFloat = 100.0
    var xwallMove          = [CGFloat(400), CGFloat(400)]// move walls x-speed 400
    var speedVar           = Int()
    var xwallMove2         = 400
    var gravityDirection   = CGVector(dx: 0,dy: 0)             // gravity: normal (0,-9.8)
    var length          = [35, 35] // 50 75
    var Xran            = Int()
    var randPos         = Int(arc4random_uniform(599))
    var islandPosRight  = Int()
    var islandPosLeft   = Int()
    var selectColor     = Int()

    
// color schemes
    
    var greyWhite      = UIColor(red: 252/255, green: 252/255, blue: 247/255, alpha: 1.0)//252 , 252 , 247 / 234 , 248 , 191
    var red            = UIColor(red: 248/256, green: 73/256,  blue:  52/256, alpha: 1.0)//248 , 73 , 52 / 255 , 121 , 18
    var darkGrey       = UIColor(red:  77/255, green: 94/255,  blue:  95/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
    
    var scoreNodeColor = UIColor.clear
    var white          = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    var purple         = UIColor(red: 200/255, green: 200/255, blue: 255/255, alpha: 1.0)
    var lightGrey      = UIColor(red: 255/255,  green: 255/255,  blue: 255/255,  alpha: 1.0)/* #c1c1c1 */
    var gold3          = UIColor(red: 249/255,  green: 200/255,  blue: 14/255,  alpha: 1.0)//248,243,43/227,178,60/249,200,14
    
    var score        = Int()
    var highscore    = Int()
    var starCount    = Int()
    var unlockColor1 = 1
    var unlockColor2 = Int()
    var unlockColor3 = Int()
    var unlockColor4 = Int()
    var unlockColor5 = Int()
    var unlockColor6 = Int()
    var starPos      = Int()
    var soundVar     = Int()
    var volumeVar:CGFloat = 0.0
    var homeOrRestart     = Int()
    var dodgePicColor     = "dodgePic"
    var onBuyScene        = 0
    var superSelect       = 1
    
    let scoreLbl = SKLabelNode()
    let starLbl  = SKLabelNode()
 

//--- Start the game

    override func didMove(to view: SKView) {
  
        backgroundColor = greyWhite
        homeScene()
        homeOrRestart = 0
        //colorVar = 1
        randPos = Int(arc4random_uniform(250)) + 400
        islandPosRight  = randPos
        islandPosLeft   = randPos
        



        
        self.physicsWorld.gravity = gravityDirection
        
        let HighscoreDefault = UserDefaults.standard
        if (HighscoreDefault.value(forKey: "highscore") != nil) {
            highscore = HighscoreDefault.value(forKey: "highscore") as! NSInteger!
        }
        
        let starCountDefault = UserDefaults.standard
        if (starCountDefault.value(forKey: "starCount") != nil) {
            starCount = starCountDefault.value(forKey: "starCount") as! NSInteger!
        }
        
        let unlockColor2Default = UserDefaults.standard
        if (unlockColor2Default.value(forKey: "unlockColor2") != nil) {
            unlockColor2 = unlockColor2Default.value(forKey: "unlockColor2") as! NSInteger!
        }
        
        let unlockColor3Default = UserDefaults.standard
        if (unlockColor3Default.value(forKey: "unlockColor3") != nil) {
            unlockColor3 = unlockColor3Default.value(forKey: "unlockColor3") as! NSInteger!
        }
        
        let unlockColor4Default = UserDefaults.standard
        if (unlockColor4Default.value(forKey: "unlockColor4") != nil) {
            unlockColor4 = unlockColor4Default.value(forKey: "unlockColor4") as! NSInteger!
        }
        
        let unlockColor5Default = UserDefaults.standard
        if (unlockColor5Default.value(forKey: "unlockColor5") != nil) {
            unlockColor5 = unlockColor5Default.value(forKey: "unlockColor5") as! NSInteger!
        }
        
        let unlockColor6Default = UserDefaults.standard
        if (unlockColor6Default.value(forKey: "unlockColor6") != nil) {
            unlockColor6 = unlockColor6Default.value(forKey: "unlockColor6") as! NSInteger!
        }
        
        let soundVarDefault = UserDefaults.standard
        if (soundVarDefault.value(forKey: "soundVar") != nil) {
            soundVar = soundVarDefault.value(forKey: "soundVar") as! NSInteger!
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
        
        touchPlayer.volume = Float(volumeVar)    //0.07
        pointPlayer.volume = 0.0    //0.3
        deathPlayer.volume = 0.0    //0.4
        trackPlayer.volume = 0.0    //0.3

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
        xwallMove2 = 400
        
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
        edge1.physicsBody?.categoryBitMask    = PhysicsCatagory.edge2
        edge1.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        edge1.physicsBody?.contactTestBitMask = PhysicsCatagory.ball

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
        edge2.physicsBody?.categoryBitMask    = PhysicsCatagory.edge2
        edge2.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        edge2.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        edge2.zPosition = 3
        self.addChild(edge2)
        
        //shape to define ball
        
        let center = CGPoint(x: self.frame.midX, y: self.frame.midY)
        let path   = CGMutablePath()
        
        path.move   (to: CGPoint(x: center.x + 25, y: center.y - 100))
        path.addLine(to: CGPoint(x: center.x,      y: center.y - 75))
        path.addLine(to: CGPoint(x: center.x - 25, y: center.y - 100))
        path.addLine(to: CGPoint(x: center.x,      y: center.y - 125))

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
        
        starLbl.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height / 2 + self.frame.height / 2.5 + 43)
        starLbl.text = "\(starCount)"
        starLbl.fontName = "Outage-Regular"  //"GillSans-UltraBold"
        starLbl.zPosition = 4
        starLbl.fontSize = 30
        starLbl.fontColor = gold3
        self.addChild(starLbl)
        
        if starCount < 10 {
            starPos = 115
        }
        else if starCount < 100 && starCount > 9 {
            starPos = 110
        }
        else if starCount > 99 {
            starPos = 105
        }
        starPic = SKSpriteNode(imageNamed: "starGold")
        starPic.setScale(0.3)
        starPic.position = CGPoint(x: self.frame.width / 2 + CGFloat(starPos), y: self.frame.height / 2 + self.frame.height / 2.5 + 55)
        starPic.physicsBody?.affectedByGravity    = false
        starPic.physicsBody?.isDynamic            = false
        starPic.zPosition = 4
        self.addChild(starPic)
        
        boxGold = SKSpriteNode(imageNamed: "boxGold")
        boxGold.setScale(0.6)
        boxGold.position = CGPoint(x: self.frame.width / 2 + 127.5, y: self.frame.height / 2 + self.frame.height / 2.5 + 75)
        boxGold.physicsBody?.affectedByGravity    = false
        boxGold.physicsBody?.isDynamic            = false
        boxGold.zPosition = 4
        self.addChild(boxGold)

        
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
        print("+++++++++++++++++", colorVar)
        
        if colorVar == 1 {
            
            createPlayBTN2()
            
            createRateBTN2()
            
            createMusicBTN()
            
            createNoAds()
            
            createGameLabel()
            
            createBuyBTNHome1()
            
            createCorners()
        
        }
        
        else if colorVar == 2 {
            
            createPlayBTN22()
            
            createRateBTN22()
            
            createMusicBTN22()
            
            createNoAds22()
            
            createGameLabel22()
            
            createBuyBTNHome2()
            
            createCorners()

        }
        
        else if colorVar == 3 {
            
            createPlayBTN3()
            
            createRateBTN3()
            
            createMusicBTN3()
            
            createNoAds3()
            
            createGameLabel3()
            
            createBuyBTNHome3()
            
            createCorners()
            
        }
        
        else if colorVar == 4 {
            
            createPlayBTN4()
            
            createRateBTN4()
            
            createMusicBTN4()
            
            createNoAds4()
            
            createGameLabel4()
            
            createBuyBTNHome4()
            
            createCorners()
    
        }

        else if colorVar == 5 {
            
            createPlayBTN5()
            
            createRateBTN5()
            
            createMusicBTN5()
            
            createNoAds5()
            
            createGameLabel5()
            
            createBuyBTNHome5()
            
            createCorners()
        }

        else if colorVar == 6 {
            
            createPlayBTN6()
            
            createRateBTN6()
            
            createMusicBTN6()
            
            createNoAds6()
            
            createGameLabel6()
            
            createBuyBTNHome6()
            
            createCorners()
            
        }
    }
    
//--- Dead screen
    func createDeadScene(){
        self.wallPairRight.removeFromParent()
        self.wallPairLeft.removeFromParent()
        self.endScore()
        
        if colorVar == 1 {
            self.createGameLabel()
            self.createRestartBTN()
            self.createHomeBTN1()
            self.createBuyBTNRest1()
        }
        
        else if colorVar == 2 {
            self.createGameLabel22()
            self.createRestartBTN22()
            self.createHomeBTN2()
            self.createBuyBTNRest2()
        }
        
        else if colorVar == 3 {
            self.createGameLabel3()
            self.createRestartBTN3()
            self.createHomeBTN3()
            self.createBuyBTNRest3()
        }
        
        else if colorVar == 4 {
            self.createGameLabel4()
            self.createRestartBTN4()
            self.createHomeBTN4()
            self.createBuyBTNRest4()
        }
        
        else if colorVar == 5 {
            self.createGameLabel5()
            self.createRestartBTN5()
            self.createHomeBTN5()
            self.createBuyBTNRest5()
        }
        
        else if colorVar == 6 {
            self.createGameLabel6()
            self.createRestartBTN6()
            self.createHomeBTN6()
            self.createBuyBTNRest6()
        }
    }

//--- Buy screen
    
    func buyScene(){
        self.addChild(starLbl)
        self.addChild(starPic)
        self.addChild(boxGold)

        //back button 1
        backBTN1 = SKSpriteNode(imageNamed: "backBTN1")
        backBTN1.setScale(0.8)
        backBTN1.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 + 320 )
        backBTN1.zPosition = 5
        
        //back button 2
        backBTN2 = SKSpriteNode(imageNamed: "backBTN2")
        backBTN2.setScale(0.8)
        backBTN2.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 + 320 )
        backBTN2.zPosition = 5
        
        //back button 3
        backBTN3 = SKSpriteNode(imageNamed: "backBTN3")
        backBTN3.setScale(0.8)
        backBTN3.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 + 320 )
        backBTN3.zPosition = 5
        
        //back button 4
        backBTN4 = SKSpriteNode(imageNamed: "backBTN4")
        backBTN4.setScale(0.8)
        backBTN4.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 + 320 )
        backBTN4.zPosition = 5
        
        //back button 5
        backBTN5 = SKSpriteNode(imageNamed: "backBTN5")
        backBTN5.setScale(0.8)
        backBTN5.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 + 320 )
        backBTN5.zPosition = 5
        
        //back button 6
        backBTN6 = SKSpriteNode(imageNamed: "backBTN6")
        backBTN6.setScale(0.8)
        backBTN6.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 + 320 )
        backBTN6.zPosition = 5
        
        //bigBar
        bigBar.fillColor =  darkGrey
        bigBar.path = UIBezierPath(roundedRect: CGRect(x: 100, y: 100, width: 500, height: 380), cornerRadius: 5).cgPath
        bigBar.physicsBody?.isDynamic          = false
        bigBar.physicsBody?.affectedByGravity  = false
        bigBar.position = CGPoint(x: self.frame.width / 2 - 350, y:self.frame.height/2 - 550)
        bigBar.strokeColor = darkGrey
        zPosition = 8
        self.addChild(bigBar)
        
        //color button 1
        colorBTN1 = SKSpriteNode(imageNamed: "colorCombo1")
        colorBTN1.setScale(0.5)
        colorBTN1.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 - 150 )
        colorBTN1.zPosition = 5
        self.addChild(colorBTN1)

        //color button 2
        colorBTN2 = SKSpriteNode(imageNamed: "colorCombo2")
        colorBTN2.setScale(0.5)
        colorBTN2.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 150 )
        colorBTN2.zPosition = 5
        self.addChild(colorBTN2)
        
        //color button 3
        colorBTN3 = SKSpriteNode(imageNamed: "colorCombo3")
        colorBTN3.setScale(0.5)
        colorBTN3.position = CGPoint(x: self.frame.width / 2 + 140, y:self.frame.height/2 - 150 )
        colorBTN3.zPosition = 5
        self.addChild(colorBTN3)

        //color button 4
        colorBTN4 = SKSpriteNode(imageNamed: "colorCombo4")
        colorBTN4.setScale(0.5)
        colorBTN4.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 - 300 )
        colorBTN4.zPosition = 5
        self.addChild(colorBTN4)

        //color button 5
        colorBTN5 = SKSpriteNode(imageNamed: "colorCombo5")
        colorBTN5.setScale(0.5)
        colorBTN5.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 300 )
        colorBTN5.zPosition = 5
        self.addChild(colorBTN5)

        //color button 6
        colorBTN6 = SKSpriteNode(imageNamed: "colorCombo6")
        colorBTN6.setScale(0.5)
        colorBTN6.position = CGPoint(x: self.frame.width / 2 + 140, y:self.frame.height/2 - 300 )
        colorBTN6.zPosition = 5
        self.addChild(colorBTN6)
        
        goldenHexagon()
        
        if colorVar == 1 {
            colorShow1()
            addChild(backBTN1)
            if unlockColor1 == 0{
                createBuyColorBTN()
            }
            else {
                if superSelect == 1 {
                    createSelectBTN2()
                }
                else {
                    createSelectBTN()
                }
            }
        }
        
        else if colorVar == 2 {
            colorShow2()
            addChild(backBTN2)
            if unlockColor2 == 0{
                createBuyColorBTN()
            }
            else {
                if superSelect == 2 {
                    createSelectBTN2()
                }
                else {
                    createSelectBTN()
                }
            }
        }
        
        else if colorVar == 3 {
            colorShow3()
            addChild(backBTN3)
            if unlockColor3 == 0{
                createBuyColorBTN()
            }
            else {
                if superSelect == 3 {
                    createSelectBTN2()
                }
                else {
                    createSelectBTN()
                }
            }
        }
        
        else if colorVar == 4 {
            colorShow4()
            addChild(backBTN4)
            if unlockColor4 == 0{
                createBuyColorBTN()
            }
            else {
                if superSelect == 4 {
                    createSelectBTN2()
                }
                else {
                    createSelectBTN()
                }
            }
        }
        
        else if colorVar == 5 {
            colorShow5()
            addChild(backBTN5)
            if unlockColor5 == 0{
                createBuyColorBTN()
            }
            else {
                if superSelect == 5 {
                    createSelectBTN2()
                }
                else {
                    createSelectBTN()
                }
            }
        }
        
        else if colorVar == 6 {
            colorShow6()
            addChild(backBTN6)
            if unlockColor6 == 0{
                createBuyColorBTN()
            }
            else {
                if superSelect == 6 {
                    createSelectBTN2()
                }
                else {
                    createSelectBTN()
                }
            }
        }
        
        
    onBuyScene = 1
    }
    
    func goldenHexagon() {
        print("##################")
        if superSelect == 1 {
            colorBTN1.removeFromParent()
            colorBTN1Gold = SKSpriteNode(imageNamed: "colorCombo1Gold")
            colorBTN1Gold.setScale(0.5)
            colorBTN1Gold.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 - 150)
            colorBTN1Gold.zPosition = 6
            self.addChild(colorBTN1Gold)
        }
        else if superSelect == 2 {
            colorBTN2.removeFromParent()
            colorBTN2Gold = SKSpriteNode(imageNamed: "colorCombo2Gold")
            colorBTN2Gold.setScale(0.5)
            colorBTN2Gold.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 - 150 )
            colorBTN2Gold.zPosition = 6
            self.addChild(colorBTN2Gold)
        }
        else if superSelect == 3 {
            colorBTN3.removeFromParent()
            colorBTN3Gold = SKSpriteNode(imageNamed: "colorCombo3Gold")
            colorBTN3Gold.setScale(0.5)
            colorBTN3Gold.position = CGPoint(x: self.frame.width / 2 + 140, y:self.frame.height/2 - 150 )
            colorBTN3Gold.zPosition = 6
            self.addChild(colorBTN3Gold)
        }
        else if superSelect == 4 {
            colorBTN4.removeFromParent()
            colorBTN4Gold = SKSpriteNode(imageNamed: "colorCombo4Gold")
            colorBTN4Gold.setScale(0.5)
            colorBTN4Gold.position = CGPoint(x: self.frame.width / 2 - 140, y:self.frame.height/2 - 300 )
            colorBTN4Gold.zPosition = 6
            self.addChild(colorBTN4Gold)
        }
        else if superSelect == 5 {
            colorBTN5.removeFromParent()
            colorBTN5Gold = SKSpriteNode(imageNamed: "colorCombo5Gold")
            colorBTN5Gold.setScale(0.5)
            colorBTN5Gold.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 300 )
            colorBTN5Gold.zPosition = 6
            self.addChild(colorBTN5Gold)
        }
        else if superSelect == 6 {
            colorBTN6.removeFromParent()
            colorBTN6Gold = SKSpriteNode(imageNamed: "colorCombo6Gold")
            colorBTN6Gold.setScale(0.5)
            colorBTN6Gold.position = CGPoint(x: self.frame.width / 2 + 140, y:self.frame.height/2 - 300 )
            colorBTN6Gold.zPosition = 6
            self.addChild(colorBTN6Gold)
        }
    }
    
//big colorHex1
    func colorShow1() {
        colorHex2.removeFromParent()
        colorHex3.removeFromParent()
        colorHex4.removeFromParent()
        colorHex5.removeFromParent()
        colorHex6.removeFromParent()
        
        colorHex1 = SKSpriteNode(imageNamed: "colorCombo1")
        colorHex1.setScale(1.3)
        colorHex1.position = CGPoint(x:self.frame.width / 2 , y:self.frame.height/2 + 175 )
        colorHex1.zPosition = 5
        self.addChild(colorHex1)
    }

//big colorHex2
    func colorShow2() {
        colorHex1.removeFromParent()
        colorHex3.removeFromParent()
        colorHex4.removeFromParent()
        colorHex5.removeFromParent()
        colorHex6.removeFromParent()
        
        colorHex2 = SKSpriteNode(imageNamed: "colorCombo2")
        colorHex2.setScale(1.3)
        colorHex2.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 + 175 )
        colorHex2.zPosition = 5
        self.addChild(colorHex2)
    }
    
//big colorHex3
    func colorShow3() {
        colorHex1.removeFromParent()
        colorHex2.removeFromParent()
        colorHex4.removeFromParent()
        colorHex5.removeFromParent()
        colorHex6.removeFromParent()

        colorHex3 = SKSpriteNode(imageNamed: "colorCombo3")
        colorHex3.setScale(1.3)
        colorHex3.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 + 175 )
        colorHex3.zPosition = 5
        self.addChild(colorHex3)
    }

//big colorHex4
    func colorShow4() {
        colorHex1.removeFromParent()
        colorHex2.removeFromParent()
        colorHex3.removeFromParent()
        colorHex5.removeFromParent()
        colorHex6.removeFromParent()

        colorHex4 = SKSpriteNode(imageNamed: "colorCombo4")
        colorHex4.setScale(1.3)
        colorHex4.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 + 175 )
        colorHex4.zPosition = 5
        self.addChild(colorHex4)
    }

//big colorHex5
    func colorShow5() {
        colorHex1.removeFromParent()
        colorHex2.removeFromParent()
        colorHex3.removeFromParent()
        colorHex4.removeFromParent()
        colorHex6.removeFromParent()

        colorHex5 = SKSpriteNode(imageNamed: "colorCombo5")
        colorHex5.setScale(1.3)
        colorHex5.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 + 175 )
        colorHex5.zPosition = 5
        self.addChild(colorHex5)
    }

//big colorHex6
    func colorShow6() {
        colorHex1.removeFromParent()
        colorHex2.removeFromParent()
        colorHex3.removeFromParent()
        colorHex4.removeFromParent()
        colorHex5.removeFromParent()

        colorHex6 = SKSpriteNode(imageNamed: "colorCombo6")
        colorHex6.setScale(1.3)
        colorHex6.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 + 175 )
        colorHex6.zPosition = 5
        self.addChild(colorHex6)
    }
    
//buy button for color
    func createBuyColorBTN() {
        buyColorBTN = SKSpriteNode(imageNamed: "buyColorBTN")
        buyColorBTN.setScale(1.7)
        buyColorBTN.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 - 25)
        buyColorBTN.zPosition = 5
        self.addChild(buyColorBTN)
    }
    
//select button for color
    func createSelectBTN() {
        selectBTN1 = SKSpriteNode(imageNamed: "selectBTN1")
        selectBTN1.setScale(0.7)
        selectBTN1.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 - 25 )
        selectBTN1.zPosition = 5
        self.addChild(selectBTN1)
    }
    
    func createSelectBTN2() {
        selectBTN2 = SKSpriteNode(imageNamed: "selectBTN2")
        selectBTN2.setScale(0.7)
        selectBTN2.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 - 25 )
        selectBTN2.zPosition = 5
        self.addChild(selectBTN2)
    }

    
//----------- no ads
    
    func createNoAds() {
        noAdBTN = SKSpriteNode(imageNamed: "noAds1Square")
        noAdBTN.setScale(1.0)
        noAdBTN.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 260)
        noAdBTN.zPosition = 5
        self.addChild(noAdBTN)
    }
    
//--- no ads  color 2
    
    func createNoAds22() {
        noAdBTN22 = SKSpriteNode(imageNamed: "noAds2Square")
        noAdBTN22.setScale(1.0)
        noAdBTN22.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 260)
        noAdBTN22.zPosition = 5
        self.addChild(noAdBTN22)
    }
    
//--- no ads  color 3
    
    func createNoAds3() {
        noAdBTN3 = SKSpriteNode(imageNamed: "noAds3Square")
        noAdBTN3.setScale(1.0)
        noAdBTN3.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 260)
        noAdBTN3.zPosition = 5
        self.addChild(noAdBTN3)
    }
    
//--- no ads  color 4
    
    func createNoAds4() {
        noAdBTN4 = SKSpriteNode(imageNamed: "noAds4Square")
        noAdBTN4.setScale(1.0)
        noAdBTN4.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 260)
        noAdBTN4.zPosition = 5
        self.addChild(noAdBTN4)
    }
    
//--- no ads  color 5
    
    func createNoAds5() {
        noAdBTN5 = SKSpriteNode(imageNamed: "noAds5Square")
        noAdBTN5.setScale(1.0)
        noAdBTN5.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 260)
        noAdBTN5.zPosition = 5
        self.addChild(noAdBTN5)
    }

//--- no ads  color 6
    
    func createNoAds6() {
        noAdBTN6 = SKSpriteNode(imageNamed: "noAds6Square")
        noAdBTN6.setScale(1.0)
        noAdBTN6.position = CGPoint(x: self.frame.width / 2 , y:self.frame.height/2 - 260)
        noAdBTN6.zPosition = 5
        self.addChild(noAdBTN6)
    }
    
    
//------------- Game labels
    func createGameLabel() {
        gameLabel = SKSpriteNode(imageNamed: "dodgePic")
        gameLabel.setScale(1.31)
        gameLabel.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-80)
        gameLabel.zPosition = 5
        self.addChild(gameLabel)
    }

//--- Game label22
    func createGameLabel22() {
        gameLabel22 = SKSpriteNode(imageNamed: "dodgePic7")
        gameLabel22.setScale(1.31)
        gameLabel22.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-80)
        gameLabel22.zPosition = 5
        self.addChild(gameLabel22)
    }
    
//--- Game label3
    func createGameLabel3() {
        gameLabel3 = SKSpriteNode(imageNamed: "dodgePic3")
        gameLabel3.setScale(1.31)
        gameLabel3.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-80)
        gameLabel3.zPosition = 5
        self.addChild(gameLabel3)
    }
    
//--- Game label4
    func createGameLabel4() {
        gameLabel4 = SKSpriteNode(imageNamed: "dodgePic4")
        gameLabel4.setScale(1.31)
        gameLabel4.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-80)
        gameLabel4.zPosition = 5
        self.addChild(gameLabel4)
    }
    
//--- Game label5
    func createGameLabel5() {
        gameLabel5 = SKSpriteNode(imageNamed: "dodgePic5")
        gameLabel5.setScale(1.31)
        gameLabel5.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-80)
        gameLabel5.zPosition = 5
        self.addChild(gameLabel5)
    }
    
//--- Game label6
    func createGameLabel6() {
        gameLabel6 = SKSpriteNode(imageNamed: "dodgePic6.2")
        gameLabel6.setScale(1.31)
        gameLabel6.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-80)
        gameLabel6.zPosition = 5
        self.addChild(gameLabel6)
    }

//--- Corners top left
    func createCorners() {
        corner1 = SKSpriteNode(imageNamed: "corner")
        corner1.setScale(1.61)
        corner1.position = CGPoint(x: self.frame.width / 2 - 212, y:self.frame.height / 2 + 379.7)
        corner1.zPosition = 5
        self.addChild(corner1)
        
        corner2 = SKSpriteNode(imageNamed: "corner2")
        corner2.setScale(1.61)
        corner2.position = CGPoint(x: self.frame.width / 2 + 211.5, y:self.frame.height / 2 + 379)
        corner2.zPosition = 5
        self.addChild(corner2)
        
        corner3 = SKSpriteNode(imageNamed: "corner3")
        corner3.setScale(1.61)
        corner3.position = CGPoint(x: self.frame.width / 2 + 212, y:self.frame.height / 2 - 379.7)
        corner3.zPosition = 5
        self.addChild(corner3)
        
        corner4 = SKSpriteNode(imageNamed: "corner4")
        corner4.setScale(1.61)
        corner4.position = CGPoint(x: self.frame.width / 2 - 212, y:self.frame.height / 2 - 379.7)
        corner4.zPosition = 5
        self.addChild(corner4)
    }
    


//--- create restart button (when holding finger on button)
    
    func createRestartBTN2(){
        
        self.restartBTN2 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
        self.restartBTN2.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
        self.restartBTN2.zPosition = 4
        self.addChild(self.restartBTN2)

        self.resetBTN2 = SKSpriteNode(imageNamed: "Reset-Button1Square")
        self.resetBTN2.size = CGSize(width: 140, height: 140)
        self.resetBTN2.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
        self.resetBTN2.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN2.size)
        self.resetBTN2.physicsBody?.affectedByGravity = true
        self.resetBTN2.physicsBody?.isDynamic = false
        self.resetBTN2.zPosition = 7
        self.addChild(self.resetBTN2)
    }

//------------ create restart buttons (normal)
    
    func createRestartBTN(){
        
        delay(restartDelay) {
            self.restartBTN = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN.zPosition = 4
            self.addChild(self.restartBTN)
            
            self.resetBTN = SKSpriteNode(imageNamed: "Reset-Button1Square")
            self.resetBTN.size = CGSize(width: 140, height: 140)
            self.resetBTN.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN.size)
            self.resetBTN.physicsBody?.affectedByGravity = true
            self.resetBTN.physicsBody?.isDynamic = false
            self.resetBTN.zPosition = 6
            self.addChild(self.resetBTN)
        }
    }
    
//--- create restart button color 2
    
    func createRestartBTN22(){
        
        delay(restartDelay) {
            self.restartBTN22 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN22.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN22.zPosition = 4
            self.addChild(self.restartBTN22)
            
            self.resetBTN22 = SKSpriteNode(imageNamed: "Reset-Button2Square")
            self.resetBTN22.size = CGSize(width: 140, height: 140)
            self.resetBTN22.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN22.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN22.size)
            self.resetBTN22.physicsBody?.affectedByGravity = true
            self.resetBTN22.physicsBody?.isDynamic = false
            self.resetBTN22.zPosition = 7
            self.addChild(self.resetBTN22)
        }
    }
    
//--- create restart button color 3
    
    func createRestartBTN3(){
        
        delay(restartDelay) {
            self.restartBTN3 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN3.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN3.zPosition = 4
            self.addChild(self.restartBTN3)
            
            self.resetBTN3 = SKSpriteNode(imageNamed: "Reset-Button3Square")
            self.resetBTN3.size = CGSize(width: 140, height: 140)
            self.resetBTN3.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN3.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN22.size)
            self.resetBTN3.physicsBody?.affectedByGravity = true
            self.resetBTN3.physicsBody?.isDynamic = false
            self.resetBTN3.zPosition = 7
            self.addChild(self.resetBTN3)
        }
    }

//--- create restart button color 4
    
    func createRestartBTN4(){
        
        delay(restartDelay) {
            self.restartBTN4 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN4.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN4.zPosition = 4
            self.addChild(self.restartBTN4)
            
            self.resetBTN4 = SKSpriteNode(imageNamed: "Reset-Button4Square")
            self.resetBTN4.size = CGSize(width: 140, height: 140)
            self.resetBTN4.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN4.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN22.size)
            self.resetBTN4.physicsBody?.affectedByGravity = true
            self.resetBTN4.physicsBody?.isDynamic = false
            self.resetBTN4.zPosition = 7
            self.addChild(self.resetBTN4)
        }
    }

//--- create restart button color 5
    
    func createRestartBTN5(){
        
        delay(restartDelay) {
            self.restartBTN5 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN5.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN5.zPosition = 4
            self.addChild(self.restartBTN5)
            
            self.resetBTN5 = SKSpriteNode(imageNamed: "Reset-Button5Square")
            self.resetBTN5.size = CGSize(width: 140, height: 140)
            self.resetBTN5.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN5.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN22.size)
            self.resetBTN5.physicsBody?.affectedByGravity = true
            self.resetBTN5.physicsBody?.isDynamic = false
            self.resetBTN5.zPosition = 7
            self.addChild(self.resetBTN5)
        }
    }

//--- create restart button color 6
    
    func createRestartBTN6(){
        
        delay(restartDelay) {
            self.restartBTN6 = SKSpriteNode(color: SKColor.clear, size: CGSize(width: 140, height: 140))
            self.restartBTN6.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.restartBTN6.zPosition = 4
            self.addChild(self.restartBTN6)
            
            self.resetBTN6 = SKSpriteNode(imageNamed: "Reset-Button6Square")
            self.resetBTN6.size = CGSize(width: 140, height: 140)
            self.resetBTN6.position = CGPoint(x: self.frame.width * 0.5, y: self.frame.height  - 600)
            self.resetBTN6.physicsBody = SKPhysicsBody(rectangleOf: self.resetBTN22.size)
            self.resetBTN6.physicsBody?.affectedByGravity = true
            self.resetBTN6.physicsBody?.isDynamic = false
            self.resetBTN6.zPosition = 7
            self.addChild(self.resetBTN6)
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
    
    
//--- play button 2 (when holding down)
    
    func createPlayBTN2() {
        playBTN = SKSpriteNode(imageNamed: "playBTN1Square")
        playBTN.setScale(1.3)
        playBTN.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110)
        playBTN.zPosition = 5
        self.addChild(playBTN)
    }

    
//---------- play buttons (normal)
    
    func createPlayBTN() {
        playBTN = SKSpriteNode(imageNamed: "playBTN1Square")
        playBTN.setScale(0.3)
        playBTN.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110 )
        playBTN.zPosition = 5
        self.addChild(playBTN)
    }
    
//--- play button color 2
    
    func createPlayBTN22() {
        playBTN22 = SKSpriteNode(imageNamed: "playBTN2Square")
        playBTN22.setScale(1.30)
        playBTN22.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110 )
        playBTN22.zPosition = 5
        self.addChild(playBTN22)
    }

//--- play button color 3
    
    func createPlayBTN3() {
        playBTN3 = SKSpriteNode(imageNamed: "playBTN3Square")
        playBTN3.setScale(1.30)
        playBTN3.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110 )
        playBTN3.zPosition = 5
        self.addChild(playBTN3)
    }
    
//--- play button color 4
    
    func createPlayBTN4() {
        playBTN4 = SKSpriteNode(imageNamed: "playBTN4Square")
        playBTN4.setScale(1.3)
        playBTN4.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110 )
        playBTN4.zPosition = 5
        self.addChild(playBTN4)
    }
    
//--- play button color 5
    
    func createPlayBTN5() {
        playBTN5 = SKSpriteNode(imageNamed: "playBTN5Square")
        playBTN5.setScale(1.3)
        playBTN5.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110 )
        playBTN5.zPosition = 5
        self.addChild(playBTN5)
    }
    
//--- play button color 6
    
    func createPlayBTN6() {
        playBTN6 = SKSpriteNode(imageNamed: "playBTN6Square")
        playBTN6.setScale(1.3)
        playBTN6.position = CGPoint(x: self.frame.width / 2, y:self.frame.height/2 + 110 )
        playBTN6.zPosition = 5
        self.addChild(playBTN6)
    }
    
//----------- rate buttons
    
    func createRateBTN2() {
        rateBTN = SKSpriteNode(imageNamed: "rateBTN1Square")
        rateBTN.setScale(1.0)
        rateBTN.position = CGPoint(x: self.frame.width / 2 - 90, y:self.frame.height/2 - 170 )
        rateBTN.zPosition = 5
        self.addChild(rateBTN)
    }
    
//--- rate button color 2
    
    func createRateBTN22() {
        rateBTN22 = SKSpriteNode(imageNamed: "rateBTN2Square")
        rateBTN22.setScale(1.0)
        rateBTN22.position = CGPoint(x: self.frame.width / 2 - 90, y:self.frame.height/2 - 170 )
        rateBTN22.zPosition = 5
        self.addChild(rateBTN22)
    }
    
//--- rate button color 3
    
    func createRateBTN3() {
        rateBTN3 = SKSpriteNode(imageNamed: "rateBTN3Square")
        rateBTN3.setScale(1.0)
        rateBTN3.position = CGPoint(x: self.frame.width / 2 - 90, y:self.frame.height/2 - 170 )
        rateBTN3.zPosition = 5
        self.addChild(rateBTN3)
    }

//--- rate button color 4
    
    func createRateBTN4() {
        rateBTN4 = SKSpriteNode(imageNamed: "rateBTN4Square")
        rateBTN4.setScale(1.0)
        rateBTN4.position = CGPoint(x: self.frame.width / 2 - 90, y:self.frame.height/2 - 170 )
        rateBTN4.zPosition = 5
        self.addChild(rateBTN4)
    }

//--- rate button color 5
    
    func createRateBTN5() {
        rateBTN5 = SKSpriteNode(imageNamed: "rateBTN5Square")
        rateBTN5.setScale(1.0)
        rateBTN5.position = CGPoint(x: self.frame.width / 2 - 90, y:self.frame.height/2 - 170 )
        rateBTN5.zPosition = 5
        self.addChild(rateBTN5)
    }

//--- rate button color 6
    
    func createRateBTN6() {
        rateBTN6 = SKSpriteNode(imageNamed: "rateBTN6Square")
        rateBTN6.setScale(1.0)
        rateBTN6.position = CGPoint(x: self.frame.width / 2 - 90, y:self.frame.height/2 - 170 )
        rateBTN6.zPosition = 5
        self.addChild(rateBTN6)
    }

//--- music button 1 (when music on)
    
    func createMusicBTN() {
        musicBTN = SKSpriteNode(imageNamed: "musicBTN1Square")
        musicBTN.setScale(1.0)
        musicBTN.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170 )
        musicBTN.zPosition = 5
        self.addChild(musicBTN)
    }
    
//--- music button 1 (when music on) color 2
    
    func createMusicBTN22() {
        musicBTN22 = SKSpriteNode(imageNamed: "musicBTN2Square")
        musicBTN22.setScale(1.0)
        musicBTN22.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170 )
        musicBTN22.zPosition = 5
        self.addChild(musicBTN22)
    }
    
    
//--- music button 1 (when music on) color 3
    
    func createMusicBTN3() {
        musicBTN3 = SKSpriteNode(imageNamed: "musicBTN3Square")
        musicBTN3.setScale(1.0)
        musicBTN3.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170 )
        musicBTN3.zPosition = 5
        self.addChild(musicBTN3)
    }

//--- music button 1 (when music on) color 4
    
    func createMusicBTN4() {
        musicBTN4 = SKSpriteNode(imageNamed: "musicBTN4Square")
        musicBTN4.setScale(1.0)
        musicBTN4.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170 )
        musicBTN4.zPosition = 5
        self.addChild(musicBTN4)
    }
    
//--- music button 1 (when music on) color 5
    
    func createMusicBTN5() {
        musicBTN5 = SKSpriteNode(imageNamed: "musicBTN5Square")
        musicBTN5.setScale(1.0)
        musicBTN5.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170 )
        musicBTN5.zPosition = 5
        self.addChild(musicBTN5)
    }
    
//--- music button 1 (when music on) color 6
    
    func createMusicBTN6() {
        musicBTN6 = SKSpriteNode(imageNamed: "musicBTN6Square")
        musicBTN6.setScale(1.0)
        musicBTN6.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170 )
        musicBTN6.zPosition = 5
        self.addChild(musicBTN6)
    }
    
//--- music button 2 (when music off)
    
    func createMusicBTN2() {
        musicBTN2 = SKSpriteNode(imageNamed: "musicBTNCross1Square")
        musicBTN2.setScale(1.0)
        musicBTN2.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170)
        musicBTN2.zPosition = 5
        self.addChild(musicBTN2)
    }
    
//--- music button 2 (when music off) color 2
    
    func createMusicBTNCross22() {
        musicBTNCross22 = SKSpriteNode(imageNamed: "musicBTNCross2Square")
        musicBTNCross22.setScale(1.0)
        musicBTNCross22.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170)
        musicBTNCross22.zPosition = 5
        self.addChild(musicBTNCross22)
    }
    
    //--- music button 2 (when music off) color 3
    
    func createMusicBTNCross3() {
        musicBTNCross3 = SKSpriteNode(imageNamed: "musicBTNCross3Square")
        musicBTNCross3.setScale(1.0)
        musicBTNCross3.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170)
        musicBTNCross3.zPosition = 5
        self.addChild(musicBTNCross3)
    }

    //--- music button 2 (when music off) color 4
    
    func createMusicBTNCross4() {
        musicBTNCross4 = SKSpriteNode(imageNamed: "musicBTNCross4Square")
        musicBTNCross4.setScale(1.0)
        musicBTNCross4.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170)
        musicBTNCross4.zPosition = 5
        self.addChild(musicBTNCross4)
    }

    //--- music button 2 (when music off) color 5
    
    func createMusicBTNCross5() {
        musicBTNCross5 = SKSpriteNode(imageNamed: "musicBTNCross5Square")
        musicBTNCross5.setScale(1.0)
        musicBTNCross5.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170)
        musicBTNCross5.zPosition = 5
        self.addChild(musicBTNCross5)
    }

    //--- music button 2 (when music off) color 6
    
    func createMusicBTNCross6() {
        musicBTNCross6 = SKSpriteNode(imageNamed: "musicBTNCross6Square")
        musicBTNCross6.setScale(1.0)
        musicBTNCross6.position = CGPoint(x: self.frame.width / 2 + 90, y:self.frame.height/2 - 170)
        musicBTNCross6.zPosition = 5
        self.addChild(musicBTNCross6)
    }

    
//--- home button 1
    
    func createHomeBTN1() {
        delay(restartDelay) {
            self.homeBTN1 = SKSpriteNode(imageNamed: "backBTN1")
            self.homeBTN1.setScale(0.8)
            self.homeBTN1.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 600)
            self.homeBTN1.zPosition = 5
            self.addChild(self.homeBTN1)
        }
    }
    

//--- home button 2
    
    func createHomeBTN2() {
        homeBTN2 = SKSpriteNode(imageNamed: "backBTN2")
        homeBTN2.setScale(0.8)
        homeBTN2.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 600)
        homeBTN2.zPosition = 5
        self.addChild(homeBTN2)
    }

    //--- home button 3
    
    func createHomeBTN3() {
        homeBTN3 = SKSpriteNode(imageNamed: "backBTN3")
        homeBTN3.setScale(0.8)
        homeBTN3.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 600)
        homeBTN3.zPosition = 5
        self.addChild(homeBTN3)
    }
    //--- home button 4
    
    func createHomeBTN4() {
        homeBTN4 = SKSpriteNode(imageNamed: "backBTN4")
        homeBTN4.setScale(0.8)
        homeBTN4.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 600)
        homeBTN4.zPosition = 5
        self.addChild(homeBTN4)
    }
    //--- home button 5
    
    func createHomeBTN5() {
        homeBTN5 = SKSpriteNode(imageNamed: "backBTN5")
        homeBTN5.setScale(0.8)
        homeBTN5.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 600)
        homeBTN5.zPosition = 5
        self.addChild(homeBTN5)
    }
    //--- home button 6
    
    func createHomeBTN6() {
        homeBTN6 = SKSpriteNode(imageNamed: "backBTN6")
        homeBTN6.setScale(0.8)
        homeBTN6.position = CGPoint(x: self.frame.width * 0.5 - 150, y: self.frame.height  - 600)
        homeBTN6.zPosition = 5
        self.addChild(homeBTN6)
    }
    
    
//--- buy buttons (for home screen)
    
    func createBuyBTNHome1() {
        delay(restartDelay) {
            self.buyBTNHome1 = SKSpriteNode(imageNamed: "buyBTN1Square")
            self.buyBTNHome1.setScale(1.0)
            self.buyBTNHome1.position = CGPoint(x: self.frame.width / 2, y: self.frame.height/2 - 80)
            self.buyBTNHome1.zPosition = 6
            self.addChild(self.buyBTNHome1)
        }
    }
    
    func createBuyBTNHome2() {
        delay(restartDelay) {
            self.buyBTNHome2 = SKSpriteNode(imageNamed: "buyBTN2Square")
            self.buyBTNHome2.setScale(1.0)
            self.buyBTNHome2.position = CGPoint(x: self.frame.width / 2, y: self.frame.height/2 - 80)
            self.buyBTNHome2.zPosition = 6
            self.addChild(self.buyBTNHome2)
        }
    }
    
    func createBuyBTNHome3() {
        delay(restartDelay) {
            self.buyBTNHome3 = SKSpriteNode(imageNamed: "buyBTN3Square")
            self.buyBTNHome3.setScale(1.0)
            self.buyBTNHome3.position = CGPoint(x: self.frame.width / 2, y: self.frame.height/2 - 80)
            self.buyBTNHome3.zPosition = 6
            self.addChild(self.buyBTNHome3)
        }
    }
    
    func createBuyBTNHome4() {
        delay(restartDelay) {
            self.buyBTNHome4 = SKSpriteNode(imageNamed: "buyBTN4Square")
            self.buyBTNHome4.setScale(1.0)
            self.buyBTNHome4.position = CGPoint(x: self.frame.width / 2, y: self.frame.height/2 - 80)
            self.buyBTNHome4.zPosition = 6
            self.addChild(self.buyBTNHome4)
        }
    }
    
    func createBuyBTNHome5() {
        delay(restartDelay) {
            self.buyBTNHome5 = SKSpriteNode(imageNamed: "buyBTN5Square")
            self.buyBTNHome5.setScale(1.0)
            self.buyBTNHome5.position = CGPoint(x: self.frame.width / 2, y: self.frame.height/2 - 80)
            self.buyBTNHome5.zPosition = 6
            self.addChild(self.buyBTNHome5)
        }
    }
    
    func createBuyBTNHome6() {
        delay(restartDelay) {
            self.buyBTNHome6 = SKSpriteNode(imageNamed: "buyBTN6Square")
            self.buyBTNHome6.setScale(1.0)
            self.buyBTNHome6.position = CGPoint(x: self.frame.width / 2, y: self.frame.height/2 - 80)
            self.buyBTNHome6.zPosition = 6
            self.addChild(self.buyBTNHome6)
        }
    }
    
//--- buy buttons (for restart screen)
    
    func createBuyBTNRest1() {
        delay(restartDelay) {
            self.buyBTNRest1 = SKSpriteNode(imageNamed: "buyBTN1Square")
            self.buyBTNRest1.setScale(0.8)
            self.buyBTNRest1.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height - 600)
            self.buyBTNRest1.zPosition = 6
            self.addChild(self.buyBTNRest1)
        }
    }
    
    func createBuyBTNRest2() {
        delay(restartDelay) {
            self.buyBTNRest2 = SKSpriteNode(imageNamed: "buyBTN2Square")
            self.buyBTNRest2.setScale(0.8)
            self.buyBTNRest2.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height - 600)
            self.buyBTNRest2.zPosition = 6
            self.addChild(self.buyBTNRest2)
        }
    }

    func createBuyBTNRest3() {
        delay(restartDelay) {
            self.buyBTNRest3 = SKSpriteNode(imageNamed: "buyBTN3Square")
            self.buyBTNRest3.setScale(0.8)
            self.buyBTNRest3.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height - 600)
            self.buyBTNRest3.zPosition = 6
            self.addChild(self.buyBTNRest3)
        }
    }

    func createBuyBTNRest4() {
        delay(restartDelay) {
            self.buyBTNRest4 = SKSpriteNode(imageNamed: "buyBTN4Square")
            self.buyBTNRest4.setScale(0.8)
            self.buyBTNRest4.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height - 600)
            self.buyBTNRest4.zPosition = 6
            self.addChild(self.buyBTNRest4)
        }
    }

    func createBuyBTNRest5() {
        delay(restartDelay) {
            self.buyBTNRest5 = SKSpriteNode(imageNamed: "buyBTN5Square")
            self.buyBTNRest5.setScale(0.8)
            self.buyBTNRest5.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height - 600)
            self.buyBTNRest5.zPosition = 6
            self.addChild(self.buyBTNRest5)
        }
    }

    func createBuyBTNRest6() {
        delay(restartDelay) {
            self.buyBTNRest6 = SKSpriteNode(imageNamed: "buyBTN6Square")
            self.buyBTNRest6.setScale(0.8)
            self.buyBTNRest6.position = CGPoint(x: self.frame.width / 2 + 150, y: self.frame.height - 600)
            self.buyBTNRest6.zPosition = 6
            self.addChild(self.buyBTNRest6)
        }
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
        
        let soundVarDefault = UserDefaults.standard
        soundVarDefault.setValue(soundVar, forKey: "soundVar")
        soundVarDefault.synchronize()

        
        // writing of score and highscore
        self.endScoreLbl = SKLabelNode(fontNamed: "Outage-Regular")
        self.endScoreLbl.text       = "Score"
        self.endScoreLbl.fontSize   = 45
        self.endScoreLbl.fontColor  = self.greyWhite
        self.endScoreLbl.horizontalAlignmentMode = .center
        self.endScoreLbl.position   = CGPoint(x: self.frame.width / 2, y:self.frame.height-271)
        self.endScoreLbl.zPosition  = 5
        self.addChild(self.endScoreLbl)
        
        self.endScoreLbl2 = SKLabelNode(fontNamed: "Outage-Regular")
        self.endScoreLbl2.text      = String(self.score)
        self.endScoreLbl2.fontSize  = 45
        self.endScoreLbl2.fontColor = self.red
        self.endScoreLbl2.horizontalAlignmentMode = .center
        self.endScoreLbl2.position  = CGPoint(x: self.frame.width / 2, y:self.frame.height-325)
        self.endScoreLbl2.zPosition = 5
        self.addChild(self.endScoreLbl2)
    
        self.endScoreLbl3 = SKLabelNode(fontNamed: "Outage-Regular")
        self.endScoreLbl3.text      = "Highscore"
        self.endScoreLbl3.fontSize  = 45
        self.endScoreLbl3.fontColor = self.greyWhite
        self.endScoreLbl3.horizontalAlignmentMode = .center
        self.endScoreLbl3.position  = CGPoint(x: self.frame.width / 2, y:self.frame.height-422.5)
        self.endScoreLbl3.zPosition = 5
        self.addChild(self.endScoreLbl3)
    
        self.endScoreLbl4 = SKLabelNode(fontNamed: "Outage-Regular")
        self.endScoreLbl4.text      = String(self.highscore)
        self.endScoreLbl4.fontSize  = 45
        self.endScoreLbl4.fontColor = self.darkGrey
        self.endScoreLbl4.horizontalAlignmentMode = .center
        self.endScoreLbl4.position  = CGPoint(x: self.frame.width / 2, y:self.frame.height-475)
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
        
        path8.move   (to: CGPoint(x: center8.x + CGFloat(length[iRan]),      y: center8.y))
        path8.addLine(to: CGPoint(x: center8.x + CGFloat(length[iRan]) - 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]) + 25, y: center8.y + 25))
        path8.addLine(to: CGPoint(x: center8.x - CGFloat(length[iRan]),      y: center8.y))
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


//--- 2 Create Island moving left and right   <====> starting right
    
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
        smallWallRight.position    = CGPoint(x: self.frame.width/2 - 210, y:frame.height-383)
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
        smallWallLeft.position    = CGPoint(x: self.frame.width/2 - 810, y:frame.height-383)
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
        smallWallRight.position    = CGPoint(x: self.frame.width/2 - 210, y:frame.height-383)
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
        smallWallLeft.position    = CGPoint(x: self.frame.width/2 - 810, y:frame.height-383)
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
        star  = SKNode()
        star1 = SKSpriteNode(imageNamed: "starGold")
        star1.name = "star1"
        star1.setScale(1.0)
        star1.size = CGSize(width: 40, height: 40)
        star1.position = CGPoint(x: self.frame.width / 2 + CGFloat(starVar) , y:self.frame.height / 2 + 383)
        star1.physicsBody = SKPhysicsBody(rectangleOf: star1.size)
        star1.physicsBody?.affectedByGravity = false
        star1.physicsBody?.isDynamic = false
        star1.physicsBody?.categoryBitMask = PhysicsCatagory.star1
        star1.physicsBody?.collisionBitMask = 0
        star1.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        star1.zPosition = 3
        
        star1.addChild(star)
        star1.run(moveAndRemoveStar)
        self.addChild(star1)
        print("STAR")
    }
    
    
//--- Mouse Click Began ---------------
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        /* Called when a touch begins */

        print("Mouse Click: ",playState, ball_dir)
        
        
        // state -1: home ----------------------
        
        if playState == -1 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if colorVar == 1 {
                    if playBTN.contains(location) && volumeVar == 0.3{
                        volumeVar = 0.0
                        trackPlayer.play()
                        print("******************************", trackPlayer.volume)
                    }
                
                    if playBTN.contains(location) && volumeVar == 0.0{
                        volumeVar = 0.0
                        trackPlayer.play()
                        print("******************************", trackPlayer.volume)

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
            
                    if noAdBTN.contains(location){
                    }
                
                    if buyBTNHome1.contains(location){
                    }
                    
                }
                
                else if colorVar == 2 {
                    if playBTN22.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.3
                    }
                    
                    if playBTN22.contains(location) && trackPlayer.volume == 0.0{
                        trackPlayer.volume = 0.0
                    }
                    
                    if rateBTN22.contains(location){
                    }
                    
                    if musicBTN22.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.0
                        print("---MusicBTN touch begin---", trackPlayer.volume)
                    }
                        
                    else {
                        trackPlayer.volume = 0.3
                        print("-------MusicBTN2 touch begin-------", trackPlayer.volume)
                    }
                    
                    if noAdBTN22.contains(location){
                    }
                    
                    if buyBTNHome2.contains(location){
                    }
                }
                
                else if colorVar == 3 {
                    if playBTN3.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.3
                    }
                    
                    if playBTN3.contains(location) && trackPlayer.volume == 0.0{
                        trackPlayer.volume = 0.0
                    }
                    
                    if rateBTN3.contains(location){
                    }
                    
                    if musicBTN3.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.0
                        print("---MusicBTN touch begin---", trackPlayer.volume)
                    }
                        
                    else {
                        trackPlayer.volume = 0.3
                        print("-------MusicBTN2 touch begin-------", trackPlayer.volume)
                    }
                    
                    if noAdBTN3.contains(location){
                    }
                    
                    if buyBTNHome3.contains(location){
                    }
                }

                else if colorVar == 4 {
                    if playBTN4.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.3
                    }
                    
                    if playBTN4.contains(location) && trackPlayer.volume == 0.0{
                        trackPlayer.volume = 0.0
                    }
                    
                    if rateBTN4.contains(location){
                    }
                    
                    if musicBTN4.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.0
                        print("---MusicBTN touch begin---", trackPlayer.volume)
                    }
                        
                    else {
                        trackPlayer.volume = 0.3
                        print("-------MusicBTN2 touch begin-------", trackPlayer.volume)
                    }
                    
                    if noAdBTN4.contains(location){
                    }
                    
                    if buyBTNHome4.contains(location){
                    }
                }

                else if colorVar == 5 {
                    if playBTN5.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.3
                    }
                    
                    if playBTN5.contains(location) && trackPlayer.volume == 0.0{
                        trackPlayer.volume = 0.0
                    }
                    
                    if rateBTN5.contains(location){
                    }
                    
                    if musicBTN5.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.0
                        print("---MusicBTN touch begin---", trackPlayer.volume)
                    }
                        
                    else {
                        trackPlayer.volume = 0.3
                        print("-------MusicBTN2 touch begin-------", trackPlayer.volume)
                    }
                    
                    if noAdBTN5.contains(location){
                    }
                    
                    if buyBTNHome5.contains(location){
                    }
                }

                else if colorVar == 6 {
                    if playBTN6.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.3
                    }
                    
                    if playBTN6.contains(location) && trackPlayer.volume == 0.0{
                        trackPlayer.volume = 0.0
                    }
                    
                    if rateBTN6.contains(location){
                    }
                    
                    if musicBTN6.contains(location) && trackPlayer.volume == 0.3{
                        trackPlayer.volume = 0.0
                        print("---MusicBTN touch begin---", trackPlayer.volume)
                    }
                        
                    else {
                        trackPlayer.volume = 0.3
                        print("-------MusicBTN2 touch begin-------", trackPlayer.volume)
                    }
                    
                    if noAdBTN22.contains(location){
                    }
                    
                    if buyBTNHome6.contains(location){
                    }
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
            print("createStars: star1", star1, "star: ",star)

            //let spawnFallBall = SKAction.run({
            //    () in
            //    self.obstacle()
            //})
            
            wallDir = wallDir1
            
            // move walls down (called in functions createWallsRight and Left)
            
            let distanceWall = self.frame.width + wallPairRight.frame.width
            
            //iRan = Int(arc4random_uniform(3))
            
            // right walls
            let moveWallRight        = SKAction.moveBy(x: CGFloat(ball_dir) * CGFloat(xwallMove2), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallRight      = SKAction.removeFromParent()
            moveAndRemoveRight       = SKAction.sequence([moveWallRight, removeWallRight])
            
            // left walls
            let moveWallLeft         = SKAction.moveBy(x: CGFloat(ball_dir) * CGFloat(xwallMove2) * (-1), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallLeft       = SKAction.removeFromParent()
            moveAndRemoveLeft        = SKAction.sequence([moveWallLeft, removeWallLeft])
            
            // chomp wall right
            let moveWallChompRight   = SKAction.moveBy(x: CGFloat(ball_dir) * CGFloat(xwallMove2) * (-0.5), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallChompRight = SKAction.removeFromParent()
            moveAndRemoveChompRight  = SKAction.sequence([moveWallChompRight, removeWallChompRight])
            
            // chomp wall left
            let moveWallChompLeft    = SKAction.moveBy(x: CGFloat(ball_dir) * CGFloat(xwallMove2) * (0.5), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeWallChompLeft  = SKAction.removeFromParent()
            moveAndRemoveChompLeft   = SKAction.sequence([moveWallChompLeft, removeWallChompLeft])
            
            // island starting left
            let moveIslandLeft       = SKAction.moveBy(x: CGFloat(islandVar) * CGFloat(ball_dir) * CGFloat(xwallMove2), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
            let removeIslandLeft     = SKAction.removeFromParent()
            moveAndRemoveIslandLeft  = SKAction.sequence([moveIslandLeft, removeIslandLeft])
            
            // island starting right
            let moveIslandRight      = SKAction.moveBy(x: CGFloat(-islandVar) * CGFloat(ball_dir) * CGFloat(xwallMove2), y: -distanceWall, duration: TimeInterval(distanceWall/velocityWall))
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
                
//              spawnIslandRight , delayHalf, spawnStar, delayHalf, spawnIslandLeft,  delayHalf, spawnStar, delayHalf,
//              spawnIslandRight2, delayHalf, spawnStar, delayHalf, spawnIslandLeft2, delayHalf, spawnStar, delayHalf ])
            let spawnDelayForever    = SKAction.repeatForever(spawnDelay)
            self.run(spawnDelayForever)
            
            //self.physicsWorld.gravity = CGVector(dx: CGFloat(islandAcc - xvelocity), dy: CGFloat(-ygravity))
            
            playState = 1

            print("Create walls, game started",playState)
        }
        
        // state 1: Play ----------------------
        
        if playState == 1 {
            randPos = Int(arc4random_uniform(150)) + 450

            
            print("random: !!!!!!!!!!", randPos)

            
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
                    }
                if restartBTN22.contains(location){
                }
                if restartBTN3.contains(location){
                }
                if restartBTN4.contains(location){
                }
                if restartBTN5.contains(location){
                }
                if restartBTN6.contains(location){
                }
                if homeBTN1.contains(location){
                }
                if buyBTNRest1.contains(location){
                }
            }
        }
        
        // state 5: Buy Screen ------------------------
        
        if playState == 5 {
            for touch in touches{
                let location = touch.location(in: self)
                
                if backBTN1.contains(location) || backBTN2.contains(location) || backBTN3.contains(location) || backBTN4.contains(location) || backBTN5.contains(location) || backBTN6.contains(location) {
                }
                
                if colorBTN1.contains(location){
                }
                if colorBTN2.contains(location){
                }
                if colorBTN3.contains(location){
                }
                if colorBTN4.contains(location){
                }
                if colorBTN5.contains(location){
                }
                if colorBTN6.contains(location){
                }
                if buyColorBTN.contains(location){
                }
            }
        }
    }
   
    
//--- Mouse Click Ended
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        onBuyScene = 3

        if playState == -1 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if colorVar == 1 {
                    if playBTN.contains(location){
                        playState = 0
                        removeAllChildren()
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
                
                    if buyBTNHome1.contains(location){
                        removeAllChildren()
                        removeAllActions()
                        playState = 5
                        homeOrRestart = 1
                        buyScene()
                        onBuyScene = 2
                    }
                }
                
                else if colorVar == 2 {
                    if playBTN22.contains(location){
                            playState = 0
                            removeAllChildren()
                            createScene()
                    }
                    
                    if rateBTN22.contains(location){
                    }
                    
                    
                    if musicBTN22.contains(location) && trackPlayer.volume == 0.0{
                        musicBTN22.removeFromParent()
                        createMusicBTNCross22()
                        print("*** End Touch musicBTN ***", trackPlayer.volume)
                    }
                    
                    if musicBTNCross22.contains(location) && trackPlayer.volume == 0.3{
                        musicBTNCross22.removeFromParent()
                        createMusicBTN22()
                        print("*** End Touch musicBTN2 ***", trackPlayer.volume)
                    }
                    
                    if buyBTNHome2.contains(location){
                        removeAllChildren()
                        removeAllActions()
                        playState = 5
                        homeOrRestart = 1
                        buyScene()
                    }
                }
                
                else if colorVar == 3 {
                    if playBTN3.contains(location){
                        playState = 0
                        removeAllChildren()
                        createScene()
                    }
                    
                    if rateBTN3.contains(location){
                    }
                    
                    if musicBTN3.contains(location) && trackPlayer.volume == 0.0{
                        musicBTN3.removeFromParent()
                        createMusicBTNCross3()
                        print("*** End Touch musicBTN ***", trackPlayer.volume)
                    }
                    
                    if musicBTNCross3.contains(location) && trackPlayer.volume == 0.3{
                        musicBTNCross3.removeFromParent()
                        createMusicBTN3()
                        print("*** End Touch musicBTN2 ***", trackPlayer.volume)
                    }
                    
                    if buyBTNHome3.contains(location){
                        removeAllChildren()
                        removeAllActions()
                        playState = 5
                        homeOrRestart = 1
                        buyScene()
                    }
                }

                else if colorVar == 4 {
                    if playBTN4.contains(location){
                        playState = 0
                        removeAllChildren()
                        createScene()
                    }
                    
                    if rateBTN4.contains(location){
                    }
                    
                    if musicBTN4.contains(location) && trackPlayer.volume == 0.0{
                        musicBTN4.removeFromParent()
                        createMusicBTNCross4()
                        print("*** End Touch musicBTN ***", trackPlayer.volume)
                        
                    }
                    
                    if musicBTNCross4.contains(location) && trackPlayer.volume == 0.3{
                        musicBTNCross4.removeFromParent()
                        createMusicBTN4()
                        print("*** End Touch musicBTN2 ***", trackPlayer.volume)
                    }
                    
                    if buyBTNHome4.contains(location){
                        removeAllChildren()
                        removeAllActions()
                        playState = 5
                        homeOrRestart = 1
                        buyScene()
                    }
                }

                else if colorVar == 5 {
                    if playBTN5.contains(location){
                        playState = 0
                        removeAllChildren()
                        createScene()
                    }
                    
                    if rateBTN5.contains(location){
                    }
                    
                    if musicBTN5.contains(location) && trackPlayer.volume == 0.0{
                        musicBTN5.removeFromParent()
                        createMusicBTNCross5()
                        print("*** End Touch musicBTN ***", trackPlayer.volume)
                    }
                    
                    if musicBTNCross5.contains(location) && trackPlayer.volume == 0.3{
                        musicBTNCross5.removeFromParent()
                        createMusicBTN5()
                        print("*** End Touch musicBTN2 ***", trackPlayer.volume)
                    }
                    
                    if buyBTNHome5.contains(location){
                        removeAllChildren()
                        removeAllActions()
                        playState = 5
                        homeOrRestart = 1
                        buyScene()
                    }
                }

                else if colorVar == 6 {
                    if playBTN6.contains(location){
                        playState = 0
                        removeAllChildren()
                        createScene()
                    }
                    
                    if rateBTN6.contains(location){
                    }
                    
                    if musicBTN6.contains(location) && trackPlayer.volume == 0.0{
                        musicBTN6.removeFromParent()
                        createMusicBTNCross6()
                        print("*** End Touch musicBTN ***", trackPlayer.volume)
                    }
                    
                    if musicBTNCross6.contains(location) && trackPlayer.volume == 0.3{
                        musicBTNCross6.removeFromParent()
                        createMusicBTN6()
                        print("*** End Touch musicBTN2 ***", trackPlayer.volume)
                    }
                    
                    if buyBTNHome6.contains(location){
                        removeAllChildren()
                        removeAllActions()
                        playState = 5
                        homeOrRestart = 1
                        buyScene()
                    }
                }
            }
        }
        
        if playState == 3 {
            
            for touch in touches{
                let location = touch.location(in: self)
                
                if restartBTN.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    //self.addChild(gameLabel)
                    playState = 0
                }
                
                if restartBTN22.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    //self.addChild(gameLabel)
                    playState = 0
                }
                
                if restartBTN3.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    //self.addChild(gameLabel)
                    playState = 0
                }
                
                if restartBTN4.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    //self.addChild(gameLabel)
                    playState = 0
                }
                
                if restartBTN5.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    //self.addChild(gameLabel)
                    playState = 0
                }
                
                if restartBTN6.contains(location){
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    //self.addChild(gameLabel)
                    playState = 0
                }

                if  homeBTN1.contains(location) || homeBTN2.contains(location) || homeBTN3.contains(location) || homeBTN4.contains(location) || homeBTN5.contains(location) || homeBTN6.contains(location) {
                    removeAllChildren()
                    removeAllActions()
                    playState = -1
                    homeScene()
                    score = 0
                }
                
                if buyBTNRest1.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    homeOrRestart = 2
                    playState = 5
                    buyScene()
                    onBuyScene = 2
                }
                
                if buyBTNRest2.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    homeOrRestart = 2
                    playState = 5
                    buyScene()
                    onBuyScene = 2
                }
                
                if buyBTNRest3.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    homeOrRestart = 2
                    playState = 5
                    buyScene()
                    onBuyScene = 2
                }
                
                if buyBTNRest4.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    homeOrRestart = 2
                    playState = 5
                    buyScene()
                    onBuyScene = 2
                }
                
                if buyBTNRest5.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    homeOrRestart = 2
                    playState = 5
                    buyScene()
                    onBuyScene = 2
                }
                
                if buyBTNRest6.contains(location){
                    removeAllChildren()
                    removeAllActions()
                    homeOrRestart = 2
                    playState = 5
                    buyScene()
                    onBuyScene = 2
                }
            }
        }
        
        
        if playState == 5 {
            for touch in touches{
                let location = touch.location(in: self)
                print("+++++++++++", colorVar)
                print("Unlock1", unlockColor1)
                print("Unlock2", unlockColor2)
                print("Unlock3", unlockColor3)
                print("Unlock4", unlockColor4)
                print("Unlock5", unlockColor5)
                print("Unlock6", unlockColor6)
                
                //back button (restart screen)
                if (backBTN1.contains(location) || backBTN2.contains(location) || backBTN3.contains(location) || backBTN4.contains(location) || backBTN5.contains(location) || backBTN6.contains(location)) && homeOrRestart == 2{
                    
                    if superSelect == 1{
                        colorVar = 1
                        greyWhite      = UIColor(red: 252/255, green: 252/255, blue: 247/255, alpha: 1.0)
                        
                        red            = UIColor(red: 248/256, green: 73/256,  blue:  52/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  77/255, green: 94/255,  blue:  95/255, alpha: 1.0)
                    }
                    else if superSelect == 2{
                        colorVar = 2
                        greyWhite      = UIColor(red: 28/255, green: 40/255, blue: 38/255, alpha: 1.0)
                        
                        red            = UIColor(red: 15/256, green: 255/256,  blue:  149/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  230/255, green: 57/255,  blue:  70/255, alpha: 1.0)
                    }
                    else if superSelect == 3{
                        colorVar = 3
                        greyWhite      = UIColor(red: 249/255, green: 244/255, blue: 245/255, alpha: 1.0)
                        
                        red            = UIColor(red: 79/256, green: 93/256,  blue:  117/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  235/255, green: 94/255,  blue:  40/255, alpha: 1.0)
                    }
                    else if superSelect == 4{
                        colorVar = 4
                        greyWhite      = UIColor(red: 255/255, green: 29/255, blue: 21/255, alpha: 1.0)
                        
                        red            = UIColor(red: 249/256, green: 237/256,  blue:  204/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  63/255, green: 163/255,  blue:  197/255, alpha: 1.0)
                    }
                    else if superSelect == 5{
                        colorVar = 5
                        greyWhite      = UIColor(red: 252/255, green: 250/255, blue: 249/255, alpha: 1.0)
                        
                        red            = UIColor(red: 61/256, green: 64/256,  blue:  70/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  32/255, green: 191/255,  blue:  85/255, alpha: 1.0)
                    }
                    else if superSelect == 6{
                        colorVar = 6
                        greyWhite      = UIColor(red: 7/255, green: 6/255, blue: 0/255, alpha: 1.0)
                        
                        red            = UIColor(red: 219/256, green: 39/256,  blue:  99/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  186/255, green: 255/255,  blue:  41/255, alpha: 1.0)
                    }
                    removeAllChildren()
                    removeAllActions()
                    createDeadScene()
                    playState = 3
                }
                
                
                //back button (home screen)
                if (backBTN1.contains(location) || backBTN2.contains(location) || backBTN3.contains(location) || backBTN4.contains(location) || backBTN5.contains(location) || backBTN6.contains(location)) && homeOrRestart == 1{
                    
                    if superSelect == 1{
                        colorVar = 1
                        greyWhite      = UIColor(red: 252/255, green: 252/255, blue: 247/255, alpha: 1.0)
                        
                        red            = UIColor(red: 248/256, green: 73/256,  blue:  52/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  77/255, green: 94/255,  blue:  95/255, alpha: 1.0)
                    }
                    else if superSelect == 2{
                        colorVar = 2
                        greyWhite      = UIColor(red: 28/255, green: 40/255, blue: 38/255, alpha: 1.0)
                        
                        red            = UIColor(red: 15/256, green: 255/256,  blue:  149/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  230/255, green: 57/255,  blue:  70/255, alpha: 1.0)
                    }
                    else if superSelect == 3{
                        colorVar = 3
                        greyWhite      = UIColor(red: 249/255, green: 244/255, blue: 245/255, alpha: 1.0)
                        
                        red            = UIColor(red: 79/256, green: 93/256,  blue:  117/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  235/255, green: 94/255,  blue:  40/255, alpha: 1.0)
                    }
                    else if superSelect == 4{
                        colorVar = 4
                        greyWhite      = UIColor(red: 255/255, green: 29/255, blue: 21/255, alpha: 1.0)
                        
                        red            = UIColor(red: 249/256, green: 237/256,  blue:  204/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  63/255, green: 163/255,  blue:  197/255, alpha: 1.0)
                    }
                    else if superSelect == 5{
                        colorVar = 5
                        greyWhite      = UIColor(red: 252/255, green: 250/255, blue: 249/255, alpha: 1.0)
                        
                        red            = UIColor(red: 61/256, green: 64/256,  blue:  70/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  32/255, green: 191/255,  blue:  85/255, alpha: 1.0)
                    }
                    else if superSelect == 6{
                        colorVar = 6
                        greyWhite      = UIColor(red: 7/255, green: 6/255, blue: 0/255, alpha: 1.0)
                        
                        red            = UIColor(red: 219/256, green: 39/256,  blue:  99/256, alpha: 1.0)
                        
                        darkGrey       = UIColor(red:  186/255, green: 255/255,  blue:  41/255, alpha: 1.0)
                    }
                    
                    removeAllChildren()
                    removeAllActions()
                    playState = -1
                    homeScene()
                    score = 0
                }
                
                
                //buy color button
                if buyColorBTN.contains(location){
                    /*starLbl.removeFromParent()
                    addChild(starLbl)*/
                    if selectColor == 2 {
                        if starCount >= 5 {
                            starCount = starCount - 1
                            buyColorBTN.removeFromParent()
                            createSelectBTN()
                            unlockColor2 = 1
                        }
                    }
                    if selectColor == 3 {
                        if starCount >= 5 {
                            starCount = starCount - 1
                            buyColorBTN.removeFromParent()
                            createSelectBTN()
                            unlockColor3 = 1
                        }
                    }
                    if selectColor == 4 {
                        if starCount >= 5 {
                            starCount = starCount - 1
                            buyColorBTN.removeFromParent()
                            createSelectBTN()
                            unlockColor4 = 1
                        }
                    }
                    if selectColor == 5 {
                        if starCount >= 5 {
                            starCount = starCount - 1
                            buyColorBTN.removeFromParent()
                            createSelectBTN()
                            unlockColor5 = 1
                        }
                    }
                    if selectColor == 6 {
                        if starCount >= 5 {
                            starCount = starCount - 1
                            buyColorBTN.removeFromParent()
                            createSelectBTN()
                            unlockColor6 = 1
                        }
                    }
                }
                
                // select button 1
                if selectBTN1.contains(location){
                    
                    removeAllActions()
                    removeAllChildren()
                    buyScene()
                    
                    /*goldenHexagon()
                    selectBTN1.removeFromParent()*/
                    createSelectBTN2()
                    
                    if colorVar == 1{
                        superSelect = 1
                    }
                    if colorVar == 2{
                        superSelect = 2
                    }
                    if colorVar == 3{
                        superSelect = 3
                    }
                    if colorVar == 4{
                        superSelect = 4
                    }
                    if colorVar == 5{
                        superSelect = 5
                    }
                    if colorVar == 6{
                        superSelect = 6
                    }
                }
                
                if selectBTN2.contains(location){
                    
                }
                
                if colorBTN1.contains(location){
                    if colorVar != 1 {
                        greyWhite      = UIColor(red: 252/255, green: 252/255, blue: 247/255, alpha: 1.0)//252 , 252 , 247 / 234 , 248 , 191
                        red            = UIColor(red: 248/256, green: 73/256,  blue:  52/256, alpha: 1.0)//248 , 73 , 52 / 255 , 121 , 18
                        darkGrey       = UIColor(red:  77/255, green: 94/255,  blue:  95/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
                        removeAllActions()
                        removeAllChildren()
                        colorVar = 1
                        buyScene()
                        colorShow1()
                        backgroundColor = greyWhite
                        colorHex2.removeFromParent()
                        colorHex3.removeFromParent()
                        colorHex4.removeFromParent()
                        colorHex5.removeFromParent()
                        colorHex6.removeFromParent()
                        selectColor = 1
                    }
                    if colorVar == 1 {
                    }
                }
                
                if colorBTN2.contains(location) && onBuyScene == 3{
                    if colorVar != 2 {
                        greyWhite      = UIColor(red: 28/255, green: 40/255, blue: 38/255, alpha: 1.0)//252 , 252 , 247 / 234 , 248 , 191
                        red            = UIColor(red: 15/256, green: 255/256,  blue:  149/256, alpha: 1.0)//248 , 73 , 52 / 255 , 121 , 18
                        darkGrey       = UIColor(red:  230/255, green: 57/255,  blue:  70/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
                        removeAllActions()
                        removeAllChildren()
                        colorVar = 2
                        buyScene()
                        colorShow2()
                        backgroundColor = greyWhite
                        colorHex1.removeFromParent()
                        colorHex3.removeFromParent()
                        colorHex4.removeFromParent()
                        colorHex5.removeFromParent()
                        colorHex6.removeFromParent()
                        selectColor = 2
                        print("selectColor:", selectColor)
                        print("--------------", colorVar)
                    }
                    if colorVar == 2 {
                    }
                }
                
                if colorBTN3.contains(location) && onBuyScene == 3{
                        if colorVar != 3 {
                            greyWhite      = UIColor(red: 249/255, green: 244/255, blue: 245/255, alpha: 1.0)//252 , 252 , 247 / 234 , 248 , 191
                            red            = UIColor(red: 79/256, green: 93/256,  blue:  117/256, alpha: 1.0)//248 , 73 , 52 / 255 , 121 , 18
                            darkGrey       = UIColor(red:  235/255, green: 94/255,  blue:  40/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
                            removeAllActions()
                            removeAllChildren()
                            colorVar = 3
                            buyScene()
                            colorShow3()
                            backgroundColor = greyWhite
                            colorHex1.removeFromParent()
                            colorHex2.removeFromParent()
                            colorHex4.removeFromParent()
                            colorHex5.removeFromParent()
                            colorHex6.removeFromParent()
                            selectColor = 3
                        }
                        if colorVar == 3 {
                        }
                    }
                        
                if colorBTN4.contains(location){
                        if colorVar != 4 {
                            greyWhite      = UIColor(red: 255/255, green: 29/255, blue: 21/255, alpha: 1.0)//252 , 252 , 247 / 234 , 248 , 191
                            red            = UIColor(red: 249/256, green: 237/256,  blue:  204/256, alpha: 1.0)//248 , 73 , 52 / 255 , 121 , 18
                            darkGrey       = UIColor(red:  63/255, green: 163/255,  blue:  197/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
                            removeAllActions()
                            removeAllChildren()
                            colorVar = 4
                            buyScene()
                            colorShow4()
                            backgroundColor = greyWhite
                            colorHex1.removeFromParent()
                            colorHex2.removeFromParent()
                            colorHex3.removeFromParent()
                            colorHex5.removeFromParent()
                            colorHex6.removeFromParent()
                            selectColor = 4
                                
                        }
                        if colorVar == 4 {
                        }
                    }
                        
                if colorBTN5.contains(location){
                        if colorVar != 5 {
                            greyWhite      = UIColor(red: 252/255, green: 250/255, blue: 249/255, alpha: 1.0)//252 , 252 , 247 /234 , 248 , 191
                            red            = UIColor(red: 61/256, green: 64/256,  blue:  70/256, alpha: 1.0)//248 , 73 , 52 /255 , 121 , 18
                            darkGrey       = UIColor(red:  32/255, green: 191/255,  blue:  85/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
                            removeAllActions()
                            removeAllChildren()
                            colorVar = 5
                            buyScene()
                            colorShow5()
                            backgroundColor = greyWhite
                            colorHex1.removeFromParent()
                            colorHex2.removeFromParent()
                            colorHex3.removeFromParent()
                            colorHex4.removeFromParent()
                            colorHex6.removeFromParent()
                            selectColor = 5
                        }
                        if colorVar == 5 {
                        }
                    }
                    
                if colorBTN6.contains(location){
                        if colorVar != 6 {
                            greyWhite      = UIColor(red: 7/255, green: 6/255, blue: 0/255, alpha: 1.0)//252 , 252 , 247 /234 , 248 , 191
                            red            = UIColor(red: 219/256, green: 39/256,  blue:  99/256, alpha: 1.0)//248 , 73 , 52 /255 , 121 , 18
                            darkGrey       = UIColor(red:  186/255, green: 255/255,  blue:  41/255, alpha: 1.0)// 77 , 94 , 95 / 8 , 151 , 147
                            removeAllActions()
                            removeAllChildren()
                            colorVar = 6
                            buyScene()
                            colorShow6()
                            backgroundColor = greyWhite
                            colorHex1.removeFromParent()
                            colorHex2.removeFromParent()
                            colorHex3.removeFromParent()
                            colorHex4.removeFromParent()
                            colorHex5.removeFromParent()
                            selectColor = 6
                        }
                        if colorVar == 6 {
                        }
                }
            }
        }
    }
 
    
//--- TouchesMove
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
            for touch in touches{
                let location = touch.location(in: self)
                
                if playState == -1 {
                    
                    if colorVar == 1 {
                        if playBTN.contains(location){
                        createPlayBTN()
                        playBTN2.removeFromParent()
                        playState = -1
                    
                        }
                    }
                    
                    else if colorVar == 2 {
                        if playBTN.contains(location){
                            createPlayBTN22()
                            playBTN2.removeFromParent()
                            playState = -1
                            
                        }
                    }
                    
                    else if colorVar == 3 {
                        if playBTN.contains(location){
                            createPlayBTN3()
                            playBTN2.removeFromParent()
                            playState = -1
                            
                        }
                    }

                    else if colorVar == 4 {
                        if playBTN.contains(location){
                            createPlayBTN4()
                            playBTN2.removeFromParent()
                            playState = -1
                        }
                    }

                    else if colorVar == 5 {
                        if playBTN.contains(location){
                            createPlayBTN5()
                            playBTN2.removeFromParent()
                            playState = -1
                        }
                    }

                    else if colorVar == 6 {
                        if playBTN.contains(location){
                            createPlayBTN6()
                            playBTN2.removeFromParent()
                            playState = -1
                        }
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
            //star vs ball
            
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

            //score line vs ball
            
            if firstBody.categoryBitMask == PhysicsCatagory.score && secondBody.categoryBitMask == PhysicsCatagory.ball {
                score  += 1
                wallDir = wallDir * (-1)
                ballColor = ballColor * (-1)
                print("ballColor", ballColor)
                scoreLbl.text = "\(score)"
                firstBody.node?.removeFromParent()
                starVar = Int(arc4random_uniform(200))
                if starVar % 2 == 0 {
                    starVar = starVar * -1
                }
                else {
                    
                }
                randPos = Int(arc4random_uniform(250)) + 400
                islandPosRight  = randPos
                islandPosLeft   = randPos
                pointPlayer.play()
            }
            // score line vs ball
            if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.score {
                score  += 1
                wallDir = wallDir * (-1)
                ballColor = ballColor * (-1)
                print("ballColor", ballColor)
                scoreLbl.text = "\(score)"
                secondBody.node?.removeFromParent()
                starVar = Int(arc4random_uniform(200))
                if starVar % 2 == 0 {
                    starVar = starVar * -1
                }
                else {
                    
                }
                randPos = Int(arc4random_uniform(250)) + 400
                islandPosRight  = randPos
                islandPosLeft   = randPos
                pointPlayer.play()
            }
            // edge vs  ball
            if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.edge1 {
                    ball_dir = ball_dir * (-1)
            }
            // edge vs  ball
            if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.edge2 {
                ball_dir = ball_dir * (-1)
                
            }
            // edge vs  ball
            if firstBody.categoryBitMask == PhysicsCatagory.edge1 && secondBody.categoryBitMask == PhysicsCatagory.ball {
                ball_dir = ball_dir * (-1)
            }
            // edge vs  ball
            if firstBody.categoryBitMask == PhysicsCatagory.edge2 && secondBody.categoryBitMask == PhysicsCatagory.ball {
                ball_dir = ball_dir * (-1)
            }
        
            //Left1: island change direction (island starting left hits right wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits right wall: ", distanceWall, velocityWall, abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft.run(moveIslandLeft)
            }
            
            //Left1: island change direction (island starting left hits left wall)

            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits left wall: ", distanceWall, velocityWall, abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft.run(moveIslandLeft)
            }

            //Right1: island change direction (island starting right hits left wall)
            
            if    firstBody.categoryBitMask == PhysicsCatagory.islandRight && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
              || secondBody.categoryBitMask == PhysicsCatagory.islandRight &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                print("---<<<---Right Island hits left wall: ", islandVar, ball_dir, CGFloat(xwallMove2))
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight.run(moveIslandRight)
            }
        
            //Right1: island change direction (island starting right hits right wall)
            
            if    firstBody.categoryBitMask == PhysicsCatagory.islandRight && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
              || secondBody.categoryBitMask == PhysicsCatagory.islandRight &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                print("---<<<---Right Island hits right wall: ", islandVar, ball_dir, CGFloat(xwallMove2))
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight.run(moveIslandRight)
            }
            
            //Left2: island change direction (island starting left hits right wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits right wall: ", distanceWall, velocityWall,abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft2.run(moveIslandLeft)
            }
            
            //Left2: island change direction (island starting left hits left wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandLeft2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                || secondBody.categoryBitMask == PhysicsCatagory.islandLeft2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                let distanceWall   = self.frame.width + wallPairRight.frame.width
                print("--->>>---Left Island hits left wall: ", distanceWall, velocityWall,abs(ball_dir))
                let moveIslandLeft = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandLeft2.run(moveIslandLeft)
            }
            
            //Right2: island change direction (island starting right hits left wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandRight2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallLeft
                || secondBody.categoryBitMask == PhysicsCatagory.islandRight2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallLeft
            {
                print("---<<<---Right Island hits left wall: ", islandVar, ball_dir, xwallMove[iRan])
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
                wallIslandRight2.run(moveIslandRight)
            }
            
            //Right2: island change direction (island starting right hits right wall)
            
            if      firstBody.categoryBitMask == PhysicsCatagory.islandRight2 && secondBody.categoryBitMask == PhysicsCatagory.smallWallRight
                || secondBody.categoryBitMask == PhysicsCatagory.islandRight2 &&  firstBody.categoryBitMask == PhysicsCatagory.smallWallRight
            {
                print("---<<<---Right Island hits right wall: ", islandVar, ball_dir, xwallMove[iRan])
                let distanceWall    = self.frame.width + wallPairLeft.frame.width
                let moveIslandRight = SKAction.moveBy(x: -CGFloat(abs(islandVar*ball_dir)) * CGFloat(xwallMove2), y: 0.0, duration: TimeInterval(distanceWall/velocityWall))
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
                                                                        
                enumerateChildNodes(withName: "wallIslandLeft2", using: {
                    (node, error) in
                    node.speed = 0
                    self.removeAllActions()
                })
                                                                        
                enumerateChildNodes(withName: "wallIslandRight2", using: {
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
                    print("stop outsideWalls")
                    self.removeAllActions()
                })

                enumerateChildNodes(withName: "star1", using: {
                    (node, error) in
                    print("stop star1")
                    node.speed = 0
                    self.removeAllActions()
                })

                delay(1){
                    self.createDeadScene()
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
