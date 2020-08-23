# Matebook_D_Hackintosh_OpenCore

## 华为 Matebook D 2018 (I7 8550U) 

| 部件 | 配置                                                                                                            |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
| 显卡 | Intel UHD620 / nVidia MX150                                                                                        |
| 内存         | 8GB*2 DDR4 2400                                                                                                    |
| 键盘     | PS2 键盘，没背光🙃                                                                                   |
| 触摸板       | ELAN2202                                           |
| 声卡     | ALC256                                                                                                             |
| 屏幕         | 15.6‘ 1920x1080                                                                                                    |
| SSD            | Hikivision C2000 512GB + LITE-ON 128GB SATA m.2                                                                    |
| WiFi+BT        | Broadcom BCM94360CS2                                                                                         |
| 处理器      | Intel Core i5 8250U / i7 8550U </br>(如果你在使用I5-8250U版本，需要自行定制CPUFriendDataProvider) |
| BIOS  |    1.30 <br> Secure Boot(安全启动): `OFF`;  Hardware P-Status(硬件P状态）: `OFF`  |

---------

## 目前情况

### **你需要对OpenCore有基本的了解！**
### 本仓库目前只提供基本的config和ACPI样例
### 自行配置文件



### 什么工作
- [x] UHD620  
- [x] 背光控制
- [x] 背光快捷键
- [x] 睡眠Hibernation
- [x] 无线网卡&蓝牙 (替换 BCM94360CS2)
- [x] 电量显示
- [x] NVRAM
- [x] 二合一耳机孔 (2 in 1)
- [x] 扬声器&机身麦克风
- [x] HDMI 1.4
- [x] 触摸板
- [x] 摄像头


### 不工作的部件
-  Nvidia MX150

## 如何构建
- 你可以在macOS下使用 `Makefile.sh` 构建EFI. 然而，这个脚本并不稳定。

- 你也可以选择手动构建EFI   
    - 克隆本仓库
    - 从最新的Release下载所需要的文件。大部分文件的仓库地址已经在Credits下给出。
    - 使用 `Maciasl` 或 `iasl` 编译在 `/Shared/ACPI/` 的所有`.dsl`文件，得到 `.aml`文件.
    - 最终的文件结构如下：
   
 ```   
├── BOOT
│   ├── BOOTx64.efi
└── OC
    ├── ACPI
    │   ├── SSDT-BAT1-HUAWEI.aml
    │   ├── SSDT-BKey.aml
    │   ├── SSDT-EC.aml
    │   ├── SSDT-GPRW.aml
    │   ├── SSDT-LID-Wake-After-Sleep.aml
    │   ├── SSDT-PROP.aml
    │   ├── SSDT-PTSWAK.aml
    │   └── SSDT-TPXX.aml
    ├── Bootstrap
    │   └── Bootstrap.efi
    ├── Drivers
    │   ├── HFSPlus.efi
    │   └── OpenRuntime.efi
    ├── Kexts
    │   ├── ACPIBatteryManager.kext
    │   ├── AirportBrcmFixup.kext
    │   ├── AppleALC.kext
    │   ├── CPUFriend.kext
    │   ├── CPUFriendDataProvider.kext
    │   ├── HibernationFixup.kext
    │   ├── Lilu.kext
    │   ├── NullEthernet.kext
    │   ├── SMCProcessor.kext
    │   ├── USBPorts.kext
    │   ├── VirtualSMC.kext
    │   ├── VoodooI2C.kext
    │   ├── VoodooI2CHID.kext
    │   ├── VoodooPS2Controller.kext
    │   └── WhateverGreen.kext
    ├── OpenCore.efi
    ├── Tools
    │   ├── CleanNvram.efi  (Optional)
    │   └── VerifyMsrE2.efi (Optional)
    └── config.plist

```

## Credits

- [Acidanthera](https://github.com/acidanthera) for OpenCore (and related documents) , Lilu, AppleALC and other awesome projects.
   - [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup)
   - [AppleALC](https://github.com/acidanthera/AppleALC)
   - [CPUFriend](https://github.com/acidanthera/CPUFriend)
   - [HibernationFixup](https://github.com/acidanthera/HibernationFixup)
   - [Lilu](https://github.com/acidanthera/Lilu)
   - [OpenCore](https://github.com/acidanthera/OpenCorePkg)
   - [VoodooPS2](https://github.com/acidanthera/VoodooPS2)
   - [VirtualSMC](https://github.com/acidanthera/VirtualSMC)
   - [WhateverGreen](https://github.com/acidanthera/WhateverGreen)

- [Apple](https://www.apple.com) for macOS

- [Daliansky](https://github.com/daliansky) for ALCPlugFix.

- [hjmmc](https://github.com/hjmmc) 
    - [Honor-Magicbook](https://github.com/hjmmc/Honor-MagicbookThe) for [lid fix](https://github.com/Zero-zer0/Matebook_D_2018_Hackintosh_OpenCore/blob/master/Shared/ACPI/SSDT-LID-Wake-After-Sleep.dsl)
- [iStar](https://github.com/XStar-Dev) 
    - [Battery hotpatch](https://github.com/Zero-zer0/Matebook_D_2018_Hackintosh_OpenCore/blob/master/Shared/ACPI/SSDT-BAT1-HUAWEI.dsl).

- [OC-little](https://github.com/daliansky/OC-little) for their handy ACPI Hotpatches and guides for OpenCore.

- [RehabMan](https://github.com/RehabMan)
   - [OS-X-ACPI-Battery-Driver](https://github.com/RehabMan/OS-X-ACPI-Battery-Driver)
   - [OS-X-Null-Ethernet](https://github.com/RehabMan/OS-X-Null-Ethernet)

- [Steve Zheng](https://github.com/stevezhengshiqi) 
    - [one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend) and [XiaoMi-Pro-Hackintosh](https://github.com/daliansky/XiaoMi-Pro-Hackintosh)

- [VoodooI2C Developer Team](https://github.com/VoodooI2C) for their magnificent work on I2C trackpads.  
   - [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C)


## Guides
- [Justin](https://github.com/cattyhouse) for  [oc-guide](https://github.com/cattyhouse/oc-guide) 

- [xjn](https://github.com/xjn819) for [《使用OpenCore引导黑苹果》](https://blog.xjn819.com/?p=543)

- [Daliansky](https://github.com/daliansky), [bat.bat](https://github.com/williambj1) for [《精解OpenCore》](https://blog.daliansky.net/OpenCore-BootLoader.html)

- [Steve Zheng](https://github.com/stevezhengshiqi) for [XiaoMi-Pro-Hackintosh](https://github.com/daliansky/XiaoMi-Pro-Hackintosh)

- The Clover EFI I have used by [MOJUNSHOU](https://github.com/MOJUNSHOU) : [MateBooK-D](https://github.com/MOJUNSHOU/MateBooK-D)

- [hjmmc](https://github.com/hjmmc) :  [Honor-Magicbook](https://github.com/hjmmc/Honor-MagicbookThe)


