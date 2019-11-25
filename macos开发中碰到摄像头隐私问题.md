# 问题描述

Mac macOS 10.14.6 Mojave Xcode opencv 调用摄像头权限错误
This app has crashed because it attempted to access privacy-sensitive data without a usage description.

1. 新建一个Info.plist文件
2. 加入摄像头权限字段
3. 将文件复制到debug目录下一起编译
4. 解决

```bash
## 在我的机子下目录
##/Users/xxx/Library/Developer/Xcode/DerivedData/FaceDetecter-bslkklrbnhctjzbqfldycrxwgcoc/Build/Products/Debug
```

******************************

## 权限字段

```json
key 为字段名
value 为string 可以自定义提示内容

Calendar
Key    :  Privacy - Calendars Usage Description
Value  :  $(PRODUCT_NAME) calendar events

Reminder :
Key    :   Privacy - Reminders Usage Description
Value  :   $(PRODUCT_NAME) reminder use

Contact :
Key    :   Privacy - Contacts Usage Description
Value  :  $(PRODUCT_NAME) contact use

Photo :
Key    :  Privacy - Photo Library Usage Description
Value  :  $(PRODUCT_NAME) photo use

Bluetooth Sharing :
Key    :  Privacy - Bluetooth Peripheral Usage Description
Value  :  $(PRODUCT_NAME) Bluetooth Peripheral use

Microphone :
Key    :  Privacy - Microphone Usage Description
Value  :  $(PRODUCT_NAME) microphone use

Camera :
Key    :  Privacy - Camera Usage Description
Value  :  $(PRODUCT_NAME) camera use

Location :
Key    :  Privacy - Location Always Usage Description
Value  :  $(PRODUCT_NAME) location use
Key    :  Privacy - Location When In Use Usage Description
Value  :  $(PRODUCT_NAME) location use

Heath :
Key    :  Privacy - Health Share Usage Description
Value  :  $(PRODUCT_NAME) heath share use
Key    :  Privacy - Health Update Usage Description
Value  :  $(PRODUCT_NAME) heath update use

HomeKit :
Key    :  Privacy - HomeKit Usage Description
Value  :  $(PRODUCT_NAME) home kit use

Media Library :
Key    :  Privacy - Media Library Usage Description
Value  :  $(PRODUCT_NAME) media library use

Motion :
Key    :  Privacy - Motion Usage Description
Value  :  $(PRODUCT_NAME) motion use

Speech Recognition :
Key    :  Privacy - Speech Recognition Usage Description
Value  :  $(PRODUCT_NAME) speech use

SiriKit :
Key    :  Privacy - Siri Usage Description  
Value  :  $(PRODUCT_NAME) siri use

TV Provider :
Key    :  Privacy - TV Provider Usage Description
Value  :  $(PRODUCT_NAME) tvProvider use
```

### 参考

[1 stackoverflow](https://stackoverflow.com/questions/39465687/nscamerausagedescription-in-ios-10-0-runtime-crash)
[2 stackoverflow](https://stackoverflow.com/questions/39631256/request-permission-for-camera-and-library-in-ios-10-info-plist/47970037#47970037)
