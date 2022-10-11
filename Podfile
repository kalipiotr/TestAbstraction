platform :ios, '14.0'
use_frameworks!

inhibit_all_warnings!

# workaround for CocoaPods and the new Xcode build system:
# https://www.ralfebert.de/ios/blog/cocoapods-clean-input-output-files/
# https://github.com/CocoaPods/CocoaPods/issues/8151
install! 'cocoapods', :disable_input_output_paths => true

def network
  pod 'APIKit'
end

def utils
  pod 'Swinject'
end

def core
  network
  utils
end

target 'TestAbstraction' do
  core

  target 'TestAbstractionTests' do
    inherit! :search_paths
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target_name = target.name

    # Set build configuration
    target.build_configurations.each do |config|
      config.build_settings.delete 'IPHONEOS_DEPLOYMENT_TARGET'
    end
  end
end
