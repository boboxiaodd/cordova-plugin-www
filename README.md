# 现成插件
包含略微修改的fork

#### 1、InAppBrowser （官方改）`https://github.com/boboxiaodd/cordova-plugin-inappbrowser`

#### 2、网络请求 （第三方）`cordova-plugin-advanced-http`

#### 3、权限检测插件 （第三方）`cordova.plugins.diagnostic`
```xml
<preference name="cordova.plugins.diagnostic.modules" value="LOCATION CAMERA MICROPHONE" />
```

#### 4、网络状态插件 （官方）`cordova-plugin-network-information`

#### 5、录音/播放 插件 （官方改）`https://github.com/boboxiaodd/cordova-plugin-media`
声音播放，支持http、支持本地文件

#### 6、设备信息 （官方改） `https://github.com/boboxiaodd/cordova-plugin-device`
增加 `app_version` `bundle_id` `build_version`

#### 7、WKWebView （第三方）`https://github.com/boboxiaodd/cordova-plugin-ionic-webview`
更改初始位置 到 `.../Libaray/NoCloud/www`

#### 8、Keyboard （第三方）`cordova-plugin-ionic-keyboard`
#### 9、对话框 (官方) `cordova-plugin-dialogs`
#### 10、状态栏 (官方) `cordova-plugin-statusbar`
#### 11、推送插件（第三方）`cordova-plugin-apns-push`
#### 12、视频播放器 (第三方改) `https://github.com/boboxiaodd/cordova-plugin-streaming-media`
#### 13、IDFA/AAID (第三方）`cordova-plugin-idfa`
#### 14、SQLite插件（第三方）`cordova-sqlite-storage`
#### 15、剪切板插件（第三方）`cordova-clipboard-api`
#### 16、活体检测（第三方改）`https://github.com/boboxiaodd/alive-cordova-plugin`
# 重写插件

#### 1、iOS本地目录管理： `https://github.com/boboxiaodd/cordova-plugin-www`
修改 `[CordovaRoot]/platform/ios/[ProjectRoot]/Scripts/copy-www-build-step.sh` 
```bash
SRC_DIR="www"
DST_DIR="$BUILT_PRODUCTS_DIR/$FULL_PRODUCT_NAME"

cd $SRCROOT
zip -r www.zip www
cp -f www.zip "${SRCROOT}/${PROJECT_NAME}/Resources/"

# Copy the config.xml file.
cp -f "${PROJECT_FILE_PATH%.xcodeproj}/config.xml" "$DST_DIR"

IFS=$ORIG_IFS
```

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

#### 2、相册/视频选择 （已重写）`https://github.com/boboxiaodd/cordova-plugin-photo`
依赖：`HXPhotoPicker/SDWebImage`，已完成

#### 3、zego/美颜 插件 (已重写) `https://github.com/boboxiaodd/cordova-plugin-zego`
依赖：`Masonry`,`Nama-lite`,`ZegoExpressEngine/Video`

FaceUnity 鉴权文件 `authpack.h` 需手动放入工程，需在`config.xml`增加配置
```xml
<preference name="zego.sign" value="[ZEGO SercetKey]" />
<preference name="zego.appid" value="[ZEGO APPID]" />
```

#### 4、聊天/输入框 插件 (已重写) `https://github.com/boboxiaodd/cordova-plugin-inputbar`
依赖：`https://github.com/boboxiaodd/Mp3Recorder` 已完成

#### 5、支付宝支付插件 （已重写）
需要指定URL_SCHEME，用于支付完成后跳回APP
```sh
cordova plugin add https://github.com/boboxiaodd/cordova-plugin-zapp --variable URL_SCHEME=xxxxxxx
```

#### 6、高德地图插件 (已重写) `https://github.com/boboxiaodd/cordova-plugin-amap`
需在`config.xml`增加配置
```xml
    <preference name="amap.key" value="高德API_KEY" />
```

#### 7、高级选择器 (已重写) `https://github.com/boboxiaodd/cordova-plugin-picker`
依赖：`BRPickerView`

#### 8、友盟插件 (已重写) `https://github.com/boboxiaodd/cordova-plugin-umeng`
包含一键登录，需在`config.xml`增加配置
```xml
    <preference name="umeng.key" value="友盟统计/监控 KEY" />
    <preference name="umeng.verify" value="一键登录KEY" />
```
#### 9、视频播放器（已重写）`https://github.com/boboxiaodd/cordova-plugin-videoplayer`

#### 10、actionsheet（已重写）`https://github.com/boboxiaodd/cordova-plugin-alertview`
依赖 `LEEAlert`
