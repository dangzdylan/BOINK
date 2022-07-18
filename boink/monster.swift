//
//  monster.swift
//  dodge2
//
//  Created by Dylan on 8/2/21.
//  Copyright © 2021 S-Crew. All rights reserved.
//

import SpriteKit
import GameplayKit
import AVFoundation
import GameKit
import UIKit


func createMonster(self:SKScene, Monster:SKSpriteNode){
    Monster.texture = SKTexture(imageNamed:"enemy")
    
    monsterArray.append(Monster)
    
    
    //monster physic body info
    Monster.physicsBody = SKPhysicsBody(circleOfRadius: monsterDiameter / 2)
    Monster.physicsBody?.restitution = 1
    Monster.physicsBody?.friction = 0
    Monster.physicsBody?.isDynamic = true
    Monster.physicsBody?.categoryBitMask = ColliderType.Monster
    Monster.physicsBody?.collisionBitMask = ColliderType.MonsterNoCollide
    //Monster.physicsBody?.collisionBitMask = ColliderType.topBorder | ColliderType.bottomBorder | ColliderType.leftBorder | ColliderType.rightBorder
    Monster.physicsBody?.contactTestBitMask = ColliderType.topBorder | ColliderType.bottomBorder | ColliderType.leftBorder | ColliderType.rightBorder
    Monster.physicsBody?.linearDamping = 0
    Monster.physicsBody?.angularDamping = 0
    Monster.physicsBody?.affectedByGravity = false
    Monster.physicsBody?.mass = PlayerMonsterMassConstant
}

//for debug corner case
func debugMonster(self:SKScene){
    let Monster = SKSpriteNode(color: .blue, size: CGSize(width: monsterDiameter, height: monsterDiameter))
    createMonster(self: self, Monster: Monster)
    
    Monster.position = CGPoint(x: -xPointBorder + screenHeight/10, y: yPointBorder - screenHeight/10)
    
    self.addChild(Monster)
    Monster.run(SKAction.repeatForever(monsterAnimation_TL))
    
    Monster.physicsBody?.applyImpulse(CGVector(dx: -monsterSpeed, dy: monsterSpeed))
}

func spawnMonster(self:SKScene){
    
    //build monster
    let Monster = SKSpriteNode(color: .blue, size: CGSize(width: monsterDiameter, height: monsterDiameter))
    createMonster(self: self, Monster: Monster)
    
    // position
    let spawnPoint = determineMonsterSpawn()
    
    Monster.position = spawnPoint.position
    
    //impulse
    var monsterSpeedArr = [-monsterSpeed, -monsterSpeed]
    if spawnPoint.position.x < 0{
        monsterSpeedArr[0] *= -1
    }
    if spawnPoint.position.y < 0{
        monsterSpeedArr[1] *= -1
    }
    Monster.zPosition = spawnPoint.zPosition + 1
    
    var tempMonsterAnimation:SKAction = monsterAnimation_BL
    //texture angle
    if spawnPoint == spawner1{
        Monster.texture = monsterBottomLeft
        tempMonsterAnimation = monsterAnimation_BL
    }else if spawnPoint == spawner2{
        Monster.texture = monsterBottomRight
        tempMonsterAnimation = monsterAnimation_BR
    }else if spawnPoint == spawner3{
        Monster.texture = monsterTopRight
        tempMonsterAnimation = monsterAnimation_TR
    }else if spawnPoint == spawner4{
        Monster.texture = monsterTopLeft
        tempMonsterAnimation = monsterAnimation_TL
    }
    
    //add to scene and delay spawn
    let spawnAnimation = SKAction.animate(with: monsterSpawningTextures, timePerFrame: 9/64)
    spawnPoint.run(spawnAnimation)
    

    Timer.scheduledTimer(withTimeInterval: 9/8, repeats: false){timer in
        self.addChild(Monster)
        Monster.run(SKAction.repeatForever(tempMonsterAnimation))
        Monster.physicsBody?.applyImpulse(CGVector(dx: monsterSpeedArr[0], dy: monsterSpeedArr[1]))
        playSound(soundPlayer: SPKey.monsterDispenseSoundPlayer)
    }

    
}

func determineMonsterSpawn() -> SKSpriteNode{
    
    let bigNum:Float = 100000
    var minDistances = [spawner1 : bigNum,
                        spawner2 : bigNum,
                        spawner3 : bigNum,
                        spawner4 : bigNum]
    //no monster on scene
    if monsterArray.count <= 1{
        let theSpawnerArr = [spawner1, spawner2, spawner3, spawner4]
        return theSpawnerArr.randomElement()!
    }
    
    //find min distances
    for monster in monsterArray{
        for spawner in minDistances.keys{
            let distX:Float = Float(spawner.position.x - monster.position.x)
            let distY:Float = Float(spawner.position.y - monster.position.y)
            let distance = sqrtf(powf(distX, 2) + powf(distY, 2))
            minDistances[spawner] = min(distance, minDistances[spawner]!)
        }
    }
    
    //find spawner with max distances
    var minSpawner = spawner1
    for spawner in minDistances.keys{
        if minDistances[spawner]! > minDistances[minSpawner]!{
            minSpawner = spawner
        }
    }
    
    return minSpawner
}

