# 使用Windows自带的Diskpart工具

[参考1](https://blog.csdn.net/xiejx618/article/details/52382049, "Windows Diskpart命令详解")

## 指令

```bash
// 使用 cmd 界面打开
diskpart

// 显示磁盘列表
list disk

// 显示磁盘分区列表
list partition

// 显示卷列表
list volume

// 显示虚拟磁盘列表
list vdisk

// 选中磁盘
select disk n

// 选中磁盘分区
select partition n

// 选中指定卷
select volume n

// 选中虚拟磁盘
select vdisk file=x:\xxx.vhd

// 使用list命令可显示摘要。要显示更多信息，请先设置焦点，然后使用detail 命令替代list命令


```

## 管理基本磁盘指令

```bash
active // 将当前处于焦点的分区设置为“活动的”
        // 此设置通知固件此分区是有效系统分区。
assign [[letter=l]/[mount=path]]    // 为当前处于焦点的分区分配驱动器号或装入点
                                    // 如果未指定驱动器号，则分配下一个可用驱动器号。
create partition primary [size=n] [offset=n] [id=byte/guid] // 在当前驱动器上以一定长度大小和起始地址偏移量创建一个主分区。
                                                            // 如果在MBR磁盘上未指定ID字节，此命令将使用类型“0x6”创建分区。可以使用ID参数指定分区类型。
                                                            // 如果未在GPT磁盘上指定ID GUID，此命令将创建Msdata分区。可以使用ID参数指定任何 GUID。
create partition extended [size=n] [offset=n]   // 在当前驱动器上以一定长度大小和起始地址偏移量创建一个扩展分区。驱动器必须是 MBR 磁盘。
create partition logical [size=n] [offset=n]    // 在当前磁盘的现有扩展分区中以一定长度大小和起始地址偏移量创建一个逻辑驱动器。
                                                // 驱动器必须是 MBR 磁盘。
delete partition [override] // 删除当前处于焦点的分区。Diskpart 禁止删除当前系统、启动或分页卷。
                            // 要删除 ESP、MSR 或已知OEM分区，必须指定override参数。
extend [size=n]     // 当前处于焦点的卷扩展到未分配的连续空间。
                    // 未分配空间必须在处于焦点的分区之后（前者的扇区偏移量必须大于后者）。
remove [[letter=l]/[mount=path]/[all]]  // 删除当前处于焦点的分区的驱动器号或装入点
                                        // 如果指定all参数，则删除所有当前驱动器号和装入点。
                                        // 如果未指定驱动器号或装入点，则删除驱动器号。
```

## 管理动态磁盘指令

```bash
active // 将当前处于焦点的卷设置为“活动的”。此设置通知固件此分区是有效系统分区。
add disk=n // 向指定磁盘上的当前处于焦点的卷添加镜像。
assign [[letter=l]/[mount=path]] // 为当前处于焦点的卷分配驱动器号或装入点
                                // 如果未指定驱动器号，则分配下一个可用驱动器号。
break disk=n [nokeep] // 断开当前处于焦点的镜像。
create volume simple [size=n] [disk=n] // 在指定磁盘上以一定长度大小创建一个简单卷。
create volume stripe [size=n] disk=n[,n[,…]] // 在指定磁盘上创建带区集卷。如果未指定大小，则创建尽可能大的带区卷。
create volume raid [size=n] disk=n[,n[,…]]  // 在指定磁盘上创建 Raid-5 集卷
                                            // 每一个磁盘上均分配相当于“Raid-5 卷大小”的空间量。
                                            // 如果未指定大小，则创建尽可能大的 Raid 5 卷。
delete disk [override]  // 从磁盘列表中删除缺失的动态磁盘。
                        // 如果未指定 override 参数，将删除磁盘上包含的所有简单卷，并删除所有镜像丛。
delete partition [override] // 删除当前处于焦点的分区。禁止删除用于包含现有在线动态卷的任何分区。
                            // 要删除 ESP、MSR 或已知 OEM 分区，需指定 override 参数。
delete volume   // 删除当前处于焦点的卷。使用此命令后，将丢失所有数据。
extend disk=n [size=n]  // 将当前简单卷或扩展卷扩展到指定磁盘上。如果未指定大小，此卷可占用指定磁盘上的所有空闲空间。
import  // 导入外部磁盘组中的所有磁盘。
online  // 使以前离线的磁盘或卷重新在线。
remove [[letter=l]/[mount=path]/[all]]  // 删除当前处于焦点的卷的驱动器号或装入点
                                        // 如果使用 all 参数，将删除所有当前驱动器号和装入点。
retain  // 准备将动态简单卷用作启动或系统卷
```

## 转换指令

```bash
convert mbr // 将当前磁盘的分区形式设置为 MBR。可以是基本磁盘或动态磁盘。切勿包含任何有效数据分区或卷。
convert gpt // 将当前磁盘的分区形式设置为 GPT。可以是基本磁盘或动态磁盘。切勿包含任何有效数据分区或卷。
convert dynamic // 将基本磁盘改为动态磁盘。磁盘可以包含有效数据分区。
convert basic // 将空的动态磁盘转换为基本磁盘。
```

## 其他指令

```bash
exit // 停止 Diskpart 并将控制权返回给操作系统。
clean [all] // 通过将扇区清零，从当前处于焦点的磁盘删除分区或将卷格式化。
            // 默认情况下，仅改写 MBR 或 GPT 分区信息及任何有关 MBR 磁盘的隐藏扇区信息。
            // 如果指定 all 参数，可将每个扇区都清零，同时可删除驱动器上包含的所有数据。
rem […] // 不执行任何操作，但您可以使用此命令注释脚本文件。
rescan // 重新扫描所有 I/O 总线并可因此发现添加到计算机上的任何新磁盘。
format // 格式化卷或分区.
attach // 连接虚拟磁盘文件。
detach // 分离虚拟磁盘文件。

```
