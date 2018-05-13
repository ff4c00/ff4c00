# 项目约定

## 特殊注释
* 注释以'待深入:'开始的是下一个技术瓶颈期需要解决的问题,现阶段不用想那么多.那么从现阶段到下一个技术瓶颈期需要多久?没准就是明天:)
* 注释以'推测:'开始的是下一个技术瓶颈期需要验证的问题,现阶段不用想那么多.那么从现阶段到下一个技术瓶颈期需要多久?没准就是明天:)
```ruby
hash = {"待深入:" => "解决", "推测:" => "验证"}
hash.each do |array|
  puts"注释以'#{array[0]}'开始的是下一个技术瓶颈期需要#{array[1]}的问题,现阶段不用想那么多.那么从现阶段到下一个技术瓶颈期需要多久?没准就是明天:)"
end
```
* `不要重复自己`
* 注释以'待优化:'开始的是后期需要调整的,功能现在可以正常使用,有一些自己的想法需要一些时间去做,现在没有必要去实现.
* 注释以'已优化:'开始的是对待优化的实现,将待改为已并在结尾注明时间.
* 注释以'待实现:'开始的是在编写代码过程中的一些想法,需要规划和思考如何实现.

-----
# VIM常用快捷键

## 光标移动
* `0` → 数字零，到行头
* `$` → 到本行行尾
* `^` → 到本行第一个不是空格的位置
* `g_` → 到本行最后一个不是blank字符的位置
* `ve` → 选取当前单词
* `nG` → 移动到第n行
* `gg` → 移动到首行
* `GG` → 移动到末行
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 

## 编辑
* `a` → 在光标后插入
* `I` → 在行首插入
* `o` → 在当前行后插入一个新行
* `O` → 在当前行前插入一个新行
* `<C-n>` → 插入模式下代码补全
* `dt"` → 删除内容直到遇见"
* `yt,` → 同理复制内容直到遇见,
* `x` → 删除光标所在的字符(单字符删除)
* `dw` → 删除光标位置到单词结尾
* `vf%` → 光标处选中直到遇见% 
* ` ` → 
* ` ` → 
* ` ` → 

## 保存
* `w` → 保存文件
* `w path/fine_name` → 将文件另存为指定路径下的指定文件名
* `wq` → 保存并退出
* `q!` → 不保存当前修改,强制关闭文件
* `ZZ` → 根据文件状态判断是否需要保存并关闭文件
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` →

## 批量替换
* [addr]s/源字符串/目的字符串/[option] <br> 
```
[addr] 表示检索范围，省略时表示当前行。
“1,20” ：表示从第1行到20行；
“%” ：表示整个文件，同“1,$”；
“. ,$” ：从当前行到文件尾；

s : 表示替换操作

[option] : 表示操作类型
g 表示全局替换; 
c 表示进行确认
p 表示替代结果逐行显示（Ctrl + L恢复屏幕）;
省略option时仅对每行第一个匹配串进行替换;
如果在源字符串和目的字符串中出现特殊字符，需要用”\”转义
```
`%s/'\/user\/home'/'/home/mike'/g ` → 在文件全局将/user/home替换为home/mike

## 复制
* `"+y` → 复制到系统剪贴板
* `v (光标移动)` → 选中文本 
* `yy` → 复制当前行 
* `np` → 将复制内容粘贴n次(一次n可以省略)
* `d` → 将选中内容进行剪切
* `dd` → 将当前光标所在行进行剪切
* ` ` → 
* ` ` → 

## 撤销
* `u` → 撤销上一步操作 
* `<C-r>` → 恢复上一步被撤销的操作
* ` ` → 
* ` ` → 
* ` ` → 

## 其他
* `zo` → 展开折叠，只展开最外层的折叠.
* `zO` → 对所在范围内所有嵌套的折叠点展开，包括嵌套折叠 
* `tabnew 路径` → 在新table打开路径指向的文件
* `tabc` → 关闭当前table
* `gt` → 多窗口间切换 
* `vsplit` → 纵向分割窗口 
* `split` → 横向分割窗口
* `g/^s*$/d` → 删除文本中的空白行 
* `tabo` → 关闭除当前tab外其他所有tab 
* `shift tab` → 在多个tab中快速切换 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 

## 常用组合操作
* `0 <C-v> (光标移动) I(要插入的内容) [ESC]`  → 对多行执行同一操作,常用于多行注释
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 
* ` ` → 


## 参考资料
-----

# 自动测试
## guard自动测试
### 常用命令
* 启动: `bundle exec guard`

-----

# 参考链接
* [酷壳-VIM入门](https://coolshell.cn/articles/5426.html)
* [简书-Markdown的基本语法](https://www.jianshu.com/p/250e36bb5690)
-----
