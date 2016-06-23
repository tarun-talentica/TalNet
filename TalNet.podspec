Pod::Spec.new do |s|
  s.name         = "TalNet"
  s.version      = "1.0.0"
  s.summary      = 'Abstract Networking wrapper over any 3rd party networking vendor.'
  s.platform = :ios
  s.ios.deployment_target = '8.0'
  s.homepage     = "https://github.com/tarun-talentica/TalNet"
  s.license      = { :type => "MIT" }
  s.author             = { "Tarun Sharma" => "tsharma.oct83@gmail.com" }
  s.source       = { :git => "https://github.com/tarun-talentica/TalNet.git"}
  s.source_files  = "Source/*.swift", "Source/Request/*swift", "Source/Response/*swift", "Source/Vendors/*swift"
  s.dependency "Alamofire", "~> 3.0"
  s.dependency "AlamofireObjectMapper", "~> 3.0"
  s.framework  = "Foundation"
end