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
    var wallPairRight  = SKNode()
    var wallPairLeft   = SKNode()
    var moveAndRemoveRight = SKAction()
    var moveAndRemoveLeft  = SKAction()
    var restartBTN = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    var endScoreLbl = SKLabelNode()
    var endScoreLbl2 = SKLabelNode()
    var endScoreLbl3 = SKLabelNode()
    var endScoreLbl4 = SKLabelNode()
    var gameLabel = SKLabelNode()
    //var play    = SKSpriteNode()
    var playBTN = SKShapeNode()
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
    //-----------------
    
    var ball_dir = 1.0                                // ball direction (-1,1)
    var ximpulse = 250.0                              // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var ximpMore = 0.0                                // impulse increases with score by    e.g. 20  [kg m/s]
    var xgravity = 4.0                                // gravity of ball when mouse click   e.g. 2 [m/s2]
    var restartDelay = 1.0                            // delay for restart button to appear e.g. 3 [s]
    var restartSleep = UInt32(0)                      // wait after restart button created  e.g. 3 [s]
    var xwallPos1:CGFloat  = 775.0                    // position of left wall  e.g. 800
    var xwallPos2:CGFloat  = 250.0                    // position of right wall e.g. 225
    var xwallShift:CGFloat = -50.0                    // shift wall to see more of incoming red wall
    var xwallMove:CGFloat  = 100.0                    // move walls in xdir e.g. 200
    var xwallMoveI:CGFloat = 100.0
    var velocityWall = CGFloat(180)                   // wall speed e.g. 120
    let delayWalls   = SKAction.waitForDuration(2.0)  // time new walls (s)
    var wallDir1           = 1                        // initial wall speed direction
    var wallDir            = 1                        // initial wall speed direction
    

    //var gravityBehavior: UtapIGravityBehavior?
    var gravityDirection = CGVectorMake(0,0)          // gravity: normal (0,-9.8)
    
    //var gravityX:CGFloat = 6
    //let impulseY:CGFloat = 4.0
    //let impulseX:CGFloat = 10.0
    
    // color schemes
    var greyWhite      = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    var scoreNodeColor = UIColor.clearColor()
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
    override func didMoveToView(view: SKView) {
  
        backgroundColor = greyWhite
        homeScene()
        self.physicsWorld.gravity = gravityDirection
        
        var HighscoreDefault = NSUserDefaults.standardUserDefaults()
        if(HighscoreDefault.valueForKey("highscore") != nil) {
            highscore = HighscoreDefault.valueForKey("highscore") as! NSInteger!
        
        
        }

        //--- Sounds
        
        let touchSound:NSURL = NSBundle.mainBundle().URLForResource("touchSoundOfficial2.0", withExtension: "mp3")!
        let pointSound:NSURL = NSBundle.mainBundle().URLForResource("pointSoundOfficial2.0", withExtension: "mp3")!
        let deathSound:NSURL = NSBundle.mainBundle().URLForResource("deathSoundOfficial", withExtension: "mp3")!
        let soundTrack:NSURL = NSBundle.mainBundle().URLForResource("trackSound", withExtension: "mp3")!
        //let buttonTrack:NSURL = NSBundle.mainBundle().URLForResource("buttonSound", withExtension: "mp3")!

        do
        {
            touchPlayer = try AVAudioPlayer(contentsOfURL: touchSound, fileTypeHint: nil)
            pointPlayer = try AVAudioPlayer(contentsOfURL: pointSound, fileTypeHint: nil)
            deathPlayer = try AVAudioPlayer(contentsOfURL: deathSound, fileTypeHint: nil)
            trackPlayer = try AVAudioPlayer(contentsOfURL: soundTrack, fileTypeHint: nil)
            buttonPlayer = try AVAudioPlayer(contentsOfURL: soundTrack, fileTypeHint: nil)
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
        let mySlider = UISlider(frame:CGRectMake(10, 500, 300, 20))  // x, y, width, height
        mySlider.minimumValue = 0
        mySlider.maximumValue = 100
        mySlider.continuous = true
        mySlider.tintColor = UIColor.greenColor()
        mySlider.addTarget(self, action: #selector(GameScene.sliderValueDidChange(_:)), forControlEvents: .ValueChanged)
        
        //self.view!.addSubview(mySlider)
    
    }
    
    
//--- Slider value
    func sliderValueDidChange(sender:UISlider!)
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
        ball_dir = 1
        
        physicsWorld.gravity = CGVectorMake(0,0)              // switch gravity off
        
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
        edge1.physicsBody = SKPhysicsBody(rectangleOfSize: edge1.size)
        edge1.physicsBody?.affectedByGravity = true
        edge1.physicsBody?.dynamic = false
        //edge1.zPosition = 3
        self.addChild(edge1)    //make edge1
        
        //edge on the right
        edge2 = SKSpriteNode(imageNamed: "bar")
        edge2.setScale(0.5)
        edge2.size = CGSize(width: 10, height: 1000)
        edge2.position = CGPoint(x: self.frame.width * 0.71, y: edge2.frame.height * 0.4)
        edge2.physicsBody = SKPhysicsBody(rectangleOfSize: edge2.size)
        edge2.physicsBody?.affectedByGravity = true
        edge2.physicsBody?.dynamic = false
        //edge2.zPosition = 3
        self.addChild(edge2)    //make edge2
        
        //shape to define ball
        
        let center = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path   = CGPathCreateMutable()
        CGPathMoveToPoint(   path, nil, center.x + 25, center.y)
        CGPathAddLineToPoint(path, nil, center.x, center.y + 25)
        CGPathAddLineToPoint(path, nil, center.x - 25, center.y)
        CGPathAddLineToPoint(path, nil, center.x, center.y - 25)
        CGPathCloseSubpath(path)
        ball = SKShapeNode(path: path)
        ball.strokeColor = red
        ball.lineWidth = 6
        ball.fillColor =  greyWhite

        //ball physics
        
        //ball = SKSpriteNode(imageNamed: "diamond")
        //ball.size = CGSize(width: 55, height: 55)
        //ball.position = CGPoint(x: self.frame.width * 0.5 , y: self.frame.height * 0.5)
        ball.physicsBody = SKPhysicsBody(polygonFromPath: path)

        ball.physicsBody?.dynamic            = true
        ball.physicsBody?.affectedByGravity  = true
        ball.physicsBody?.mass               = 1
        ball.physicsBody?.friction           = 0.0
        ball.physicsBody?.linearDamping      = 0.3
        ball.physicsBody?.restitution        = 0.3                           // ball: bounciness (0,1)
        ball.physicsBody?.categoryBitMask    = PhysicsCatagory.ball
        ball.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
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


        
        //shape to define ball2
        
        let center2 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)*0.8)
        //let path   = CGPathCreateMutable()
        CGPathMoveToPoint(   path, nil, center2.x + 25, center2.y)
        CGPathAddLineToPoint(path, nil, center2.x, center2.y + 25)
        CGPathAddLineToPoint(path, nil, center2.x - 25, center2.y)
        CGPathAddLineToPoint(path, nil, center2.x, center2.y - 25)
        CGPathCloseSubpath(path)
        ball2 = SKShapeNode(path: path)
        ball2.strokeColor = purple
        ball2.fillColor   = purple
        
        //ball physics
        
        //ball = SKSpriteNode(imageNamed: "diamond")
        //ball.size = CGSize(width: 55, height: 55)
        //ball.position = CGPoint(x: self.frame.width * 0.5 , y: self.frame.height * 0.5)
        ball2.physicsBody = SKPhysicsBody(polygonFromPath: path)
        
        ball2.physicsBody?.dynamic            = true
        ball2.physicsBody?.affectedByGravity  = true
        ball2.physicsBody?.mass               = 1
        ball2.physicsBody?.friction           = 0.0
        ball2.physicsBody?.linearDamping      = 0.3
        ball2.physicsBody?.restitution        = 0.3                           // ball: bounciness (0,1)
        //ball2.physicsBody?.categoryBitMask    = PhysicsCatagory.ball
        //ball2.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        //ball2.physicsBody?.contactTestBitMask = PhysicsCatagory.wallAr | PhysicsCatagory.wallBr | PhysicsCatagory.wallAl | PhysicsCatagory.wallBl | PhysicsCatagory.score
        //ball2.physicsBody!.usesPreciseCollisionDetection = true
        ball2.physicsBody?.velocity = CGVector(dx: ximpulse / 2.0 , dy: 0)            // ball: initial velocity [m/s]
        ball2.zPosition = 3
        
        //self.addChild(ball2)

        
        
        
        
        // ball: initial velocity
        //gravityBehavior = UIGravityBehavior(items: ball)
        //ball.gravityBehavior?.gravityDirection = CGVector(0.0, 1.0)
        //let thrust  = CGVector(dx: 0,dy: 1000.0)
        //ball.physicsBody?.applyForce(thrust)
        
        /*let dt: CGFloat = 1.0/60.0 //Delta time.
        let strength: CGFloat = 10000 //Make gravity less weak and more fun!
        let force   = CGFloat(1000.0)
        let normal  = CGVector(dx: 5, dy: 5)
        let impulse = CGVector(dx: normal.dx*force*dt, dy: normal.dy*force*dt)
        ball.physicsBody?.velocity = CGVector(dx: ball.physicsBody!.velocity.dx + impulse.dx, dy: ball.physicsBody!.velocity.dy + impulse.dy) */
    }

    
