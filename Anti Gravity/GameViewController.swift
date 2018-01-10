//
//  GameViewController.swift
//  Anti Gravity
//
//  Created by Etienne Köhler on 18/06/16.
//  Copyright (c) 2016 Moseby Inc. All rights reserved.
//

import UIKit
import SpriteKit
import GoogleMobileAds

class GameViewController: UIViewController {
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        let request = GADRequest()
        

        request.testDevices = [kGADSimulatorID, "002cfa7b054e7c77dffd89e05c43a426"]
        interstitial.load(request)

        sleep(30)
        /*if interstitial.isReady{*/
            interstitial.present(fromRootViewController: self)
            print("Ad is ready")
       /* }
        else{
            print("Ad not ready")
        }*/
        sleep(3)
        
        
        if let scene = GameScene(fileNamed:"GameScene") {
            // Configure the view.
            let skView = self.view as! SKView
            skView.showsFPS = false
            skView.showsNodeCount = false
            
            skView.showsPhysics = false          //show body outlines
            /* Sprite Kit applies additional optimizations to improve rendering performance */
            skView.ignoresSiblingOrder = true
            
            /* Set the scale mode to scale to fit the window */
            scene.scaleMode = .aspectFill
            
            skView.presentScene(scene)
        }
    }
    
    
    
    
    override var shouldAutorotate : Bool {
        return true
    }

    
    override var supportedInterfaceOrientations : UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    
    override var prefersStatusBarHidden : Bool {
        return true
    }
}
