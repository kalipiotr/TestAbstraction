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

  target 'TestAbstractionUITests' do
    # pod 'Cucumberish', git: 'https://github.com/Ahmed-Ali/Cucumberish.git'
  end

end
