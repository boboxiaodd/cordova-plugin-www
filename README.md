# 现成插件
包含略微修改的fork

#### 1、InAppBrowser （官方）`cordova-plugin-inappbrowser`

#### 2、网络请求 （第三方）`cordova-plugin-advanced-http`

#### 3、权限检测插件 （第三方）`cordova-plugins-diagnostic`
```xml
<preference name="cordova.plugins.diagnostic.modules" value="LOCATION CAMERA MICROPHONE" />
```

#### 4、网络状态插件 （官方）`cordova-plugin-network-information`

#### 5、录音/播放 插件 （官方）`cordova-plugin-media`

iOS  录制成 m4a , Android 录制成 acc 

声音播放，支持http

#### 6、设备信息 （官方改） `https://github.com/boboxiaodd/cordova-plugin-device`
增加 `app_version` `bundle_id` `build_version`

#### 7、WKWebView （第三方）`https://github.com/boboxiaodd/cordova-plugin-ionic-webview`
更改初始位置 到 `.../Libaray/NoCloud/www`

#### 8、Keyboard （第三方）`cordova-plugin-ionic-keyboard`
#### 9、对话框 (官方) `cordova-plugin-dialogs`
#### 10、状态栏 (官方) `cordova-plugin-statusbar`
#### 11、推送插件（第三方）`cordova-plugin-apns-push`


# 重写插件

#### 1、iOS本地目录管理： `https://github.com/boboxiaodd/cordova-plugin-www`
依赖 `cordova-plugin-zip`，`cordova-plugin-file`
允许非 `https` 访问
```xml
<config-file target="*-Info.plist" parent="NSAppTransportSecurity">
    <dict>
        <key>NSAllowsArbitraryLoads</key>
        <true/>
    </dict>
</config-file>
```

#### 2、相册/视频选择 （重写）`https://github.com/boboxiaodd/cordova-plugin-photo`
依赖：`HXPhotoPicker/SDWebImage`，已完成

#### 3、zego/美颜 插件 (重写) `https://github.com/boboxiaodd/cordova-plugin-zego`
依赖：`Masonry`,`Nama-lite`,`ZegoExpressEngine/Video`

FaceUnity 鉴权文件 `authpack.h` 需手动放入工程
```xml
<preference name="zego.sign" value="00000000000000000000000000000000000000000000000" />
<preference name="zego.appid" value="111111111" />
```

#### 4、聊天/输入框 插件 (重写) `https://github.com/boboxiaodd/cordova-plugin-inputbar`
依赖：`https://github.com/boboxiaodd/Mp3Recorder` 已完成

#### 5、支付插件 （重写）

#### 6、高德地图插件 (重写)

#### 7、高级选择器 (重写)
依赖：`BRPickerView`

#### 8、友盟插件 (重写)
包含一键登录
