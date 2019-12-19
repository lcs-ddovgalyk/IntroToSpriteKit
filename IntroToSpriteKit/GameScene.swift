//
//  GameScene.swift
//  IntroToSpriteKit
//
//  Created by Russell Gordon on 2019-12-07.
//  Copyright © 2019 Russell Gordon. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation

class GameScene: SKScene {
    
    // Background music player
    var backgroundMusic: AVAudioPlayer?
    
    // This function runs once to set up the scene
    override func didMove(to view: SKView) {
        
        // Set the background colour
        self.backgroundColor = .black
        
//        // Get a reference to the mp3 file in the app bundle
//        let backgroundMusicFilePath = Bundle.main.path(forResource: "sleigh-bells-excerpt.mp3", ofType: nil)!
//
//        // Convert the file path string to a URL (Uniform Resource Locator)
//        let backgroundMusicFileURL = URL(fileURLWithPath: backgroundMusicFilePath)
//
//        // Attempt to open and play the file at the given URL
//        do {
//            backgroundMusic = try AVAudioPlayer(contentsOf: backgroundMusicFileURL)
//            backgroundMusic?.play()
//        } catch {
//            // Do nothing if the sound file could not be played
//        }
        
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: self.frame)
        // creates a function to spawn snow flakes
        func spawnSnowFlake() {
            let snowflake = SKSpriteNode(imageNamed: "snowflake")

            //generates a number between 0 and the size of the scene ( width )
            let randomNumber = CGFloat.random(in: 0...self.size.width)
            // puts the snowflake into a position
            snowflake.position = CGPoint(x: randomNumber, y: self.size.height)
            //gives the snowflake a physics body ( affected by physics )
            snowflake.physicsBody = SKPhysicsBody(circleOfRadius: snowflake.size.width * 0.5)
            //adds the snowflake to the scene
            self.addChild(snowflake)
            //removes the snowflake after a second 
            snowflake.run(SKAction.sequence([SKAction.wait(forDuration: 1.0),SKAction.removeFromParent()]))
            
        }
        //calls the function above
        let actionSpawnSnowFlake = SKAction.run(spawnSnowFlake)
        //waits 0.1 seconds
        let actionWait = SKAction.wait(forDuration: 0.1)
        //creates a sequence, first add then wait
        let sequenceSpawnThenWait = SKAction.sequence([actionSpawnSnowFlake, actionWait])
        //repeats the sequence 1000 times
        let actionRepeatlyAddSnowFlake = SKAction.repeat(sequenceSpawnThenWait, count: 1000)
        //adds snowflakes to the scene
        self.run(actionRepeatlyAddSnowFlake)
        
//        let actionWaitTenSec = SKAction.wait(forDuration: 10)
//        let actionRemoveAllSnowFlakes = SKAction.removeFromParent()
//        let sequenceDespawn = SKAction.sequence([actionWaitTenSec, actionRemoveAllSnowFlakes])
//        self.run(sequenceDespawn)
//
        
        
    }
    
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
