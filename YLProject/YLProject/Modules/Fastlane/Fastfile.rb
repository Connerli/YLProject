# 定义fastlane版本号
fastlane_version "2.111.0" 

# 定义打包平台
default_platform :ios

# 任务脚本
platform :ios do

#开始前操作	
before_all do

end
	
desc "Jenkins版本打包"
lane :YLAPP do |options|
	#target
	target = options[:target]
	#scheme
	scheme = options[:scheme]
	#configuration 可以不指定
	# configuration = options[:configuration]
	#时间暂时没用到
	currentTime = Time.new.strftime("%Y%m%d%H%M")
	#修改版本号为打包buildNumber
    increment_build_number(
      build_number: options[:build_number]
    )
	#获取target 版本号
	version_number = get_version_number(target: "#{target}")
	#获取buildNumber
    build_number = get_build_number(xcodeproj: "#{target}.xcodeproj")
	#输出方式如果企业包打包方式改为企业打包
	export_method = "ad-hoc"
	if target == "Enterprise" then
		export_method = "enterprise"
	end
# 开始打包
gym(
	#输出的ipa名称
	output_name:"#{scheme}.ipa",
	# 隐藏没有必要的信息
	silent: true,  
	# 是否清空以前的编译信息 true：是
	clean:true,
	#scheme
	scheme: "#{scheme}", 
	# 指定打包方式，Release Debug Test 未指定就按照scheme 指定的configuration
	# configuration:"#{configuration}",
	# 指定打包所使用的输出方式，目前支持app-store, package, ad-hoc, enterprise, development
	export_method:"#{export_method}",
	# 更新描述	
	export_xcargs: "-allowProvisioningUpdates",
	#是否包含调试符号
	include_symbols: false,
    #是否开启bitcode
	include_bitcode: false,
	# 指定输出文件夹
	output_directory:"~/build/#{scheme}/#{version_number}/#{build_number}/",
) 

#上传到firim
firim(firim_api_token: "******************************")
end


#结束后的操作
after_all do |lane|
# This block is called, only if the executed lane was successful

# slack(
#   message: "Successfully deployed new App Update."
# )
end

error do |lane, exception|
# slack(
#   message: exception.message,
#   success: false
# )
end


end
