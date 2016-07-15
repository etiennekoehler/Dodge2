//
//  GameScene.swift
//  Anti Gravity
//
//  Created by Etienne Köhler on 18/06/16.
//  Copyright (c) 2016 Moseby Inc. All rights reserved.
//

import SpriteKit


//--- Game Physics
struct PhysicsCatagory {
    static let ball    : UInt32 = 0x1 << 1
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
    var edge1   = SKSpriteNode()
    var edge2   = SKSpriteNode()
    var circle  = SKSpriteNode()
    var wallAr  = SKShapeNode()
    var wallBr  = SKShapeNode()
    var wallAl  = SKShapeNode()
    var wallBl  = SKShapeNode()
    var wallPairRight  = SKNode()
    var wallPairLeft   = SKNode()
    var moveAndRemove  = SKAction()
    var moveAndRemove2 = SKAction()
    var restartBTN = SKSpriteNode()
    var scoreLabel = SKLabelNode()
    //var play    = SKSpriteNode()
    //var playBTN = SKShapeNode()
    var playState = 0

    //--- playState ---
    // 0: set
    // 1: play
    // 2: dead
    // 3: restart
    //-----------------
    
    var ball_dir = 1.0                                // ball direction (-1,1)
    var ximpulse = 200.0                              // impulse of ball when mouse click   e.g. 100 [kg m/s]
    var ximpMore = 0.0                                // impulse increases with score by    e.g. 20  [kg m/s]
    var xgravity = 4.0                                // gravity of ball when mouse click   e.g. 2 [m/s2]
    var restartDelay = 1.0                            // delay for restart button to appear e.g. 3 [s]
    var restartSleep = UInt32(0)                      // wait after restart button created  e.g. 3 [s]
    var xwallPos1:CGFloat  = 775.0                    // position of left wall  e.g. 800
    var xwallPos2:CGFloat  = 250.0                    // position of right wall e.g. 225
    var xwallShift:CGFloat = -50.0                    // shift wall to see more of incoming red wall
    var xwallMove:CGFloat  = 100.0                    // move walls in xdir e.g. 200
    var xwallMoveI:CGFloat = 100.0
    let velocityWall = CGFloat(180)                   // wall speed e.g. 120
    let delayWalls   = SKAction.waitForDuration(2.0)  // time new walls (s)
    var wallDir1           = 1                        // initial wall speed direction
    var wallDir            = 1                        // initial wall speed direction
    

    //var gravityBehavior: UtapIGravityBehavior?
    var gravityDirection = CGVectorMake(0,0)          // gravity: normal (0,-9.8)
    
    //var gravityX:CGFloat = 6
    //let impulseY:CGFloat = 4.0
    //let impulseX:CGFloat = 10.0
    
