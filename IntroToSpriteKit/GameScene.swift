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
        let actionRepeatlyAddSnowFlake = SKAction.repeat(sequenceSpawnThenWait, count: 300)
        //adds snowflakes to the scene
        self.run(actionRepeatlyAddSnowFlake)
        self.run(actionRepeatlyAddSnowFlake)
        self.run(actionRepeatlyAddSnowFlake)

        let hero = SKSpriteNode(imageNamed: "AOCXmasGifts_01")
        hero.position = CGPoint(x: hero.size.width / 2, y: hero.size.height / 2)
        hero.physicsBody?.isDynamic = false
        self.addChild(hero)
        // Create an empty array of SKTexture objects
        var walkingTextures: [SKTexture] = []

        // Now add the two images we need in the array
        walkingTextures.append(SKTexture(imageNamed: "AOCXmasGifts_01"))
        walkingTextures.append(SKTexture(imageNamed: "AOCXmasGifts_02"))
        //walkingTextures.append(SKTexture(imageNamed: "AOCXmasGifts_03"))
     
        
        // Create an action to animate a walking motion using the hero sprites array (walkingTextures)
        let actionWalkingAnimation = SKAction.animate(with: walkingTextures, timePerFrame: 0.2, resize: true, restore: true)

        // Create an action that moves the hero forward a "step" where a step is 10 pixels
        // NOTE: The time interval for moving forward matches the time per frame of the animation
        let actionMoveForward = SKAction.moveBy(x: 10, y: 0, duration: 0.2)

        // Repeat the move forward action twice
        let actionMoveForwardTwice = SKAction.repeat(actionMoveForward, count: 2)

        // Now, combine the walking animation with the sprite moving forward
        let actionWalkAndMove = SKAction.group([actionWalkingAnimation, actionMoveForwardTwice])

        // Repeat the "walk and move" action five times
        let actionWalkAndMoveFiveTimes = SKAction.repeat(actionWalkAndMove, count: 20)

        // Make the hero walk and move forward five times
        hero.run(actionWalkAndMoveFiveTimes)

        
        
    }
    
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
