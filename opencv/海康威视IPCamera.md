//
//海康：
//
// rtsp://[username]:[password]@[ip]:[port]/[codec]/[channel]/[subtype]/av_stream
//说明:
//username: 用户名。例如admin。
//password: 密码。例如12345。
//ip: 为设备IP。例如 192.0.0.64。
//port: 端口号默认为554，若为默认可不填写。
//codec：有h264、MPEG-4、mpeg4这几种。
//channel: 通道号，起始为1。例如通道1，则为ch1。
//subtype: 码流类型，主码流为main，辅码流为sub。
//
// 主码流RTSP地址
// rtsp://admin:123456@192.168.1.64:554/h264/ch1/main/av_stream
// rtsp://admin:123456@192.168.1.64:554/mpeg4/ch1/main/av_stream
// rtsp://admin:123456@192.168.1.64:554/MPEG-4/ch1/main/av_stream
//
// 海康新版本IPC的RTSP地址格式
// rtsp://[username]:[password]@[address]:[port]/Streaming/Channels/[id]?transportmode=[type]
//说明:
//rtsp://   => 协议格式头
//username  => 用户名，例如：admin
//password  => 密码，例如：123456
//address   => IPC设备的网络地址，例如：192.168.1.65
//port      => IPC设备的RTSP输出端口，默认为554，若为默认可不填写
//id        => 通道号&码流类型
//101：通道1主码流
//102：通道1子码流
//103：通道1第三码流
//1201：通道17主码流
//001：通道0主码流
//type      => 可选参数，拉流模式，默认为unicast，若为默认可以不填写
//unicast：单播模式拉流
//multicast：组播模式拉流
//
//通道1，主码流，单播拉流：
//rtsp://admin:12345@192.168.1.65/Streaming/Channels/101
//通道1，子码流，单播拉流：
//rtsp://admin:12345@192.168.1.65/Streaming/Channels/102
//通道1，第三码流，单播拉流：
//rtsp://admin:12345@192.168.1.65/Streaming/Channels/103
//