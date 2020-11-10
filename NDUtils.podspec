Pod::Spec.new do |s|
  s.name         = "NDUtils"
  s.version      = "0.0.5"
  s.summary      = "Utility for Foundation, UIKit,...."
  s.description  = <<-DESC
  NDUtils is a small utility framework for Foundation, UIKit,....
                   DESC
  s.homepage     = "https://github.com/hiep-nd/nd-utils.git"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.author             = { "Nguyen Duc Hiep" => "hiep.nd@gmail.com" }
  s.ios.deployment_target = '9.0'
#  s.tvos.deployment_target = '9.0'
  s.swift_versions = ['4.0', '5.1', '5.2']
  #s.source        = { :http => 'file:' + URI.escape(__dir__) + '/' }
  s.source       = { :git => "https://github.com/hiep-nd/nd-utils.git", :tag => "Pod-#{s.version}" }
  
  s.subspec 'Core' do |ss|
    ss.source_files = "Sources/Core/*.{h,m,mm,swift}"
  end

  s.subspec 'libextobjc' do |ss|
    ss.source_files = 'Sources/libextobjc/*.{h,m,mm,swift}'
    ss.dependency 'NDUtils/Core'
  end

  s.subspec 'objc' do |ss|
    ss.source_files = 'Sources/objc/*.{h,m,mm,swift}'
    ss.dependency 'NDUtils/Core'
    ss.dependency 'NDLog', '~> 0.0.6'
  end

  s.subspec 'Foundation' do |ss|
    ss.source_files = 'Sources/Foundation/*.{h,m,mm,swift}'
    ss.framework = 'Foundation'
    ss.dependency 'NDUtils/Core'
    ss.dependency 'NDLog', '~> 0.0.6'
  end

  s.subspec 'Foundation_Swift' do |ss|
    ss.source_files = 'Sources/Foundation_Swift/*.{h,m,mm,swift}'
    ss.dependency 'NDUtils/Foundation'
  end

  s.subspec 'QuartzCore' do |ss|
    ss.source_files = 'Sources/QuartzCore/*.{h,m,mm,swift}'
    ss.framework = 'QuartzCore'
    ss.dependency 'NDUtils/objc'
  end

  s.subspec 'QuartzCore_Swift' do |ss|
    ss.source_files = 'Sources/QuartzCore_Swift/*.{h,m,mm,swift}'
    ss.dependency 'NDUtils/QuartzCore'
  end

  s.subspec 'UIKit' do |ss|
    ss.source_files = 'Sources/UIKit/*.{h,m,mm,swift}'
    ss.framework = 'UIKit'
    ss.dependency 'NDUtils/QuartzCore'
  end

  s.subspec 'UIKit_Swift' do |ss|
    ss.source_files = 'Sources/UIKit_Swift/*.{h,m,mm,swift}'
    ss.dependency 'NDUtils/UIKit'
  end

  s.subspec 'ObjC' do |ss|
    ss.dependency 'NDUtils/Core'
    ss.dependency 'NDUtils/libextobjc'
    ss.dependency 'NDUtils/objc'
    ss.dependency 'NDUtils/Foundation'
    ss.dependency 'NDUtils/QuartzCore'
    ss.dependency 'NDUtils/UIKit'
  end

  s.subspec 'Swift' do |ss|
    ss.dependency 'NDUtils/Core'
    ss.dependency 'NDUtils/libextobjc'
    ss.dependency 'NDUtils/objc'
    ss.dependency 'NDUtils/Foundation_Swift'
    ss.dependency 'NDUtils/QuartzCore_Swift'
    ss.dependency 'NDUtils/UIKit_Swift'
  end

  s.default_subspec = 'Swift'
end
