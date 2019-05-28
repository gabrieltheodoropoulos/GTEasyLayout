Pod::Spec.new do |spec|

  spec.name         = "GTEasyLayout"
  spec.version      = "1.0.0"
  spec.summary      = "Add subviews to views, setup constraints and update them animated in one line!"
  spec.description  = <<-DESC
                    GTEasyLayout minimizes the effort of adding subviews and setting up their constraints when implementing the UI in code. It's basically a Swift protocol with the defined methods already implemented, and it's backed by custom defined types.
                   DESC
  spec.homepage     = "https://github.com/gabrieltheodoropoulos/GTEasyLayout.git"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.authors      = { "Gabriel Theodoropoulos" => "gabrielth.devel@gmail.com" }
  spec.social_media_url   = "https://twitter.com/gabtheodor"
  spec.platform     = :ios, "11.0"
  spec.source       = { :git => "https://github.com/gabrieltheodoropoulos/GTEasyLayout.git", :tag => "1.0.0" }
  spec.source_files = "GTEasyLayout/Source/*.{swift}"
  spec.swift_version = "5.0"

end
