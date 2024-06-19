
# OpenWRT PPPwn
[English version](https://github.com/naixue233/WKY_PPPwnWRT_OneCloud/blob/main/README_EN.md)
OpenWrt安装PPPwn C++版本version by xfangfang https://github.com/xfangfang/PPPwn_cpp

当前包含PPPwn C++版本：v1.0.0

当前收录GoldHEN版本：v2.4b17.3
### 安装
1. 将goldhen.bin从goldhen 2.4b17.3和最新的release放在exfat或fat32格式的usb驱动器的根目录上
https://github.com/GoldHEN/GoldHEN/releases
2. 把USB驱动器插入PS4
3. SSH进入到OpenWRT路由器
4. 运行以下命令:

Raspberry Pi 构建:
```
wget -q -O - https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/scripts/RPi.sh | sh
```
MIPS 构建
```
wget -q -O - https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/scripts/MIPS.sh | sh
```
Cortex A7 构建
```
wget -q -O - https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/scripts/CortexA7.sh | sh
```
ARM_64 构建
```
wget -q -O - https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/scripts/ARM_64.sh | sh
```
x86_64 构建
```
wget -q -O - https://github.com/naixue233/PPPwnWRT_naixue233/blob/main/scripts/x86_64.sh | sh
```

需要说明的是：养成使用
`wget $(random_script_from_the_internets) | sh"` 的习惯其实并不是一个好主意。在运行之前，请务必阅读所运行内容的源代码。

现在显示您的接口，以便您使用您选择的以太网接口替换步骤 5 中的“INTERFACE”。

5. 编辑 `/etc/pppwnwrt/pppwnwrt.sh` 脚本

For 9.00
```
pppwn -i INTERFACE --fw 900 -s1 "/etc/pppwnwrt/stage1_900.bin" -s2 "/etc/pppwnwrt/stage2_900.bin" -a
```

For 9.60
```
pppwn -i INTERFACE --fw 960 -s1 "/etc/pppwnwrt/stage1_960.bin" -s2 "/etc/pppwnwrt/stage2_960.bin" -a
```

For 10.00/10.01
```
pppwn -i INTERFACE --fw 1000 -s1 "/etc/pppwnwrt/stage1_1000.bin" -s2 "/etc/pppwnwrt/stage2_1000.bin" -a

pppwn -i INTERFACE --fw 1001 -s1 "/etc/pppwnwrt/stage1_1000.bin" -s2 "/etc/pppwnwrt/stage2_1000.bin" -a
```

For 11.00
```
pppwn -i INTERFACE --fw 1100 -s1 "/etc/pppwnwrt/stage1_1100.bin" -s2 "/etc/pppwnwrt/stage2_1100.bin" -a
```
（如果空间不足，您可以删除不需要的stage1.bin 文件）

注意：包含的 stage2.bin 是 GoldHEN。您可以将其更改为您想要的任何 stage2.bin 有效负载

 6. 在OpenWRT中启用自启动
- `/etc/init.d/pppwnwrt enable`
- `/etc/init.d/pppwnwrt start`
- `top -d 1 | grep pppwn` to ensure pppwn is running

7. 在您的 PS4 上：

- 转到“设置”，然后选择“网络”
- 选择“设置 Internet 连接”并选择“使用 LAN 电缆”
- 选择“自定义”设置，并为“IP 地址设置”选择“PPPoE”
- 在“PPPoE 用户 ID”和“PPPoE 密码”中输入任何内容
- 在“DNS 设置”和“MTU 设置”中选择“自动”
- 在“代理服务器”中选择“不使用”
- 选择“测试 Internet 连接”
- 等到出现“PPPwned”消息
- 返回“设置 Internet 连接”并更改为您的正常 Internet 设置或关闭 Internet 连接

从现在开始，只要连接到路由器，每次开机时你的 PS4 都会被越狱。不幸的是，该脚本没有输出，所以确定它是否注入了有效载荷的唯一方法是查看“无法设置互联网连接”消息、“新功能”应用程序底部的“加载符号”或断断续续的音频。请记住，该脚本将无休止运行，因此即使你的控制台已经 root 权限，它也会尝试 root 权限。为防止这种情况，脚本会在成功越狱后等待 60 秒，因此你有时间关闭互联网连接或从 PPPoE 更改为通常的互联网设置。你不需要再次设置互联网连接，只需在改回 PPPoE 后按“测试互联网连接”即可，或者如果已经设置，请等到出现“PPPwned”消息。 stage2 的自定义版本首先在 USB 驱动器的根目录中查找有效负载，如果找到，则将其复制到此路径的内部 HDD：/data/GoldHEN/payloads/goldhen.bin。然后加载内部有效负载，外部 USB 驱动器上不再需要它。第一次运行后，您可以从 ps4 中移除 USB 驱动器，并且不再需要它。

### 终止脚本
/root 中附带一个 kill 脚本，该脚本使用 Modded Warfare 的 [kill 脚本](https://github.com/MODDEDWARFARE/PPPwn_WRT/blob/main/kill.sh) 作为模板，但经过修改以适用于此设置。
原始脚本使用 [此资源](https://askubuntu.com/questions/180336/how-to-find-the-process-id-pid-of-a-running-terminal-program) 作为模板

### WPS 按钮漏洞触发器
1. 安装 kmod-button-hotplug
`opkg install kmod-button-hotplug`
2. 在 /etc/hotplug.d/button/ 中创建一个名为“wps”的文件，内容如下。
```
source /lib/functions.sh

do_button () {
    local button
    local action
    local handler
    local min
    local max

    config_get button "${1}" button
    config_get action "${1}" action
    config_get handler "${1}" handler
    config_get min "${1}" min
    config_get max "${1}" max

    [ "${ACTION}" = "${action}" -a "${BUTTON}" = "${button}" -a -n "${handler}" ] && {
        [ -z "${min}" -o -z "${max}" ] && eval ${handler}
        [ -n "${min}" -a -n "${max}" ] && {
            [ "${min}" -le "${SEEN}" -a "${max}" -ge "${SEEN}" ] && eval ${handler}
        }
    }
}

config_load system
config_foreach do_button button
EOF

uci add system button
uci set system.@button[-1].button="wps"
uci set system.@button[-1].action="released"
uci set system.@button[-1].handler="pppwn --interface INTERFACE --fw 900 --stage1 "/etc/pppwnwrt/stage1.bin" --stage2 "/etc/pppwnwrt/stage2.bin" --auto-retry"
uci set system.@button[-1].min="0"
uci set system.@button[-1].max="2"
uci add system button
uci set system.@button[-1].button="wps"
uci set system.@button[-1].action="released"
uci set system.@button[-1].handler="/etc/rc.button/wps"
uci set system.@button[-1].min="3"
uci set system.@button[-1].max="10"
uci commit system
```
确保在“handler”行中放入正确的接口/FW

当按下少于 2 秒时，将触发 pppwn 运行，当按下 3-10 秒时，将触发 wps 功能。.

在有效载荷期间触发 LED 打开和关闭特定于您的路由器，这就是它被排除在该配置之外的原因。
If you set up auto-start, disable it by running `/etc/init.d/pppwnwrt disable` and `/etc/init.d/pppwnwrt stop`

如果您设置了自动启动，请通过运行“/etc/init.d/pppwnwrt disable”和“/etc/init.d/pppwnwrt stop”将其禁用
可以在此处找到带有 LED 示例的更多资源 https://openwrt.org/docs/guide-user/hardware/hardware.button

### 手动安装
1. git clone sistro 的 pppwn repo 并为您的 FW 构建 pppwn S1 和 S2 PL
https://github.com/SiSTR0/PPPwn
2. 将 S1 和 S2 PL 放在名为 `pppwnwrt` 的目录中，并将该目录 scp 或 sftp 到 /etc
3. git clone 并构建 pppwn_cpp 或从其夜间构建服务器中提取
Repo：https://github.com/xfangfang/PPPwn_cpp
夜间构建服务器：https://nightly.link/xfangfang/PPPwn_cpp/workflows/ci.yaml/main?status=completed
4. 将可执行文件 scp 或 sftp 到 /bin
5. 安装 libpcap1
6. 运行 pppwn

### DD-WRT 安装
DD-WRT 使用不同的包管理器和 pcap 包，因此上面的 OpenWRT 安装脚本不适用于DD-WRT。
1. 按照手动安装方法执行步骤 4
2. 安装 libpcap `ipkg install libpcap`
3. 运行 pppwn
