# Matebook_D_Hackintosh_OpenCore

## 华为 Matebook D 2018 (I7 8550U) (同样适用于 荣耀Magicbook 2018 Intel版，经反馈没有太大问题)

| 部件 | 配置                                                                                                            |
|:--------------:|:------------------------------------------------------------------------------------------------------------------:|
| 显卡 | Intel UHD620 / nVidia MX150                                                                                        |
| 内存         | 8GB*2 DDR4 2400                                                                                                    |
| 键盘     | PS2 键盘，没背光🙃                                                                                   |
| 触摸板       | ELAN2202（需要_OSI补丁以启用GPIO中断）                                                             |
| 声卡     | ALC256                                                                                                             |
| 屏幕         | 15.6‘ 1920x1080                                                                                                    |
| SSD            | Hikivision C2000 512GB + LITE-ON 128GB SATA m.2                                                                    |
| WiFi+BT        | Broadcom BCM94360CS2                                                                                         |
| 处理器      | Intel Core i5 8250U / i7 8550U (如果你在使用I5-8250U版本，需要自行定制CPUFriendDataProvider) |
| BIOS  |    1.30 <br> Secure Boot(安全启动): `OFF`;  Hardware P-Status(HWP，硬件P状态）: `ON`  |

---------

## 目前情况

### **你需要对OpenCore有基本的了解！**

* 基于OpenCore 0.5.3 
<br>

* NVRAM 正常工作。
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

* 这个EFI也可以用在MagicBook 14（Kabylake-R）上。 **如果使用`Magicbook 2018`，声卡Layout-ID 需要改为 `56` 或 `57`** (声卡ID使用Device Properties注入)
<br>

* 用之前填写自己的System-UUID。
<br>

* 如果换了NVMe SSD，可以尝试使用NVMeFix.kext以获得更好的续航。

* 小问题: 
    1. ~~再唤醒后，屏幕背光需要再次开启盖子才能打开.~~    
    现在使用 `SSDT-LID-Wake-After-Sleep` 修复, 感谢 [hjmmc](https://github.com/hjmmc) : [Honor-Magicbook](https://github.com/hjmmc/Honor-Magicbook) <br> 
    我加入了 `_OSI`  判断满足OC的多启动需求，虽然不推荐用OC启动Windows/Linux。 
     <br>

    2. 安装过程中，触摸板不工作，需要自己准备一个USB鼠标
------
## `ACPI Error`相关
该hackintosh EFI可能存在一些与“动态OEM表”有关的ACPI问题。    

`动态OEM表`是由固件根据您计算机的当前电源状态动态生成的一组SSDT。这些表通过“ _PPC”将当前电源状态传输到系统，这个玩意会被`EC0`的`_QA6`调用，它们与CPU电源管理有关。  

奇怪的是，这些表无法由OpenCore自动加载。更糟糕的是，macOS可能因卡在与`_QA6`和`_PPC`有关的`APCI Error`而无法启动。

我们可以通过强制加载这些动态SSDT来解决这个问题。  
1. 使用`Clover`启动Matebook D或Magicbook 2018，
2. 按`F4` 提取整个ACPI表。
3. 查找所有动态SSDT，其序列号前面有一个x。 <br>例如，`SSDT-x3_0-Cpu0Ist.aml`，`SSDT-x3_1-ApIst.aml` ...
4. 将所有这些`动态SSDT`放入EFI / OC / ACPI
5. 将这些`SSDT`添加到`config.plist--ACPI--Add`下，根据其他SSDT填写的格式写就好。
6. 重新启动并检查，看看相关的ACPI Error是否消失了呢 XD.
--------

## TODOs

* ~~Chinese version of this document(简体中文文档会有的，不过现在用翻译器也能看，I'm just lazy)~~

* ~~Improvements on Hibernation.~~（这机器的电池太TM垃圾了，3400mAh，11.4V用个卵哦）

* BIOS 解锁教程.（咕咕咕）

* ~~Windows 10 启动项~~<br>直接用BIOS的启动菜单吧  <br>

* ~~解决一些奇怪的ACPI Error（不影响使用）~~


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



