class AsteroidScene < SKScene
  ASTEROID = 0x1 << 0
  ROCKET = 0x1 << 1

  attr_accessor :contentCreated

  def didMoveToView(view)
    self.physicsWorld.gravity = CGVectorMake(0,0)
    self.physicsWorld.contactDelegate = self

    unless contentCreated
      createSceneContents
      @contentCreated = true
    end
  end

  def didBeginContact(contact)
    if contact.bodyA.categoryBitMask < contact.bodyB.categoryBitMask
      firstBody = contact.bodyA
      secondBody = contact.bodyB
    else
      firstBody = contact.bodyB
      secondBody = contact.bodyA
    end

    if (firstBody.categoryBitMask && ASTEROID) != 0
      attack(secondBody.node, with: firstBody.node)
    end
  end

  def attack(rocket, with: asteroid)
    @rocketAlive = false
    rotate = SKAction.rotateByAngle(360, duration: 1.0)
    shrink = SKAction.scaleXBy(0.0, y: 0.0, duration: 0.90)
    resurrect = SKAction.scaleXBy(0.0, y: 0.0, duration: 0.90)
    center = SKAction.moveTo(CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)), duration: 0.1)
    grow = SKAction.scaleXTo(1.0, y: 1.0, duration: 0.2)
    rocket.runAction SKAction.sequence([rotate, shrink, center, SKAction.waitForDuration(1.0, withRange: 0.15), grow])
  end

  def didSimulatePhysics
    self.enumerateChildNodesWithName "asteroid", usingBlock: lambda { |node, stop| node.removeFromParent if node.position.y < 0 }
  end

  def touchesBegan(touches, withEvent: event)
    rocket = self.childNodeWithName("rocket")

    unless rocket.nil?
      location = touches.anyObject.locationInNode(self)
      rocket.runAction(SKAction.moveTo(location, duration: 1.0))
    end
  end

  def createSceneContents
    self.addChild newBackground
    self.scaleMode = SKSceneScaleModeAspectFit
    self.addChild newRocket
    make_asteroids = SKAction.sequence([SKAction.performSelector("addAsteroid", onTarget: self), SKAction.waitForDuration(1.0, withRange: 0.15)])
    self.runAction SKAction.repeatActionForever(make_asteroids)
  end

  def addAsteroid
    asteroid = AsteroidSprite.alloc.init
    self.addChild asteroid
    asteroid.runAction(SKAction.moveTo(asteroid.endPosition, duration: 2.0))
  end

  def newBackground
    background = SKSpriteNode.alloc.initWithImageNamed("background.png")
    background.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame))
    background.name = "background"
    background
  end

  def newRocket
    rocket = SKSpriteNode.alloc.initWithImageNamed("rocket.png")
    rocket.position = CGPointMake(CGRectGetMidX(self.frame), CGRectGetMidY(self.frame)-150)
    rocket.physicsBody = SKPhysicsBody.bodyWithRectangleOfSize(rocket.size)
    rocket.physicsBody.categoryBitMask = ROCKET
    rocket.physicsBody.contactTestBitMask = ASTEROID
    rocket.physicsBody.collisionBitMask = 0
    rocket.physicsBody.dynamic = true
    rocket.name = "rocket"
    rocket
  end
end
