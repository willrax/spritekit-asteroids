class AsteroidSprite < SKSpriteNode
  ASTEROID = 0x1 << 0
  ROCKET = 0x1 << 1

  attr_accessor :endPosition, :screenSide

  def init
    @screenSide = random(1..4)
    @endPosition = setFinalPosition

    self.initWithImageNamed("asteroid_#{random(1..4)}.png")
    self.position = setInitialPostion
    self.physicsBody = SKPhysicsBody.bodyWithCircleOfRadius(self.size.width/2)
    self.physicsBody.categoryBitMask = ASTEROID
    self.physicsBody.contactTestBitMask = ROCKET
    self.physicsBody.collisionBitMask = 0
    self.physicsBody.dynamic = true
    self.physicsBody.usesPreciseCollisionDetection = true
    self.name = "asteroid"
    self
  end

  def random(range)
    Random.new.rand(range)
  end

  def screen
    UIScreen.mainScreen.bounds.size
  end

  def setInitialPostion
    case screenSide
    when 1
      [-96, random(1..screen.width)]
    when 2
      [screen.height + 96, random(1..screen.width)]
    when 3
      [random(1..screen.height), screen.width + 96]
    when 4
      [random(1..screen.height), -96]
    end
  end

  def setFinalPosition
    case screenSide
    when 1
      [screen.height + 96, random(1..screen.width)]
    when 2
      [-96, random(1..screen.width)]
    when 3
      [random(1..screen.height), -96]
    when 4
      [random(1..screen.height), screen.width + 96]
    end
  end
end
