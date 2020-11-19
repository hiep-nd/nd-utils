Pod::Spec.new do |s|
  s.name         = "NDUtils"
  s.version      = "0.0.5.1"
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
  
  s.subspec 'Core_ObjC' do |ss|
    ss.source_files = "Sources/Core_ObjC/*.{h,m,mm,swift}"
  end

  s.subspec 'Core_Swift' do |ss|
    ss.dependency 'NDUtils/Core_ObjC'
  end

  s.subspec 'Core' do |ss|
    ss.dependency 'NDUtils/Core_Swift'
  end

  s.subspec 'libextobjc_ObjC' do |ss|
    ss.source_files = 'Sources/libextobjc_ObjC/*.{h,m,mm,swift}'

    ss.dependency 'NDUtils/Core_ObjC'
  end

  s.subspec 'libextobjc_Swift' do |ss|
    ss.dependency 'NDUtils/libextobjc_ObjC'
  end

  s.subspec 'libextobjc' do |ss|
    ss.dependency 'NDUtils/libextobjc_Swift'
  end

  s.subspec 'objc_ObjC' do |ss|
    ss.source_files = 'Sources/objc_ObjC/*.{h,m,mm,swift}'

    ss.dependency 'NDUtils/Core_ObjC'
    ss.dependency 'NDLog/ObjC', '~> 0.0.6'
  end

  s.subspec 'objc_Swift' do |ss|
    ss.dependency 'NDUtils/objc_ObjC'
  end

  s.subspec 'objc' do |ss|
    ss.dependency 'NDUtils/objc_Swift'
  end

  s.subspec 'Foundation_ObjC' do |ss|
    ss.source_files = 'Sources/Foundation_ObjC/*.{h,m,mm,swift}'

    ss.framework = 'Foundation'

    ss.dependency 'NDUtils/objc_ObjC'
    ss.dependency 'NDLog/ObjC', '~> 0.0.6'
  end

  s.subspec 'Foundation_Swift' do |ss|
    ss.source_files = 'Sources/Foundation_Swift/*.{h,m,mm,swift}'

    ss.dependency 'NDUtils/Foundation_ObjC'
  end

  s.subspec 'Foundation' do |ss|
    ss.dependency 'NDUtils/Foundation_Swift'
  end

  s.subspec 'QuartzCore_ObjC' do |ss|
    ss.source_files = 'Sources/QuartzCore_ObjC/*.{h,m,mm,swift}'

    ss.framework = 'QuartzCore'

    ss.dependency 'NDUtils/objc_ObjC'
  end

  s.subspec 'QuartzCore_Swift' do |ss|
    ss.source_files = 'Sources/QuartzCore_Swift/*.{h,m,mm,swift}'

    ss.dependency 'NDUtils/QuartzCore_ObjC'
  end

  s.subspec 'QuartzCore' do |ss|
    ss.dependency 'NDUtils/QuartzCore_Swift'
  end

  s.subspec 'UIKit_ObjC' do |ss|
    ss.source_files = 'Sources/UIKit_ObjC/*.{h,m,mm,swift}'

    ss.framework = 'UIKit'

    ss.dependency 'NDUtils/QuartzCore_ObjC'
  end

  s.subspec 'UIKit_Swift' do |ss|
    ss.source_files = 'Sources/UIKit_Swift/*.{h,m,mm,swift}'

    ss.dependency 'NDUtils/UIKit_ObjC'
  end

  s.subspec 'UIKit' do |ss|
    ss.dependency 'NDUtils/UIKit_Swift'
  end

  s.subspec 'ObjC' do |ss|
    ss.dependency 'NDUtils/Core_ObjC'
    ss.dependency 'NDUtils/libextobjc_ObjC'
    ss.dependency 'NDUtils/objc_ObjC'
    ss.dependency 'NDUtils/Foundation_ObjC'
    ss.dependency 'NDUtils/QuartzCore_ObjC'
    ss.dependency 'NDUtils/UIKit_ObjC'
  end

  s.subspec 'Swift' do |ss|
    ss.dependency 'NDUtils/Core_Swift'
    ss.dependency 'NDUtils/libextobjc_Swift'
    ss.dependency 'NDUtils/objc_Swift'
    ss.dependency 'NDUtils/Foundation_Swift'
    ss.dependency 'NDUtils/QuartzCore_Swift'
    ss.dependency 'NDUtils/UIKit_Swift'
  end

  s.default_subspec = 'Swift'
end