//--- home
    func homeScene(){
        
        backgroundColor = lightGrey
        //play label
        
        let center5 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path5   = CGPathCreateMutable()
        CGPathMoveToPoint(   path5, nil, center5.x - 40, center5.y + 0)
        CGPathAddLineToPoint(path5, nil, center5.x - 40, center5.y - 100)
        CGPathAddLineToPoint(path5, nil, center5.x + 40, center5.y - 50   )
        CGPathCloseSubpath(path5)
        playBTN = SKShapeNode(path: path5)
        playBTN.strokeColor = red
        playBTN.lineWidth = 5
        playBTN.fillColor   = greyWhite
        playBTN.physicsBody = SKPhysicsBody(polygonFromPath: path5)
        playBTN.physicsBody?.dynamic = false
        self.addChild(playBTN)
        
        //title
        
        gameLabel = SKLabelNode(fontNamed: "NORMAL")
        gameLabel.text = "Anti Gravity"
        gameLabel.fontSize  = 50
        gameLabel.fontColor = red
        gameLabel.horizontalAlignmentMode = .Center
        gameLabel.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-200)
        gameLabel.zPosition = 5
        self.addChild(gameLabel)
    }
 
    
//--- create button
    func createBTN(){
        
        delay(restartDelay) {
        self.restartBTN = SKSpriteNode(color: SKColor.clearColor(), size: CGSize(width: self.frame.width*2, height: self.frame.height*2))
        self.restartBTN.position = CGPoint(x: self.frame.width, y: self.frame.height)
        self.restartBTN.zPosition = 4
        self.addChild(self.restartBTN)
            
        self.scoreLabel = SKLabelNode(fontNamed: "GillSans-Bold")
        self.scoreLabel.text = "Restart"
        self.scoreLabel.fontSize = 45
        self.scoreLabel.fontColor = self.red
        self.scoreLabel.horizontalAlignmentMode = .Center
        self.scoreLabel.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-500)
        self.scoreLabel.zPosition = 5
        self.addChild(self.scoreLabel)
        self.playState = 3
        }
    }
    
