Pod::Spec.new do |s|
  s.name             = 'SwiftGraph'
  s.version          = '0.1.0'
  s.summary          = 'Graph algorithms implemented in Swift.'
  s.description      = <<-DESC
SwiftGraph is a collection of graph algorithms, implemented according to the best known techniques.
                       DESC

  s.homepage         = 'https://github.com/svachmic/SwiftGraph'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'svachmic' => 'michal@svacha.cz' }
  s.source           = { :git => 'https://github.com/svachmic/SwiftGraph.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/miguelitinho'

  s.ios.deployment_target = '8.0'
  s.default_subspec = "Core"
  
  s.subspec "Core" do |ss|
    ss.source_files  = "Source/"
    ss.framework  = "Foundation"
  end
end