func monsterMovement(bodyA:SKPhysicsBody, collision:UInt32){
    var monsterImpulse:[CGFloat] = [monsterSpeed, monsterSpeed]

    if collision == ColliderType.Monster | ColliderType.topBorder{
        if bodyA.velocity.dx > 0 && bodyA.velocity.dy > 0{
            monsterImpulse[1] *= -1
        }else{
            monsterImpulse[0] *= -1
            monsterImpulse[1] *= -1
        }
        monsterTextureRotation(monsterBody: bodyA, borderBit: ColliderType.topBorder, monsterImpulse: monsterImpulse)
        
    } else if collision == ColliderType.Monster | ColliderType.bottomBorder{
        if bodyA.velocity.dx < 0 && bodyA.velocity.dy < 0{
            monsterImpulse[0] *= -1
        }
        monsterTextureRotation(monsterBody: bodyA, borderBit: ColliderType.bottomBorder, monsterImpulse: monsterImpulse)
        
    }else if collision == ColliderType.Monster | ColliderType.rightBorder{
        if bodyA.velocity.dx > 0 && bodyA.velocity.dy > 0{
            monsterImpulse[0] *= -1
        }else{
            monsterImpulse[0] *= -1
            monsterImpulse[1] *= -1
        }
        monsterTextureRotation(monsterBody: bodyA, borderBit: ColliderType.rightBorder, monsterImpulse: monsterImpulse)
        
    }else if collision == ColliderType.Monster | ColliderType.leftBorder{
        if bodyA.velocity.dx < 0 && bodyA.velocity.dy < 0{
            monsterImpulse[1] *= -1
        }
        monsterTextureRotation(monsterBody: bodyA, borderBit: ColliderType.leftBorder, monsterImpulse: monsterImpulse)
    }
    
    bodyA.velocity = CGVector(dx:0, dy:0)
    bodyA.applyImpulse(CGVector(dx: monsterImpulse[0], dy: monsterImpulse[1]))
}

func monsterTextureRotation(monsterBody:SKPhysicsBody, borderBit: UInt32, monsterImpulse:[CGFloat]){
    
    let monster = monsterBody.node as! SKSpriteNode
    
    if borderBit == ColliderType.topBorder{
        if monsterImpulse[0] > 0{
            monster.run(SKAction.repeatForever(monsterAnimation_BR))
        }else{
            monster.run(SKAction.repeatForever(monsterAnimation_BL))
        }
    }else if borderBit == ColliderType.bottomBorder{
        if monsterImpulse[0] > 0{
            monster.run(SKAction.repeatForever(monsterAnimation_TR))
        }else{
            monster.run(SKAction.repeatForever(monsterAnimation_TL))
        }
        
    }else if borderBit == ColliderType.rightBorder{
        if monsterImpulse[1] > 0{
            monster.run(SKAction.repeatForever(monsterAnimation_TL))
        }else{
            monster.run(SKAction.repeatForever(monsterAnimation_BL))
        }
        
    }else if borderBit == ColliderType.leftBorder{
        if monsterImpulse[1] > 0{
            monster.run(SKAction.repeatForever(monsterAnimation_TR))
        }else{
            monster.run(SKAction.repeatForever(monsterAnimation_BR))
        }
    }
    
    
    
}

func addSpawner(self:SKScene){
    //vars
    let spawnerColor:UIColor = .blue
    let spawnerSize = Player.size
    let spawnerTexture = SKTexture(imageNamed: "enemySpawn")
    
    //node dec
    spawner1 = SKSpriteNode(color: spawnerColor, size: spawnerSize)
    spawner2 = SKSpriteNode(color: spawnerColor, size: spawnerSize)
    spawner3 = SKSpriteNode(color: spawnerColor, size: spawnerSize)
    spawner4 = SKSpriteNode(color: spawnerColor, size: spawnerSize)

    //texture
    spawner1.texture = spawnerTexture
    spawner2.texture = spawnerTexture
    spawner3.texture = spawnerTexture
    spawner4.texture = spawnerTexture
    
    //xy coord
    let space = spawner1.size.width/2 + screenHeight/300
    let zpos:CGFloat = -9
    spawner1.position = CGPoint(x: xPointBorder - space, y: yPointBorder - space)
    spawner2.position = CGPoint(x: -xPointBorder + space, y: yPointBorder - space)
    spawner3.position = CGPoint(x: -xPointBorder + space, y: -yPointBorder + space)
    spawner4.position = CGPoint(x: xPointBorder - space, y: -yPointBorder + space)
    
    //z coord
    spawner1.zPosition = zpos
    spawner2.zPosition = zpos
    spawner3.zPosition = zpos
    spawner4.zPosition = zpos
    
    //add to scene
    self.addChild(spawner1)
    self.addChild(spawner2)
    self.addChild(spawner3)
    self.addChild(spawner4)
    
}




