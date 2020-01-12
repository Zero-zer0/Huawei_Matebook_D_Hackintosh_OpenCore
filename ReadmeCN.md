# Matebook_D_Hackintosh_OpenCore

## 华为 Matebook D 2018 (I7 8550U) (同样适用于 荣耀Magicbook 2018 Intel版，经反馈没有什么问题)

| 部件 | 配置                                                                                                            |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
| 显卡 | Intel UHD620 / nVidia MX150                                                                                        |
| 内存         | 8GB*2 DDR4 2400                                                                                                    |
| 键盘     | PS2 键盘，没背光🙃                                                                                   |
| 触摸板       | ELAN2202（需要_OSI补丁以启用APCI中断）                                                             |
| 声卡     | ALC256                                                                                                             |
| 屏幕         | 15.6‘ 1920x1080                                                                                                    |
| SSD            | Hikivision C2000 512GB + LITE-ON 128GB SATA m.2                                                                    |
| WiFi+BT        | Apple Broadcom BCM94360CS2                                                                                         |
| 处理器      | Intel Core I5 8250U / I7 8550U (如果你在使用I5-8250U版本，需要自行定制CPUFriendDataProvider) |

---------

## 目前情况

### **你需要对OpenCore有基本的了解！**

* 基于OpenCore 0.5.3 
<br>

* 原生(?) NVRAM 正常工作。
<br>
* 声卡 Layout-ID 21 一切正常。  

* ~~CFG被锁了，但是一切能用~~
    解锁CFG与改变DVMT大小的方法已经找到了，晚些更新。
<br>

* 网卡换为BCM94360CS2. 使用 [AirportBrcmFixup](https://github.com/acidanthera/AirportBrcmFixup) + `brcmfx-country=#a`开启所有频段。
<br>

* 使用 [one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend) 以获得更好的CPU变频。
<br>

* 独显 MX150 用 SSDT-DDGPU屏蔽。
<br>

* **使用 `USBInjectall.kext` 避免潜在的USB map不一样的问题，增强通用性质。建议自己定制 `USBports.kext` 用 [Hackintool](http://headsoft.com.au/download/mac/Hackintool.zip) 就可，教程很多。**
<br>


* 这个EFI也可以用在MagicBook 14（Kabylake-R）上。
<br>

* 用之前填写自己的System-UUID。
<br>

* 小问题: 
    1. ~~再唤醒后，屏幕背光需要再次开启盖子才能打开.~~    
    现在使用 `SSDT-LID-Wake-After-Sleep` 修复, 感谢 [hjmmc](https://github.com/hjmmc) : [Honor-Magicbook](https://github.com/hjmmc/Honor-Magicbook) <br>   
    我加入了 `_OSI`  判断满足OC的多启动需求，虽然不推荐用OC启动Windows/Linux。 
     <br>

    2. 安装过程中，触摸板不工作，需要自己准备一个USB鼠标
------

## TODOs

* ~~Chinese version of this document(简体中文文档会有的，不过现在用翻译器也能看，I'm just lazy)~~

* ~~Improvements on Hibernation.~~

* BIOS 解锁教程.

* ~~Windows 10 启动项~~<br>直接用BIOS的启动菜单吧  <br>



------

## 鸣谢 &  看过的教程 & 参考过的案例

1. [Acidanthera](https://github.com/acidanthera) for OpenCore (and related documents) , Lilu, AppleALC and other awesome projects.

2. [OC-little](https://github.com/daliansky/OC-little) for their handy ACPI Hotpatches for OpenCore.

3. [Justin](https://github.com/cattyhouse) for  [oc-guide](https://github.com/cattyhouse/oc-guide) 

4. [xjn](https://github.com/xjn819) for [《使用OpenCore引导黑苹果》](https://blog.xjn819.com/?p=543)

5. [Daliansky](https://github.com/daliansky), [bat.bat](https://github.com/williambj1) for [《精解OpenCore》](https://blog.daliansky.net/OpenCore-BootLoader.html)

6. [Steve Zheng](https://github.com/stevezhengshiqi) for [one-key-cpufriend](https://github.com/stevezhengshiqi/one-key-cpufriend) and [XiaoMi-Pro-Hackintosh](https://github.com/daliansky/XiaoMi-Pro-Hackintosh)

7. 我用过的Clover EFI [MOJUNSHOU](https://github.com/MOJUNSHOU) : [MateBooK-D](https://github.com/MOJUNSHOU/MateBooK-D)

8. The `LID and Brightness-Key fix` by [hjmmc](https://github.com/hjmmc) : [Honor-Magicbook](https://github.com/hjmmc/Honor-Magicbook)

-----
## 截图 & 我是怎样塞下BCM94360CS2的 

![  ](https://github.com/Zero-zer0/Matebook_D_Hackintosh_OpenCore/blob/master/截屏2019-12-22下午10.28.37.png)

![   ](https://github.com/Zero-zer0/Matebook_D_Hackintosh_OpenCore/blob/master/BCM94360CS2.jpg)



