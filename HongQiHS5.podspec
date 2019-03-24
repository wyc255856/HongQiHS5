#
#  Be sure to run `pod spec lint HongQiHS5.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  # ―――  Spec Metadata  ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  These will help people to find your library, and whilst it
  #  can feel like a chore to fill in it's definitely to your advantage. The
  #  summary should be tweet-length, and the description more in depth.
  #

  s.name         = "HongQiHS5"
  s.version      = "1.0.2"
  s.summary      = "A short description of HongQiHS5SDK."

  s.description  = <<-DESC
		   HongQi HS5 Easy Fast!
                   DESC

  s.homepage     = "http://EXAMPLE/HongQiHS5"

  s.license      = "Copyright (c) 2019年 HongQiHS5SDK. All rights reserved."

  s.author             = { "张三" => "zhangsan0103@gmail.com" }

  s.platform     = :ios, "8.0"

  s.ios.deployment_target = "8.0"

   s.source       = { :git => "https://github.com/wyc255856/HongQiHS5.git", :tag => "#{s.version}" }



   s.source_files  = "HongQiHS5", "HongQiHS5SDKiOS/HongQiHS5SDK/*.{h,m,c}"
  s.exclude_files = "Classes/Exclude"
  s.resource = "HongQiHS5SDKiOS/HongQiHS5SDK/HS5CarResource.bundle"

end
