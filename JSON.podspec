Pod::Spec.new do |s|
  s.name             = 'JSON'
  s.version          = '0.1.0'
  s.summary          = 'A lightweight JSON wrapper written in Swift'
  s.homepage         = 'https://github.com/nero-tang/JSON'
  s.license          = { :type => 'MIT' }
  s.author           = { 'nero-tang' => 'nero.tangyufei@gmail.com' }
  s.source           = { :git => 'https://github.com/nero-tang/JSON.git', :tag => s.version.to_s }
  s.swift_version    = "5.0"
  s.osx.deployment_target = "10.9"
  s.ios.deployment_target = "9.0"
  s.watchos.deployment_target = "3.0"
  s.tvos.deployment_target = "9.0"
  s.source_files = 'JSON/Classes/**/*.swift'
end
