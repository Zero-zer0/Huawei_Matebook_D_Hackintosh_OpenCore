# Matebook_D_Hackintosh_OpenCore

Language:   
English | [简体中文](https://github.com/Zero-zer0/Huawei_Matebook_D_Hackintosh_OpenCore/blob/master/ReadmeCN.md)
## Huawei Matebook D 2018 (I7 8550U)


| Specifications | Details                                                                                                            |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
| Graphics Cards | Intel UHD620 / nVidia MX150                                                                                        |
| Memory         | 8GB*2 DDR4 2400                                                                                                    |
| Keyboard       | PS2 Keyboard without backlight🙃                                                                                   |
| Trackpad       | ELAN2202                                                              |
| Sound Card     | ALC256                                                                                                             |
| Screen         | 15.6‘ 1920x1080                                                                                                    |
| SSD            | Hikivision C2000 512GB + LITE-ON 128GB SATA m.2                                                                    |
| WiFi+BT        | Broadcom BCM94360CS2                                                                                         |
| Processor      | Intel Core i5 8250U / i7 8550U  |
| BIOS |   1.30 <br>Secure Boot: `OFF`;  Hardware P-Status: `OFF`    |
---------

## Current Status

### **Basic knowledge on OpenCore is needed!**
### **This repo ONLY provides basic configs and ACPI samples**
### **Make the files in place on your own**

### What's working
- [x] UHD620  
- [x] Backlight control
- [x] Backlight shortcut
- [x] Hibernation
- [x] Wireless & Bluetooth (replaced stock Intel wireless card by BCM94360CS2)
- [x] Battery
- [x] NVRAM
- [x] Headphone jack (2 in 1)
- [x] Speaker & Internal Mic
- [x] HDMI 1.4
- [x] Trackpad
- [x] Camera


### What's not working
-  Nvidia MX150


## How to build 
- You can build the EFI by `Makefile.sh` in macOS. However, the script is unstable.  

- You can build the EFI manually.   
    - Clone this repo.  
    - Download required files from latest releases. You can see them in Credits.
    - Use `Maciasl` or `iasl` to compile all files under `/Shared/ACPI/` from `.dsl` to `.aml`.
    - The final file tree is shown below:
   
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


## Adapter for BCM94360CS2


You can find such adpter on Taobao or AliExpress, here is one of them: [link](https://es.aliexpress.com/item/4000291280536.html?spm=a2g0o.productlist.0.0.5db01c7b2QBTqJ&algo_pvid=58e27c50-cfd3-4b1d-a47b-0844639975b7&algo_expid=58e27c50-cfd3-4b1d-a47b-0844639975b7-20&btsid=0b86d81615848848784222166ea9b6&ws_ab_test=searchweb0_0,searchweb201602_,searchweb201603_)


