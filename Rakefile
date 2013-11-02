# -*- coding: utf-8 -*-
$:.unshift("/Library/RubyMotion/lib")
require "motion/project/template/ios"

begin
  require "bundler"
  Bundler.require
rescue LoadError
end

Motion::Project::App.setup do |app|
  app.name = "Asteroids"
  app.device_family = :ipad
  app.frameworks += ["SpriteKit"]
  app.interface_orientations = [:landscape_left]
  app.icons = ['icon.png', 'icon@2x.png']
  app.prerendered_icon = true
end
