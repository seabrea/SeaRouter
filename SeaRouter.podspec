Pod::Spec.new do |s|

s.name         = "SeaRouter"
s.version      = "0.0.1"
s.summary      = "A easy function for iOS URL Router."
s.description  = "一个灵活简单的 iOS URL Router, 主要用于iOS中页面跳转，用于对高耦合的控制器之间的解耦。"
s.homepage     = "https://github.com/seabrea/SeaRouter"
s.license      = { :type => "MIT", :file => "LICENSE" }
s.author       = { "seabrea" => "hgdigm@gmail.com" }
s.platform     = :ios, "9.0"
s.ios.deployment_target = "9.0"
s.source       = { :git => "https://github.com/seabrea/SeaRouter.git", :tag => "#{s.version}" }
s.source_files  = "SeaRouterDemo/SeaRouterDemo/SeaRouter/**/*.{h,m}"
s.requires_arc = true

end
