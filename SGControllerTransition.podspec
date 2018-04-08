Pod::Spec.new do |s|
  s.name         = 'SGControllerTransition'
  s.summary      = 'It is no longer difficult to animate the controller.'
  s.version      = '1.0.0'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }
  s.authors      = { 'sylphghost' => 'sylphghost@outlook.com' }
  s.homepage     = 'https://github.com/sylphghost/SGControllerTransition'
  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'
  s.source       = { :git => 'https://github.com/sylphghost/SGControllerTransition.git', :tag => s.version.to_s }
  
  s.requires_arc = true
  s.source_files = 'SGControllerTransition/**/*.{h,m}'
end
