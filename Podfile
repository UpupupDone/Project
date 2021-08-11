# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

source 'https://github.com/UpupupDone/PrivateSpec.git'
source 'https://github.com/CocoaPods/Specs.git'

target 'Project' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Project
  
  pod 'Realm'
  pod 'KVOController'
  pod 'YYKit'
  pod 'QCCrashSafety', '0.0.4'
  pod 'QCDataBase', '0.0.1'
  pod 'QCEventCalendar', '0.0.1'
  pod 'QCThreadSafeContainer', '0.0.1'
  pod 'QCSwizzling', '0.0.1'
  pod 'CCButton', '0.0.4'
  # pod 'CocoaHTTPServer'
  pod 'GCDWebServer'
  pod 'CodeCoverage'
  
  target 'ProjectTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'ProjectUITests' do
    # Pods for testing
  end
  
end

# 需要收集Code Coverage的模块
#ntargets = Array['M0', '', 'M1', 'M2', 'M3']

require 'xcodeproj'
post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      #      if(config.name <=> 'AdHoc') == 0
      # 设置预编译变量CODECOVERAGE
      config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) CODECOVERAGE=1'
      config.build_settings['GCC_GENERATE_TEST_COVERAGE_FILES'] = 'NO'
      config.build_settings['GCC_INSTRUMENT_PROGRAM_FLOW_ARCS'] = 'NO'
      #        ntargets.each do |ntarget|
      #          if(ntarget <=> target.name) == 0
      #            config.build_settings['GCC_GENERATE_TEST_COVERAGE_FILES'] = 'YES'
      #            config.build_settings['GCC_INSTRUMENT_PROGRAM_FLOW_ARCS'] = 'YES'
      #            break
      #          end
      #        end
      #      else
      #        config.build_settings['GCC_GENERATE_TEST_COVERAGE_FILES'] = 'NO'
      #        config.build_settings['GCC_INSTRUMENT_PROGRAM_FLOW_ARCS'] = 'NO'
      #      end
    end
  end
  
  # 修改主工程
  project_path = './Project.xcodeproj'
  project = Xcodeproj::Project.open(project_path)
  puts project
  project.targets.each do |target|
    if(target.name <=> 'Project') == 0
      target.build_configurations.each do |config|
        #        if(config.name <=> 'AdHoc') == 0
        # 设置预编译变量CODECOVERAGE
        config.build_settings['GCC_PREPROCESSOR_DEFINITIONS'] = '$(inherited) CODECOVERAGE=1'
        config.build_settings['GCC_GENERATE_TEST_COVERAGE_FILES'] = 'YES'
        config.build_settings['GCC_INSTRUMENT_PROGRAM_FLOW_ARCS'] = 'YES'
        #        else
        #          config.build_settings['GCC_GENERATE_TEST_COVERAGE_FILES'] = 'NO'
        #          config.build_settings['GCC_INSTRUMENT_PROGRAM_FLOW_ARCS'] = 'NO'
        #        end
      end
    end
  end
  project.save()
end
