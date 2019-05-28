Pod::Spec.new do |spec|

  spec.name         = "GTEasyLayout"
  spec.version      = "1.0.1"
  spec.summary      = "Add subviews to views, setup constraints and update them animated with one line of code only!"
  spec.description  = <<-DESC
                    GTEasyLayout is a small framework written in Swift which aims to minimise the effort of adding subviews and setting up their constraints when implementing UI in code for iOS apps.
                   DESC
  spec.homepage     = "https://github.com/gabrieltheodoropoulos/GTEasyLayout.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Gabriel Theodoropoulos" => "gabrielth.devel@gmail.com" }
  spec.social_media_url   = "https://twitter.com/gabtheodor"
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/gabrieltheodoropoulos/GTEasyLayout.git", :tag => "1.0.1" }
  spec.source_files = "GTEasyLayout/Source/*.{swift}"
  spec.swift_version = "5.0"

end
