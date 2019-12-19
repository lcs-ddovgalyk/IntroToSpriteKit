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
     
        
        // Create an action to animate a walking motion using the hero sprites array (walkingTextures)
        let actionWalkingAnimation = SKAction.animate(with: walkingTextures, timePerFrame: 0.2, resize: true, restore: true)

        // Create an action that moves the hero forward a "step" where a step is 10 pixels
        // NOTE: The time interval for moving forward matches the time per frame of the animation
        
        let actionMoveForward = SKAction.moveBy(x: 27, y: 0, duration: 0.2)

        // Repeat the move forward action twice
        let actionMoveForwardTwice = SKAction.repeat(actionMoveForward, count: 2)

        // Now, combine the walking animation with the sprite moving forward
        let actionWalkAndMove = SKAction.group([actionWalkingAnimation, actionMoveForwardTwice])

        // Repeat the "walk and move" action five times
        let actionWalkAndMoveNTTimes = SKAction.repeat(actionWalkAndMove, count: 7)

        // Make the hero walk and move forward five times
        hero.run(actionWalkAndMoveNTTimes)
        // Create an empty array of SKTexture objects
        var shooting: [SKTexture] = []
        // Now add the two images we need in the array

        shooting.append(SKTexture(imageNamed: "AXmasSnowdown_38"))
        shooting.append(SKTexture(imageNamed: "AXmasSnowdown_43"))
        shooting.append(SKTexture(imageNamed: "AXmasSnowdown_38"))
        shooting.append(SKTexture(imageNamed: "AXmasSnowdown_40"))
        shooting.append(SKTexture(imageNamed: "AXmasSnowdown_38"))
        shooting.append(SKTexture(imageNamed: "AXmasSnowdown_44"))

        //creates a shooting animation
        let actionShoot = SKAction.animate(with: shooting, timePerFrame: 0.5, resize: true, restore: true)
        //makes the hero wait before shooting
        let actionWaitBeforeShooting = SKAction.wait(forDuration: 2.5)
        //creates a sequence, wait, then shoot
        let sequenceWaitShoot = SKAction.sequence([actionWaitBeforeShooting, actionShoot])
        //Make the hero shoot :)
        hero.run(sequenceWaitShoot)
        //makes the hero wait and then leave the screen
        let actionWaitUntilShot = SKAction.wait(forDuration: 5)
        let actionWalkAgain = SKAction.sequence([actionWaitUntilShot, actionWalkAndMoveNTTimes])
        //makes the hero leave the screen :)
        let actionLeaveScreen = SKAction.sequence([actionWalkAgain, actionMoveForwardTwice, actionMoveForwardTwice])
        hero.run(actionLeaveScreen)
        
        
        
        //defines a new node
        let snowBall = SKSpriteNode(imageNamed: "snowBall")
        //positions the node
        snowBall.position = CGPoint(x: self.size.width / 2, y: 35)
        //makes the node wait a certain amount of time before appearing
        let actionWaitAfterShot = SKAction.wait(forDuration: 3.0)
        //adding the node when this function is called
        let actionSpawn = SKAction.run{self.addChild(snowBall)}
        //wait and then add the node
        let actionWaitThenSpawn = SKAction.sequence([actionWaitAfterShot, actionSpawn])
        //adds the snowball
        hero.run(actionWaitThenSpawn)
        let actionFly = SKAction.moveBy(x: 0, y: 400, duration: 5)
        snowBall.run(actionFly)
        
        // ADDS A SECOND SNOWBALL
        let snowBall2 = SKSpriteNode(imageNamed: "snowBall")
        //positions the node
        snowBall2.position = CGPoint(x: self.size.width / 2, y: 35)
        //makes the node wait a certain amount of time before appearing
        let actionWaitAfterShot2 = SKAction.wait(forDuration: 3.5)
        //adding the node when this function is called
        let actionSpawn2 = SKAction.run{self.addChild(snowBall2)}
        //wait and then add the node
        let actionWaitThenSpawn2 = SKAction.sequence([actionWaitAfterShot2, actionSpawn2])
        //adds the snowball
        hero.run(actionWaitThenSpawn2)
        let actionFly2 = SKAction.moveBy(x: -400, y: 400, duration: 5)
        snowBall2.run(actionFly2)
    
        // ADDS A 3RD SNOWBALL
        let snowBall3 = SKSpriteNode(imageNamed: "snowBall")
        //positions the node
        snowBall3.position = CGPoint(x: self.size.width / 2, y: 35)
        //makes the node wait a certain amount of time before appearing
        let actionWaitAfterShot3 = SKAction.wait(forDuration: 4.0)
        //adding the node when this function is called
        let actionSpawn3 = SKAction.run{self.addChild(snowBall3)}
        //wait and then add the node
        let actionWaitThenSpawn3 = SKAction.sequence([actionWaitAfterShot3, actionSpawn3])
        //adds the snowball
        hero.run(actionWaitThenSpawn3)
        let actionFly3 = SKAction.moveBy(x: 500, y: 400, duration: 5)
        snowBall3.run(actionFly3)
        
        //NOTE: I know I could have created a function for this, but it was easier this way. It's just 3 snowballs
        
        //FOLLOWING CODE IS adding the Christmas Decorations to the animation

        let christmasDecor = SKSpriteNode(imageNamed: "ChristmasDecor-1")
        christmasDecor.position = CGPoint(x: self.size.width / 2, y:500)
        let actionWaitToAppear = SKAction.wait(forDuration: 8.0)
        let actionSpawnChristmasDecor = SKAction.run{self.addChild(christmasDecor)}
        let actionWaitToSpawn = SKAction.sequence([actionWaitToAppear, actionSpawnChristmasDecor])
        hero.run(actionWaitToSpawn)
        
        
        var blincking: [SKTexture] = []
        // Now add the two images we need in the array
        //Repeats the loop 10 times
        for _ in 1...10{
            blincking.append(SKTexture(imageNamed: "ChristmasDecor-1"))
            blincking.append(SKTexture(imageNamed: "ChristmasDecor-2"))
        }
        //animates the nodes
        let actionBlinck = SKAction.animate(with: blincking, timePerFrame: 0.5, resize: true, restore: true)
        christmasDecor.run(actionBlinck)
        
        
        
        //FOLLOWING CODE IS adding the Christmas Tree to the animation
        let christmasTree = SKSpriteNode(imageNamed: "christmasTree-1")
        christmasTree.position = CGPoint(x: self.size.width * 3/4, y:200)
        let actionWaitToAppearCT = SKAction.wait(forDuration: 8.0)
        let actionSpawnChristmasTree = SKAction.run{self.addChild(christmasTree)}
        let actionWaitToSpawnCT = SKAction.sequence([actionWaitToAppearCT, actionSpawnChristmasTree])
        hero.run(actionWaitToSpawnCT)
        var blinckingTree: [SKTexture] = []
            // Now add the two images we need in the array
            //Repeats the loop 10 times
            for _ in 1...10{
                blinckingTree.append(SKTexture(imageNamed: "christmasTree-1"))
                blinckingTree.append(SKTexture(imageNamed: "christmasTree-2"))
            }
            //animates the nodes
        let actionBlinckTree = SKAction.animate(with: blinckingTree, timePerFrame: 0.5, resize: true, restore: true)
        christmasTree.run(actionBlinckTree)
        
        
        
        
        //FOLLOWING CODE IS adding 'Merry Christmas' To the animation
        let merryChristmas = SKSpriteNode(imageNamed: "MC-1")
        merryChristmas.position = CGPoint(x: self.size.width / 4, y: 200)
        let actionWaitToAppearMC = SKAction.wait(forDuration: 8.0)
        let actionSpawnMarryChristmas = SKAction.run{self.addChild(merryChristmas)}
        let actionWaitToSpawnMC = SKAction.sequence([actionWaitToAppearMC, actionSpawnMarryChristmas])
        hero.run(actionWaitToSpawnMC)
        var blinckingMC: [SKTexture] = []
            // Now add the two images we need in the array
            //Repeats the loop 10 times
            for _ in 1...10{
                blinckingMC.append(SKTexture(imageNamed: "MC-1"))
                blinckingMC.append(SKTexture(imageNamed: "MC-2"))
                blinckingMC.append(SKTexture(imageNamed: "MC-3"))
                blinckingMC.append(SKTexture(imageNamed: "MC-4"))
            }
            //animates the nodes
        let actionBlinckMC = SKAction.animate(with: blinckingMC, timePerFrame: 0.5, resize: true, restore: true)
        merryChristmas.run(actionBlinckMC)
        
        

    }
    
    
    // This runs before each frame is rendered
    // Avoid putting computationally intense code in this function to maintain high performance
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
    
}
