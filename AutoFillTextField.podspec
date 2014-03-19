Pod::Spec.new do |s|
  s.name         = "AutoFillTextField"
  s.version      = "0.0.1"
  s.summary      = "use for auto fill like combo box in web pages"
  s.homepage     = "http://github.com/arunpkumar92/AFview"
  s.license      = :type => 'BSD'
  s.author       = { "arunpkumar92" => "arunpkumar92@gmail.com" }
  s.platform     = :ios, '6.0'
  s.ios.deployment_target = '6.0'
  s.source       = { :git => "https://github.com/arunpkumar92/AFview.git", :tag => "1.0.0" }
  s.source_files     = 'AFView.h,m'
  s.resources  = "Ex_Text_Field_Bg.png,Ex_Text_Field_Bg@2x.png"
  s.framework  = 'QuartzCore'
  s.requires_arc = true
end
