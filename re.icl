09 错误 重复 无法重复 软件 硬件 内核 从属 测量卡 AFMCU 通常 轨道 左边 右边 现存
00    内核程序未加载
01    测试头程序/数据未加载
02.04 头部相机(%f) 与布局中(%F)不同
02    测试手臂(%f)与布局中(%F)不同
03    不良测试头软件(v%v), %V+ 需要
04    FIELDSAFE 线路损坏
05.00 Z感应器损坏或调整不当
05.86 潜在危险的AFMCU错误
05    未知的自检错误%s
06.00 Z 轴向下移动超时
06.01 Z 轴向上移动超时
06.02 检测到表面接触
06.03 Z 轴移动时Z坐标过低
06.04 向下移动是ADC错误
06.05 向上移动是ADC错误
06.06 ADC 或Z坐标错误
06.10 快速测量Z坐标
06.11 Z坐标不再有效，硬件复位
06.12 过热危险
06.13 Z风扇被阻塞或断开
06    未知的Z方向运动错误 %s
07    多路卡错误%X%R继电器
&4000 簧片继电器短路
&2000 扩展头部控制缺失
&1000 两个输出连接到同一个测试手臂
&0800 测试手臂连接到错误的输出
&0400 继电器太慢
&0200 继电器短路
&0100 继电器电阻太高
&0080 损坏的故障检测器
&0040 DC通道故障
&0030 不良通道放大
&000E 高零位偏移
&0001 多路卡缺失
08    相位丢失在v=%i (%P mm/s)%p
09.00 找不到末端感应器
09.01 无法通过编码器零脉冲
09.02 位移编码器A相零位,值%i
09.03 位移编码器B相零位,值%i
09.04 编码器A相缺失,值%i
09.05 差分编码器幅度错误,值%i
09.06 找不到编码器零脉冲
09.07 数字编码器计数失败,值%i
09.08 无法重复编码器零脉冲
09.09 编码器计数丢失脉冲,值%i
09.0A 微步未纠正
09.0B 编码器零位错误,值%i
09.0C 零位感应器始终处于激活状态
09.0D 零位已找到或搜索中断
09.0E 电机线圈中的电流不同
09.10 Z轴抬起坐标低,值%u
09.11 Z轴抬起坐标太高,值%u
09.12 针头压力感应器调整不当,值%u
09.13 针头压力感应器异常,值%u
09.14 完全无噪声的压力感应器
09.15 Z轴无动力,值%i
09.16 编码器丢失
09.17 大功率固定轴,关闭
09.18 零位感应器始终打开
09.19 软针的预接触压力太低
09.1A 末端开关镖旗中的间隙
09.FF 编码器卡缺失或损坏
09    未知的编码器错误%s, 值 %i
0A.00 温度感应器缺失
0A.01 温度感应器电阻不良(%t)
0A.02 模拟总线之间的连接
0A.03 温度感应器完全损坏
0A    未知的温度感应器错误%s (%t)
0B    紧急模式%S 激活
&0001 用户停止模式有效
&0002 紧急按钮已按下
&0004 气压低
&0008 危险错误紧急停止启动
0D.00 无法确定U/I 开关类型
0D.10 极高的 X加速度
0D.11 极高的 Y加速度
0D.12 X 编码器的两个相位都低
0D.13 Y 编码器的两个相位都低
0D.14 X 编码器计数器报告错误
0D.15 Y 编码器计数器报告错误
0D.16 测试头报无效的 Y坐标错误
0D.17 Z 编码器的两个相位都低
0D.18 热电机，紧急级别%l
0D.19 电机温度感应器故障
0D.1A 电机驱动器无动力
0D    相机：未知的测试头坐标错误
0E.01 相机：错误的火线响应码%s
0E.02 相机：找不到单位目录
0E.03 相机：无法找到从属目录
0E.04 相机：无法找到命令寄存器
0E    火线相机错误%s
10.00 112.通讯超时，测试头%f (期望值 %F)
10.01 软复位时间过长
10.02 软复位被硬件复位打断
10.03 精度没有到达
10.04 要求的动子时间过长
10.05 重置火线总线时超时
10.06 初始化步骤比预期的要长
10.07 相位丢失较多，轨道运动停止
10.08 实时驱动程序错过了2个或2个以上的周期
10.09 由于软复位，SPS命令丢失
10.0A 测量卡无响应
10    SHARC控制器无响应，类型%s
20.00 数据传输错误（内核-测试头）
20.01 串行总线测试错误(%y 代替 %Y)
20.02 测试头探测到串行总线错误
20.03 内核探测到串行总线错误
20.04 串行数据错误
20.05 数字总线测试错误(%y 代替 %Y)
20.08 嵌入式软件的校验和错误
20.09 无法重置OHCI卡
20.0A 无法重置火线总线
20.0B 无法将数据传输到SHARC,事件%i
20.0C OHCI卡无法识别的代码
20.0D OHCI卡接收到错误数据
20.0E OHCI卡不是火线的根节点
20.0F 控制器断开连接
20.10 请求到错误的火线节点
20.11 SHARC控制器的节点ID已更改
20.12 无法发送命令到测量卡
20.13 校验和错误
20.14 未知设备在火线总线上
20.15 丢失火线中心重置
20.16 测试头消失
20.17 测试头回位
20.18 头部摄像头消失
20.19 头部摄像头回位
20.1A SHARC的回应太长
20.1B 火线缓冲区溢出
20.1C 无法保存温度历史记录数据
20.1D 温度阵列卡%i丢失或损坏
20.1E 温度感应器%i缺失或损坏
20.1F 153.热风温度%j（感应器%i）与要求的%k不同
20.20 以太网总线上的数据无效
20.21	以太网输入FIFO缓冲区溢出
20.22 所需空气温度过高(左 %j, 右 %i)
20    未知 I/O错误%s
21    错误0感应器
22    错误坐标
23    命令顺序错误
24.00 错误
24    错误命令%S
25.01 命令太长
25    命令大小错误
26    表/列队溢出
27    零相错误
28    不良数据
29    测点未找到，步骤 %u
2A    AFMCU 错误%s (%L)
2B    被零除
2C    标记错误%s
2D.00 无效的轨道数量
2D.01 布局中的轨道未按并排排列
2D.02 布局中包含虚拟轨道或负宽度的轨道
2D.03 轨道中心在轨道外部
2D.04 轨道未按Y坐标排序
2D.05 每侧的轨道数量超过 7
2D.06 某些控制器不可用
2D.07 控制器大于布局中列出的数量
2D.08 多个具有相同ID的控制器
2D.09 未知测试机类型
2D.0A 压力感应器未在布局中定义
2D.0B 压力感应器缺失
2D.0C 无法检测压力感应器的类型
2D.10 不存在的测试头%i被替换
2D.11 测试头%i 替换2次
2D.12 连接器%i 替换了2次
2D.13 测试头%i的替代连接不存在
2D.14 不支持模拟总线的反向连接%i
2D.15 第二个架板框的补偿无效
2D.16 背钻针与双测量卡不兼容
2D    未知的布局错误 %S
50.01 开尔文针头短路
50.02 无法自动检测探针类型
50.03 不支持探针自动检测
50    线缆断开
51    头部卡放大器位移%i 位
52    针头或电缆与屏蔽层短路
53.00 等待100 mks 超时
53.01 由于 8253 失效导致超时
53.10 测量超时
53.11 相位丢失，测量中断
53    未知的超时错误%s
54    测量卡错误%X
&0001 测量卡缺失
&0002 噪声测量
&007C DC参数超出范围
&0F80 AC参数超出范围
&1000 总线电压超出范围
&2000 ACCH 连接缺失
&4000 AC过载检测器故障
&8000 无法控制头部卡
55    模拟线路的电容不良(%u pF)
56.00 DC信号超出ADC范围[0..65535] 位
56.01 DC信号超出范围(%i 位,期望值 %j)
56.02 不稳定的DC信号(%i 位, 最大期望值 %j)
56.03 干扰的DC信号(%i 位, 最大期望值 %j)
56.04 不可复制的DC (%i 位, 最大期望值 %j)
56.05 过载检测器故障
56.06 无法校准U或I源的零位移
56.07 测试电容损坏，上升速度%l bits/us
56.08 输出电流取决于电压，差别%l bits/us
56.09 不能限制U输出电流
56.0A 正负U 电流限制太大(%i,%j bits)
56.0B U 输出上的100欧姆电阻缺失
56.0C 继电器工作缓慢K%k (Ton=%i, Toff=%j us)
56.0D 无法为精密电阻校准低电流
56.20 ADC零位: %M
56.21 参考电压: %M
56.22 主DAC: %M
56.23 辅助DAC: %M
56.24 零U位移: %M
56.25 接地总线: %M
56.26 9V 总线检查: %M
56.27 总线短路检查: %M
56.28 U 电流极限: %M
56.29 低电流的零位移: %M
56.2A 低电流源: %M
56.2B 高电流的零位移: %M
56.2C 高电流源: %M
56.2D I-U 转换器: %M
56.2E +5V模拟电源上的%i Hz有干扰
56.2F 测试头在测量中屏蔽
56.30 继电器在电流作用下重新切换
56.31 模拟总线有对地短路(%i,%j 位)
56.32 直流滤波器故障
56.33 直流滤波器放大无效
56.34 未知类型的辅助DAC
56.35 ADC滤波器损坏，将被关闭
56.37 +15V模拟电源上的%i Hz有干扰
56.38 头部卡I-U反馈电阻误换相
56.39 电流源的电压限制供应链短路
56.3A 300 mA电源大电流故障
56.3B 多路卡(%i)与布局中(%j)的不同
56.3C 多路卡上输出电压(%i 代替 %j mV)无效
56.3D 多路卡上输出电压缓慢上升
56.3E 多路卡上输出的电阻(%i 代替 %j Ohm)无效
56.3F 布局中其它电源的配置无效
56.40 无法限制其它电源的活动输出
56.41 多路卡漏电
56.FF 测量卡工作在模拟模式
56    测量卡DC错误%s (%i,%j)
57.00 头部卡继电器太慢(%i us)
57.01 头部卡 U放大器调零不工作
57.02 头部卡光继电器电阻异常
57.03 头部卡I-U转换器AC x 1补偿无效
57.04 头部卡I-U转换器AC x 10补偿无效
57.05 头部卡电压放大器AC x 1补偿无效
57.06 未知头部卡类型
57.07 头部卡无法断开背钻针头的屏蔽罩
57    头部卡错误 %s
58.00 高压超出ADC范围[0..65535]位
58.01 HV 信号损坏(%i 位, 期望值 %j)
58.02 不稳定高压信号（提高 %i 位, 最大期望值 %j）
58.03 高压干扰信号(%i 位, 最大期望值%j)
58.04 不可复制 HV (%i 位, 最大期望值%j)
58.06 无法校准高压电源零点偏移
58.08 HV电源输出电流无效(%i 位, 期望值 %j)
58.09 HV 电源电压因素无效
58.0A 内部高压崩溃
58.0B HV电源电压无效(%i, %j V)
58.0C 电流感应电阻器无效或损坏
58.0D 慢速重新切换1-10 mA(%i ms)
58.0E 无法关闭高压电源
58.0F 高压PGA放大率（%i）与期望值（%j）不同
58.10 高压变化太慢(dT=%i us)
58.11 调试模式下，HV测量时测试手臂被屏蔽
58.12 高频补丁缺失
58.13 高压DAC 故障
58.14 高压调压器干扰(%i 位, 期望值 %j)
58.15 无法确定高压单元的类型
58.16 高压电流传感器故障
58.17 来自高压电流感应器的有限信号（%i bits, 期望值32768）
58.18 PGA 204不能进行高压测试
58.19 无法进行两步高压测试
58    测量卡高压错误%s (%i,%j)
59.01 测试头不支持CRT测试
59.02 正高压电源零点无效(%i V)
59.03 正高压电源电压无效(%i V)
59.04 无效CRT复位电压(%i V)
59.05 无效CRT电压(%i V)
59.06 无法校准头部CRT电容
59.07 CRT 崩溃（%i V）
59.08 CRT测试不稳定
59.09 开尔文针头无短接继电器
59.0A CRT 放电太慢
59.0B 250V和500V头部卡混合
59.0E 无法关闭高压电源
59.11 调试模式下，CRT测量时测试手臂被屏蔽
59    测量卡CRT错误 %s
5A.01 LA接地电压不良 (%i 位)
5A.02 DAC-GND 补丁缺失
5A.03 LA测试差动放大器故障
5A.04 头部与LA 测试不匹配
5A.05 LA差动放大器零点无效
5A.06 LA 电流源损坏
5A.07 LA测量时，所有测试手臂被屏蔽
5A.08 LA电压放大器故障
5A.09 LA 电流传感器损坏
5A.0A LA 继电器太慢 % 继电器
5A.0B LA 继电器电阻太高 % 继电器
5A.0C 不平衡的LA电流源
5A.0D LA测试电流取决于电压，偏差%l bits/us
5A.0E LA 测试输出与测量卡断开
5A.0F LA 高通滤波器缺失或损坏
5A.11 -调试模式下，LA测量时测试手臂被屏蔽
5A    LA 卡报错 %i
5F.01 未知的外部设备 %i
5F.02 外部设备 %i 没有连接
5F.03 无效的外部设备 %i
5F.04 测量卡不支持外部设备
5F.05 不支持的外部设备
5F.06 无法发送测量信号给外部设备 %i
5F.07 等待外部设备超时 %i
5F.08 来自外部设备的无效响应 %i
5F    外部设备%i 错误%s
E0    开-关感应器不工作
E1    无法锁定架板框
E2    锁定感应器不工作
E3    架板框开着但是锁着
E4    架板框无法解锁
E5    无24V电源
E6    无真空
E7    气压低
E8.01 SPS错误%s-无法与SPS通讯
E8.02 SPS错误%s-自动装载机没有连接
E8.03 SPS错误%s-架板框禁止移动
E8.04 SPS错误%s-架板框禁止Z方向移动
E8.0B SPS错误%s-紧急停止启动
E8.0C SPS错误%s-自检错误
E8.0D SPS错误%s-内部错误
E8.0E SPS错误%s-无法识别的命令
E8.0F SPS错误%s-推料机处于推料位置
E8.10 SPS错误%s-某些单元还在移动
E8.11 SPS错误%s-禁止操作
E8.12 SPS错误%s-无法继续
E8.14 SPS错误%s-输入单元
E8.15 SPS错误%s-输入单元
E8.16 SPS错误%s-输出单元
E8.17 SPS错误%s-停止器
E8.18 SPS错误%s-停止传感器
E8.19 SPS错误%s-现有PCB不正确
E8.1A SPS错误%s-升降机不在下面位置
E8.1B SPS错误%s-装载机气动
E8.1C SPS错误%s-吸盘
E8.1D SPS错误%s-架板框气动
E8.1E SPS错误%s-输入端空
E8.1F SPS错误%s-无法装载PCB
E8.20 SPS错误%s-输出端满
E8.21 SPS错误%s-无法定位打印头
E8.22 SPS错误%s-无效的X-Y打印坐标
E8.23 SPS错误%s-硬件配置不正确
E8.25 SPS错误%s - SPS报错 %i
E8.28 SPS错误%s –无法连接到打印机（%L）
E8.29 SPS错误%s –无法卸载PCB
E8.2A SPS错误 %s–无法卸载PCBs
E8.2B SPS错误%s  –读取条形码超时
E8.2C SPS错误%s – 纸张用完
E8    SPS%s错误
E9.01 PCB丢失
E9    停止测试，代码 %s
FF.01 HARD.DLL - 语法错误
FF.02 HARD.DLL - 无法识别的命令
FF.03 HARD.DLL - 值超出允许范围
FF.04 HARD.DLL - 额外字符在线
FF.05 HARD.DLL - 二进制文件中的奇数字节
FF.06 HARD.DLL - 无效坐标
FF.07 HARD.DLL - 无法识别的子命令
FF.08 HARD.DLL - 重复参数
FF.09 HARD.DLL - 内部数据表溢出
FF.0A HARD.DLL - 内部错误
FF    HARD.DLL - 命令执行错误
?     未知错误 %E

