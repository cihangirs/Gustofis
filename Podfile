# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'GustOfis' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'AlamofireObjectMapper'
  pod 'JGProgressHUD'
#  pod 'QRCodeReader.swift'
  pod 'Fabric'
  pod 'Crashlytics'
  pod 'OneSignal'
  pod 'SDWebImage'
  pod 'Segmentio', '~> 3.0'
  pod 'UIAlertController+Blocks'
  pod 'PBRevealViewController/Swift'
  pod 'OHHTTPStubs'
  pod 'OHHTTPStubs/Swift' # includes the Default subspec, with support for NSURLSession & JSON, and the Swiftier API wrappers
  
  post_install do |installer|
      installer.pods_project.targets.each do |target|
          target.build_configurations.each do |config|
              config.build_settings['SWIFT_VERSION'] = '3.0'
          end
      end
      installer.pods_project.build_configurations.each do |config|
          config.build_settings.delete('CODE_SIGNING_ALLOWED')
          config.build_settings.delete('CODE_SIGNING_REQUIRED')
      end
  end

  target 'GustOfisTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'GustOfisUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end
