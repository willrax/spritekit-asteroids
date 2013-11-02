class GameSceneViewController < UIViewController
  def viewDidLoad
    super
    self.view = GameSceneView.alloc.init
  end

  def viewWillLayoutSubviews
    super

    unless self.view.scene
      asteroid = AsteroidScene.alloc.initWithSize(self.view.bounds.size)
      self.view.presentScene asteroid
    end
  end
end
