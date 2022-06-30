# Uncomment the next line to define a global platform for your project
platform :ios, '14.0'

target 'EatGreat' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  pod 'RxSwift', '6.2.0'
  pod 'RxCocoa', '6.2.0'

  pod 'SnapKit', '~> 5.0.0'
  pod 'Reusable'

  pod 'SVProgressHUD'
  pod 'IQKeyboardManager'

  # Pods for EatGreat

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
  end

end
