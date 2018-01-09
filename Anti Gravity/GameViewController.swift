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

class GameViewController: UIViewController, GADInterstitialDelegate {
    
    var interstitial: GADInterstitial!
    
    override func viewDidLoad() {
        
        
        super.viewDidLoad()
        
        // Display the intertitial ad
        interstitial = createAndLoadInterstitial()
        sleep(10)
        //interstitial.present(fromRootViewController: self)
        
        /*
        // Create an interstitial ad object
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")
        
        sleep(20)
        
        // Load an ad
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID ]                    // Simulator
        //request.testDevices = [ "324fa66e90db8adaf778cbe57e9aaf77" ]   // Martin iPhone 6
        //request.testDevices = [ "2077ef9a63d2b398840261c8221a0c9b" ] // An example device ID
        interstitial.load(request)
        print("Loading ad")
        
        sleep(20)
        
        // Show the ad
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            print("Ad showing !!!!!!!!!!")
        } else {
            print("Ad wasn't ready")
        }
        
        sleep(10)
 
        */

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
    
    
    // AdMob: listen to notification from GameScene
    
    override func viewWillLayoutSubviews() {
        NotificationCenter.default.addObserver(self, selector: #selector(self.startAdMobAd), name: NSNotification.Name(rawValue: "showAdMobAd"), object: nil)
    }
    
    // Show interstitial ad
    
    func startAdMobAd() {
        if interstitial.isReady {
            interstitial.present(fromRootViewController: self)
            print("Interstitial showing ------------")
        } else {
            print("Interstitial wasn't ready -------------")
        }
    }
    
    // Create and load interstitial ad
    
    private func createAndLoadInterstitial() -> GADInterstitial? {
        //interstitial = GADInterstitial(adUnitID: "ca-app-pub-8501671653071605/2568258533")   // sample ad unit ID ???
        interstitial = GADInterstitial(adUnitID: "ca-app-pub-3940256099942544/4411468910")   // interstitial sample ad unit ID
        guard let interstitial = interstitial else {
            return nil
        }
        let request = GADRequest()
        request.testDevices = [ kGADSimulatorID ]
        interstitial.load(request)
        interstitial.delegate = self
        return interstitial
    }
    
    // GADInterstitialDelegate methods
    
    func interstitialDidReceiveAd(_ ad: GADInterstitial) {
        print("Interstitial loaded successfully ----------------")
        //ad.present(fromRootViewController: self)
    }
    
    func interstitialDidDismissScreen(_ ad: GADInterstitial) {
        print("Interstitial was dismissed ----------------")
        interstitial = createAndLoadInterstitial()
    }
    
    func interstitialDidFail(toPresentScreen ad: GADInterstitial) {
        print("Fail to receive interstitial ---------------")
    }
    
}