    // color schemes
    var backColor      = UIColor(red: 234/255, green: 234/255, blue: 234/255, alpha: 1.0)
    var scoreNodeColor = UIColor.clearColor()
    var ballColor      = UIColor(red: 255/255, green: 255/255, blue: 255/255, alpha: 1.0)
    var restartColor   = UIColor(red: 200/256, green: 40/256,  blue:  40/256, alpha: 1.0)
    var scoreColor     = UIColor(red: 200/256, green: 40/256,  blue:  40/256, alpha: 1.0)
    var wallAColor     = UIColor(red: 200/256, green: 40/256,  blue:  40/256, alpha: 1.0)
    var wallBColor     = UIColor(red:  73/255, green: 73/255,  blue:  73/255, alpha: 1.0)

    
    var score    = Int()
    let scoreLbl = SKLabelNode()
    //let tap      = SKLabelNode()
    
    
//--- Start the game
    override func didMoveToView(view: SKView) {
  
        backgroundColor = backColor
        createScene()
        //playScene()
        self.physicsWorld.gravity = gravityDirection
        
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
    
/*
    func playScene(){
    
        //play label
        
        let center5 = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
        let path5   = CGPathCreateMutable()
        CGPathMoveToPoint(   path5, nil, center5.x , center5.y + 35)
        CGPathAddLineToPoint(path5, nil, center5.x, center5.y - 35)
        CGPathAddLineToPoint(path5, nil, center5.x + 50, center5.y)
        CGPathCloseSubpath(path5)
        playBTN = SKShapeNode(path: path5)
        playBTN.strokeColor = ballColor
        playBTN.fillColor   = ballColor
        playBTN.physicsBody = SKPhysicsBody(polygonFromPath: path5)
        //self.addChild(playBTN)
        
        //title

    }
*/

    
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
        ball.strokeColor = ballColor
        ball.fillColor   = ballColor

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
        ball.physicsBody?.velocity = CGVector(dx: 0 , dy: 0)            // ball: initial velocity [m/s]
        ball.zPosition = 3
        
        self.addChild(ball)
        
        scoreLbl.position = CGPoint(x: self.frame.width / 2, y: self.frame.height / 2 + self.frame.height / 2.5)
        scoreLbl.text = "\(score)"
        scoreLbl.fontName = "GillSans-UltraBold"
        scoreLbl.zPosition = 5
        scoreLbl.fontSize = 60
        
        self.addChild(scoreLbl)

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

//--- create button
    func createBTN(){
        
        delay(restartDelay) {
        self.restartBTN = SKSpriteNode(color: SKColor.clearColor(), size: CGSize(width: self.frame.width*2, height: self.frame.height*2))
        self.restartBTN.position = CGPoint(x: self.frame.width, y: self.frame.height)
        self.restartBTN.zPosition = 4
        self.addChild(self.restartBTN)
            
        self.scoreLabel = SKLabelNode(fontNamed: "GillSans-UltraBold")
        self.scoreLabel.text = "Restart"
        self.scoreLabel.fontSize = 45
        self.scoreLabel.fontColor = self.restartColor
        self.scoreLabel.horizontalAlignmentMode = .Center
        self.scoreLabel.position = CGPoint(x: self.frame.width / 2, y:self.frame.height-500)
        self.scoreLabel.zPosition = 5
        self.addChild(self.scoreLabel)
        self.playState = 3
        }
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
        wallAr.strokeColor = wallAColor
        wallAr.fillColor   = wallAColor
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
        wallBr.strokeColor = wallBColor
        wallBr.fillColor   = wallBColor
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
        wallPairRight.runAction(moveAndRemove)
        
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
        wallAl.strokeColor = wallAColor
        wallAl.fillColor   = wallAColor
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
        wallBl.strokeColor = wallBColor
        wallBl.fillColor   = wallBColor
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
        wallPairLeft.runAction(moveAndRemove)
        
        self.addChild(wallPairLeft)
    }


//--- Mouse Click
    override func touchesBegan(touches: Set<UITouch>, withEvent event: UIEvent?) {
        /* Called when a touch begins */
        
        print("Mouse Click: ",playState, ball_dir)

        // state 0: Set
        if playState == 0 {
            
            let spawnWallsRight = SKAction.runBlock({
                () in
                self.createWallsRight()
            })
            
            let spawnWallsLeft = SKAction.runBlock({
                () in
                self.createWallsLeft()
            })
            
            wallDir = wallDir1

            
            // make new walls
            
            let spawnDelay        = SKAction.sequence([spawnWallsRight, delayWalls, spawnWallsLeft, delayWalls])
            let spawnDelayForever = SKAction.repeatActionForever(spawnDelay)
            self.runAction(spawnDelayForever)
            
            // move walls down
            
            let distanceWall = CGFloat(self.frame.width + wallPairRight.frame.width)
            let moveWall     = SKAction.moveByX(CGFloat(ball_dir) * xwallMove, y: -distanceWall, duration: NSTimeInterval(distanceWall/velocityWall))
            xwallMoveI       = xwallMove
            let removeWall   = SKAction.removeFromParent()
            moveAndRemove    = SKAction.sequence([moveWall , removeWall])
            
            //ball.physicsBody?.velocity = CGVector(dx: 50 , dy: 0)                                // ball: initial velocity [m/s]
            
            playState = 1

            print("Create walls, game started",playState)
            
            /*// move circles down
            
            let distanceCircle  = CGFloat(self.frame.width + circle.frame.width)
            let velocityCircle  = CGFloat(100)
            let moveCircles = SKAction.moveByX(0, y: -distanceCircle, duration: NSTimeInterval( distanceCircle/velocityCircle))
            let removeCircles = SKAction.removeFromParent()
            moveAndRemove2 = SKAction.sequence([moveCircles , removeCircles])*/
           
            
            //ball.physicsBody?.applyForce(CGVector(dx: 1000,dy: 0.0))
            
            //ball.physicsBody?.velocity =   CGVectorMake(0, 0)
            //ball.physicsBody?.applyImpulse(CGVectorMake(0, 0))
            
        }
        
        // state 1: Play
        if playState == 1 {
            ball_dir = ball_dir * (-1.0)
            //self.ball.physicsBody?.velocity = CGVector(dx:40, dy: 0)                         // ball: reset velocity [m/s]
            ball.physicsBody?.applyImpulse(CGVectorMake(CGFloat(ball_dir*(ximpulse+Double(score)*ximpMore)), 0)) // add impulse

            self.physicsWorld.gravity = CGVectorMake(CGFloat(ball_dir*xgravity), CGFloat(0))   // switch gravity
            //ball.physicsBody?.velocity = CGVector(dx: 50 , dy: 0)                            // ball: initial velocity [m/s]
            
            print("Press Ball Impulse: ",playState)
            
            
            // change wall speed
            
            if score >= 2 {
                xwallMoveI = xwallMoveI * (1.05)
            }
            
            print("xwallMove ------------------", score, xwallMoveI, wallDir, ball_dir)

            
            //ball.physicsBody?.velocity =   CGVectorMake(0, 0)
            //ball.physicsBody?.velocity =   CGVectorMake(0, 0)
            //let thrust  = CGVector(dx: 0,dy: 100.0)
            //ball.physicsBody?.applyForce(CGVector(dx: 0,dy: 20.0))                            // force
                
            //CGFloat shipDirection = [self shipDirection]
            //CGVector thrustVector = CGVectorMake(thrust*cosf(shipDirection),thrust*sinf(shipDirection))
            //[self.physicsBody applyForce:thrustVector]
        }
        
        // state 2: Dead
        if playState == 2 {
            //ball.physicsBody?.affectedByGravity = true
        }

        // state 3: Restart screen: Touch button to restart
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
        }
        else if firstBody.categoryBitMask == PhysicsCatagory.ball && secondBody.categoryBitMask == PhysicsCatagory.score {
            score  += 1
            wallDir = wallDir * (-1)
            print("Score2: ", score, wallDir)
            scoreLbl.text = "\(score)"
            secondBody.node?.removeFromParent()
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
            createBTN()
        }

        // change wall direction
        
        let distanceWall = CGFloat(self.frame.width + wallPairRight.frame.width)
        let moveWall     = SKAction.moveByX(CGFloat(wallDir) * xwallMoveI, y: -distanceWall,
                                            duration: NSTimeInterval(distanceWall/velocityWall))
        let removeWall   = SKAction.removeFromParent()
        moveAndRemove    = SKAction.sequence([moveWall , removeWall])
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