//--- end score
    func endScore(){
    
            if (score > highscore) {
                highscore = score
            }
            var HighscoreDefault = NSUserDefaults.standardUserDefaults()
            HighscoreDefault.setValue(highscore, forKey: "highscore")
            HighscoreDefault.synchronize()
        

            self.endScoreLbl = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl.text       = "Score"
            self.endScoreLbl.fontSize   = 45
            self.endScoreLbl.fontColor = self.red
            self.endScoreLbl.horizontalAlignmentMode = .Center
            self.endScoreLbl.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-200)
            self.endScoreLbl.zPosition = 5
            self.addChild(self.endScoreLbl)
            
            self.endScoreLbl2 = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl2.text       = String(self.score)
            self.endScoreLbl2.fontSize   = 45
            self.endScoreLbl2.fontColor = self.red
            self.endScoreLbl2.horizontalAlignmentMode = .Center
            self.endScoreLbl2.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-250)
            self.endScoreLbl2.zPosition = 5
            self.addChild(self.endScoreLbl2)
        
            self.endScoreLbl3 = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl3.text       = "Highscore"
            self.endScoreLbl3.fontSize   = 45
            self.endScoreLbl3.fontColor = self.red
            self.endScoreLbl3.horizontalAlignmentMode = .Center
            self.endScoreLbl3.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-350)
            self.endScoreLbl3.zPosition = 5
            self.addChild(self.endScoreLbl3)
        
            self.endScoreLbl4 = SKLabelNode(fontNamed: "GillSans-Bold")
            self.endScoreLbl4.text       = String(self.highscore)
            self.endScoreLbl4.fontSize   = 45
            self.endScoreLbl4.fontColor = self.red
            self.endScoreLbl4.horizontalAlignmentMode = .Center
            self.endScoreLbl4.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-400)
            self.endScoreLbl4.zPosition = 5
            self.addChild(self.endScoreLbl4)

        


            self.playState = 3

        
    
    
    }

    
