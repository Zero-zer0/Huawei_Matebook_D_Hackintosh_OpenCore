# Matebook_D_Hackintosh_OpenCore

Language:   
English | [简体中文](https://github.com/Zero-zer0/Huawei_Matebook_D_Hackintosh_OpenCore/blob/master/ReadmeCN.md)
## Huawei Matebook D 2018 (I7 8550U)

| Specifications | Details                                                                                                            |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
| Graphics Cards | Intel UHD620 / nVidia MX150                                                                                        |
| Memory         | 8GB*2 DDR4 2400                                                                                                    |
| Keyboard       | PS2 Keyboard without backlight🙃                                                                                   |
| Trackpad       | ELAN2202(Requires _OSI Patch to enable GPIO interrupt on macOS)                                                             |
| Sound Card     | ALC256                                                                                                             |
| Screen         | 15.6‘ 1920x1080                                                                                                    |
| SSD            | Hikivision C2000 512GB + LITE-ON 128GB SATA m.2                                                                    |
| WiFi+BT        | Apple Broadcom BCM94360CS2                                                                                         |
| Processor      | Intel Core I5 8250U / I7 8550U (a new CpuFridendDataProvider is needed if you have an I5-8250U version) |

---------

## Current Status

### **Basic knowledge on OpenCore is needed!**

* Based on OpenCore Official Release 0.5.3

* Native(?) NVRAM works.

* Soundcard with injected Layout-ID 21 works well.

* ~~CFG Lock cannot be unlocked in Huawei's fxxking BIOS. However everything just works. I'm not able to modify the confusing InsydeH2O BIOS now.~~
    The way to modify BIOS is found, I'll update later to explain how to unlock CFG and change DVMT.

* Replaced stock Intel Wireless 8265AC with BCM94360CS2 and an adapter. Using [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) with `brcmfx-country=#a`to enable all WiFi channels.

* Use [one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend) to gain a better CPU power management.

* DGPU nVidia MX150 is disabled by SSDT-DDGPU.

* **Use `USBInjectall.kext` to avoid potential USB map differences. However, customizing your own `USBports.kext` by [Hackintool](http://headsoft.com.au/download/mac/Hackintool.zip) is STRONGLY RECOMMENDED. You can read the help document inside for more details.**


* This EFI may also works on Magicbook 14 Kabylake-R. However, Layout-ID may need to set as `56` or `57` ( May need more modifications)

* You may need to use your own System-UUID when you need dual boot with Windows 10.  

* Minor bugs: 
    1. ~~Screen backlight requires a second-open to turn on after closing lid.~~    
    Now fixed by `SSDT-LID-Wake-After-Sleep` ,thanks to [hjmmc](https://github.com/hjmmc) : [Honor-Magicbook](https://github.com/hjmmc/Honor-Magicbook) <br>   
    I added a `_OSI`  determination to meet the needs of dual boot with Windows/Linux by OpenCore though it's not recommended.  

    2. Trackpad doesn't work and a USB mouse is needed when installing.

------

## TODOs

* Chinese version of this document(简体中文文档会有的，不过现在用翻译器也能看，I'm just lazy)

* Improvements on Hibernation.

* BIOS unlock tutorial.

* ~~Windows 10 startup item in OpenCore (I think using boot menu is a better choice)~~  <br>

    Do NOT use OpenCore to boot windows. Using Boot Menu is recommended.

------

## Credits &  Guides

1. [Acidanthera](https://github.com/acidanthera) for OpenCore (and related documents) , Lilu, AppleALC and other awesome projects.

2. [OC-little](https://github.com/daliansky/OC-little) for their handy ACPI Hotpatches for OpenCore.

3. [Justin](https://github.com/cattyhouse) for  [oc-guide](https://github.com/cattyhouse/oc-guide) 

4. [xjn](https://github.com/xjn819) for [《使用OpenCore引导黑苹果》](https://blog.xjn819.com/?p=543)

5. [Daliansky](https://github.com/daliansky), [bat.bat](https://github.com/williambj1) for [《精解OpenCore》](https://blog.daliansky.net/OpenCore-BootLoader.html)

6. [Steve Zheng](https://github.com/stevezhengshiqi) for [one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend) and [XiaoMi-Pro-Hackintosh](https://github.com/daliansky/XiaoMi-Pro-Hackintosh)

7. The Clover EFI I have used by [MOJUNSHOU](https://github.com/MOJUNSHOU) : [MateBooK-D](https://github.com/MOJUNSHOU/MateBooK-D)

8. The LID and Brightness-Key fix by [hjmmc](https://github.com/hjmmc) : [Honor-Magicbook](https://github.com/hjmmc/Honor-Magicbook)

-----
## Screenshot & How I put BCM94360CS2 into the laptop

![  ](https://github.com/Zero-zer0/Matebook_D_Hackintosh_OpenCore/blob/master/截屏2019-12-22下午10.28.37.png)

![   ](https://github.com/Zero-zer0/Matebook_D_Hackintosh_OpenCore/blob/master/BCM94360CS2.jpg)



