#
#  Be sure to run `pod spec lint SwiftHelpSet.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "SwiftHelpSet"
  s.version      = "1.1"
  s.summary      = "A set of Swift utilities."
  s.description  = <<-DESC
                  SwiftHelpSet is a set of Swift utilities for you iOS project.
                   DESC

  s.homepage     = "https://github.com/dalu93/SwiftHelpSet"

  s.license      = "MIT"

  s.author             = { "Luca D'Alberti" => "dalberti.luca93@gmail.com" }
  s.social_media_url   = "https://twitter.com/DAlbertiLuca"

  s.platform     = :ios, "8.0"

  s.source       = { :git => "https://github.com/dalu93/SwiftHelpSet.git", :tag => s.version.to_s }

  s.source_files  = "Sources/**/*.swift"
  s.requires_arc = true
end