//--- Create walls right ---->
    
    func createWallsRight(){
        
        wallPairRight = SKNode()
        wallPairRight.name = "wallPairRight"
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 850, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.dynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = scoreNodeColor
        
        //Ar: Left wall moving right  |=>
        
        let center1 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path1   = CGPathCreateMutable()
        CGPathMoveToPoint(   path1, nil, center1.x +  150, center1.y)
        CGPathAddLineToPoint(path1, nil, center1.x +  125, center1.y + 25)
        CGPathAddLineToPoint(path1, nil, center1.x - 1000, center1.y + 25)
        CGPathAddLineToPoint(path1, nil, center1.x - 1000, center1.y - 25)
        CGPathAddLineToPoint(path1, nil, center1.x +  125, center1.y - 25)
        CGPathCloseSubpath(path1)
        wallAr = SKShapeNode(path: path1)
        wallAr.strokeColor = red
        wallAr.fillColor   = red
        wallAr.position    = CGPoint(x: self.frame.width/2  - xwallPos1 + xwallShift, y:frame.height-383)
        wallAr.physicsBody = SKPhysicsBody(polygonFromPath: path1)
        wallAr.physicsBody?.affectedByGravity = false
        wallAr.physicsBody?.dynamic = false
        wallAr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallAr
        wallAr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallAr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallAr.zPosition = 3
        
        //Br: Right wall moving right  >=|
        
        let center2 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path2   = CGPathCreateMutable()
        CGPathMoveToPoint(   path2, nil, center2.x -  100, center2.y)
        CGPathAddLineToPoint(path2, nil, center2.x -  125, center2.y + 25)
        CGPathAddLineToPoint(path2, nil, center2.x + 1000, center2.y + 25)
        CGPathAddLineToPoint(path2, nil, center2.x + 1000, center2.y - 25)
        CGPathAddLineToPoint(path2, nil, center2.x -  125, center2.y - 25)
      //CGPathCloseSubpath(path2)
        wallBr = SKShapeNode(path: path2)
        wallBr.strokeColor = darkGrey
        wallBr.fillColor   = darkGrey
        wallBr.position    = CGPoint(x: self.frame.width  - xwallPos1 + xwallShift, y:frame.height-383)
        wallBr.physicsBody = SKPhysicsBody(polygonFromPath: path2)
        wallBr.physicsBody?.affectedByGravity = false
        wallBr.physicsBody?.dynamic = false
        wallBr.physicsBody?.categoryBitMask    = PhysicsCatagory.wallBr
        wallBr.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallBr.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallBr.zPosition = 3
        
        wallPairRight.addChild(wallAr)
        wallPairRight.addChild(wallBr)
        wallPairRight.addChild(scoreNode)
        wallPairRight.runAction(moveAndRemoveRight)
        
        self.addChild(wallPairRight)
    }
  
    
    //--- Create walls left <---------
    
    func createWallsLeft(){
        
        wallPairLeft = SKNode()
        wallPairLeft.name = "wallPairLeft"
        let scoreNode = SKSpriteNode()
        scoreNode.size = CGSize(width: 850, height:3)
        scoreNode.position = CGPoint(x:self.frame.width/2, y:self.frame.width-256)
        scoreNode.physicsBody = SKPhysicsBody(rectangleOfSize: scoreNode.size)
        scoreNode.physicsBody?.affectedByGravity = false
        scoreNode.physicsBody?.dynamic = false
        scoreNode.physicsBody?.categoryBitMask = PhysicsCatagory.score
        scoreNode.physicsBody?.collisionBitMask = 0
        scoreNode.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        scoreNode.color = scoreNodeColor
        
        //Al: Right wall moving left  <=|
        
        let center3 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path3   = CGPathCreateMutable()
        CGPathMoveToPoint(   path3, nil, center3.x -  150, center3.y)
        CGPathAddLineToPoint(path3, nil, center3.x -  125, center3.y + 25)
        CGPathAddLineToPoint(path3, nil, center3.x + 1000, center3.y + 25)
        CGPathAddLineToPoint(path3, nil, center3.x + 1000, center3.y - 25)
        CGPathAddLineToPoint(path3, nil, center3.x -  125, center3.y - 25)
        CGPathCloseSubpath(path3)
        wallAl = SKShapeNode(path: path3)
        wallAl.strokeColor = red
        wallAl.fillColor   = red
        wallAl.position    = CGPoint(x: self.frame.width  - xwallPos1 - xwallShift, y:frame.height-383)
        wallAl.physicsBody = SKPhysicsBody(polygonFromPath: path3)
        wallAl.physicsBody?.affectedByGravity = false
        wallAl.physicsBody?.dynamic = false
        wallAl.physicsBody?.categoryBitMask    = PhysicsCatagory.wallAl
        wallAl.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallAl.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallAl.zPosition = 3
        
        //Bl: Left wall moving left  |=<
        
        let center4 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path4   = CGPathCreateMutable()
       
        CGPathMoveToPoint(   path4, nil, center4.x +  100, center4.y)
        CGPathAddLineToPoint(path4, nil, center4.x +  125, center4.y + 25)
        CGPathAddLineToPoint(path4, nil, center4.x - 1000, center4.y + 25)
        CGPathAddLineToPoint(path4, nil, center4.x - 1000, center4.y - 25)
        CGPathAddLineToPoint(path4, nil, center4.x +  125, center4.y - 25)
        CGPathCloseSubpath(path4)
        wallBl = SKShapeNode(path: path4)
        wallBl.strokeColor = darkGrey
        wallBl.fillColor   = darkGrey
        wallBl.position    = CGPoint(x: self.frame.width/2  - xwallPos1 - xwallShift, y:frame.height-383)
        wallBl.physicsBody = SKPhysicsBody(polygonFromPath: path4)
        wallBl.physicsBody?.affectedByGravity = false
        wallBl.physicsBody?.dynamic = false
        wallBl.physicsBody?.categoryBitMask    = PhysicsCatagory.wallBl
        wallBl.physicsBody?.collisionBitMask   = PhysicsCatagory.ball
        wallBl.physicsBody?.contactTestBitMask = PhysicsCatagory.ball
        wallBl.zPosition = 3
        
        wallPairLeft.addChild(wallAl)
        wallPairLeft.addChild(wallBl)
        wallPairLeft.addChild(scoreNode)
        wallPairLeft.runAction(moveAndRemoveLeft)
        
        self.addChild(wallPairLeft)
    }


