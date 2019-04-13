#**************************下面是备用的一些API*********************************

#添加版本插件
fastlane add_plugin versioning
# 以下两个action来自fastlane-plugin-versioning，
# 第一个递增 Build，第二个设定Version。
# 如果你有多个target，就必须指定target的值，否则它会直接找找到的第一个plist修改
increment_build_number_in_plist(target: 'targetName')
#增加build版本
increment_build_number(
    xcodeproj: 'personProject',
    build_number: "#{build}",
)
#构建版本号
increment_version_number_in_plist(
   target: 'target',
   version_number: '1.0'
)

#指定描述文件
export_options: {
    provisioningProfiles: {
        "com.test.conner" => "ios_dis",
    }
},

#添加firim 上传插件
fastlane add_plugin firim 
# 上传firim
firim(firim_api_token: "此处填写fir的用户token"),
#添加pgyer
fastlane add_plugin pgyer
# 上传蒲公英
pgyer(api_key: "11111122222233333444444", user_key: "111122233344455555", update_description: "#{option[:desc]}")
#提交到testFlight
pilot(
    #忽略等待包上传成功
	skip_waiting_for_build_processing: true,
)  


#常用参数：
scheme ：#指定打的哪个scheme
project ：#指定project (未使用cocopods)
workspace #：指定workspace (使用cocopods)
clean ：#打包前clean
xcargs ： #附加一些参数传递给xcodebuild 如： xcargs: 'DEBUG_INFORMATION_FORMAT="dwarf-with-dsym"',
export_method ：#出包方法 app-store, ad-hoc, package, enterprise, development
configuration ： #指定构建App的配置  Release、Debug、自定义
output_directory ： #输出目录
output_name ：#输出名称
include_symbols ：#是否包含调试符号
include_bitcode ：#是否开启bitcode


