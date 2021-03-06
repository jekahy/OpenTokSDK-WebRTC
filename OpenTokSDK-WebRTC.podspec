Pod::Spec.new do |s|

  s.name         = "OpenTokSDK-WebRTC"
  s.version      = "2.2"
  s.summary      = "A podspec that wraps the OpenTok iOS WebRTC SDK and only links against ARM"

  s.description  = <<-DESC
                   Don't you wish you could still run the simulator with the OpenTok iOS WebRTC SDK?

                   * Now you can!  The opentok lib will only be linked against for ARM architectures.
                   * Simply wrap your opentok code up in something like a service with a protocol. 
                   * Then write a second dummy implementation that conforms to the protocol and load
                   * that when running on the simulator.
                   DESC

  s.homepage     = "http://github.com/jekahy/OpenTokSDK-WebRTC"
 
  s.license      = 'MIT (example)'

  s.author       = { "Eugene" => "jekahy@gmail.com" }

  s.platform     = :ios, '6.1'

  s.source       = { :git => "https://github.com/jekahy/OpenTokSDK-WebRTC.git", :tag => "2.2" }

  s.source_files  = 'Opentok.framework/Versions/A/Headers/*.h'
  s.preserve_paths = 'Opentok.framework'

  s.xcconfig     = { 
    'FRAMEWORK_SEARCH_PATHS' => '"$(PODS_ROOT)/OpenTokSDK-WebRTC/"'

  }

  s.exclude_files = 'Opentok.framework/Versions/A/Resources/Info.plist'

  s.resources = ['Opentok.framework/Versions/A/Resources/opentok.bundle']
  s.frameworks = 'AudioToolbox', 'AVFoundation', 'CFNetwork', 'CoreAudio', 'CoreMedia', 'CoreTelephony', 'CoreVideo', 'MobileCoreServices', 'OpenGLES', 'QuartzCore', 'Security', 'SystemConfiguration', 'Opentok'

  s.libraries = 'z', 'xml2', 'sqlite3', 'stdc++'

end