//--- Mouse Click
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */

        print("Mouse Click: ",playState, ball_dir)

        // state -1: home ----------------------
        if playState == -1 {
            for touch in touches{
                let location = touch.locationInNode(self)
                
                if playBTN.containsPoint(location){
                    playState = 0
                    playBTN.removeFromParent()
                    gameLabel.removeFromParent()
                    createScene()
                }
            }
        }
        
        // state 0: Set ----------------------
        if playState == 0 {
            backgroundColor = greyWhite
            let spawnWallsRight = SKAction.runBlock({
                () in
                self.createWallsRight()
            })
            
            let spawnWallsLeft = SKAction.runBlock({
                () in
                self.createWallsLeft()
            })
            
            wallDir = wallDir1
            
            // move walls down (called in functions createWallsRight and Left)
            
            let distanceWall = CGFloat(self.frame.width + wallPairRight.frame.width)
            let moveWallRight     = SKAction.moveByX(CGFloat(ball_dir) * xwallMove, y: -distanceWall, duration: NSTimeInterval(distanceWall/velocityWall))
            let removeWallRight   = SKAction.removeFromParent()
            moveAndRemoveRight    = SKAction.sequence([moveWallRight, removeWallRight])
            
            let moveWallLeft     = SKAction.moveByX(CGFloat(ball_dir) * xwallMove * (-1), y: -distanceWall, duration: NSTimeInterval(distanceWall/velocityWall))
            let removeWallLeft   = SKAction.removeFromParent()
            moveAndRemoveLeft    = SKAction.sequence([moveWallLeft, removeWallLeft])
            
            // make new walls
            
            let spawnDelay        = SKAction.sequence([spawnWallsRight, delayWalls, spawnWallsLeft, delayWalls])
            let spawnDelayForever = SKAction.repeatActionForever(spawnDelay)
            self.runAction(spawnDelayForever)
            
            xwallMoveI       = xwallMove
            
            playState = 1

            print("Create walls, game started",playState)

        }
        
        // state 1: Play ----------------------
        if playState == 1 {
            ball_dir = ball_dir * (-1.0)
            //self.ball.physicsBody?.velocity = CGVector(dx:40, dy: 0)                         // ball: reset velocity [m/s]
            ball.physicsBody?.applyImpulse(CGVectorMake(CGFloat(ball_dir*(ximpulse+Double(score)*ximpMore)), 0)) // add impulse

            self.physicsWorld.gravity = CGVectorMake(CGFloat(ball_dir*xgravity), CGFloat(0))   // switch gravity
            //ball.physicsBody?.velocity = CGVector(dx: 50 , dy: 0)                            // ball: initial velocity [m/s]
            
            touchPlayer.play()
            
            print("Press Ball Impulse: ",playState)
            
            
            // change wall speed
            
            if score >= 2 {
                xwallMoveI = xwallMoveI * (1.05)
            }
            
            print("xwallMove ------------------", score, xwallMoveI, wallDir, ball_dir)

        }
        
        // state 2: Dead ----------------------
        if playState == 2 {
            //ball.physicsBody?.affectedByGravity = true
        }

        // state 3: Restart screen: Touch button to restart ----------------------
        if playState == 3 {
            for touch in touches{
                let location = touch.locationInNode(self)
            
                if restartBTN.containsPoint(location){
                    print("Press Restart Button: ", playState)
                    sleep(restartSleep)
                    delay(0){self.restartScene()}
                    playState = 0
                }
            }
        }
    }

    
//--- Collision: contact between ball and walls
    func didBeginContact(contact: SKPhysicsContact) {
        let firstBody  = contact.bodyA
        let secondBody = contact.bodyB
        
        if firstBody.categoryBitMask == PhysicsCatagory.score && secondBody.categoryBitMask == PhysicsCatagory.ball{
            score  += 1
            wallDir = wallDir * (-1)
            print("Score1: ", score, wallDir)
            scoreLbl.text = "\(score)"
            firstBody.node?.removeFromParent()
            pointPlayer.play()
            
        }
        else if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.score {
            score  += 1
            wallDir = wallDir * (-1)
            print("Score2: ", score, wallDir)
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
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
            && secondBody.categoryBitMask == PhysicsCatagory.ball   {
            
        
            playState = 2
            print("Collision with wall")
            
            deathPlayer.play()
            
            //ball.physicsBody?.affectedByGravity = true
                
            self.physicsWorld.gravity = CGVectorMake(CGFloat(0), CGFloat(-3))     // switch gravity: fall down on collision
                
            enumerateChildNodesWithName("wallPairRight", usingBlock: {
                (node, error) in
                node.speed = 0
                self.removeAllActions()
            })
            
            enumerateChildNodesWithName("wallPairLeft", usingBlock: {
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
            }
        }

}
    

//--- Delay [s]
    func delay(delay: Double, closure: ()->()) {
        dispatch_after(
            dispatch_time(
                DISPATCH_TIME_NOW,
                Int64(delay * Double(NSEC_PER_SEC))
            ),
            dispatch_get_main_queue(),
            closure
        )
    }
    
    
//--- Update
    override func update(currentTime: CFTimeInterval) {
        
           }
}