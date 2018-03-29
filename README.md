# 项目约定
## 特殊标记
### @mark ... @@mark

* commit中包含 "@体会" 关键字的提交,在提交内容中包含了对本次或近几次提交内容的感触,后期将通过脚本将体会内容及版本号提取出来.以 "@@体会" 结束.

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
-----

# 自动测试
## guard自动测试
### 常用命令
* 启动: `bundle exec guard`

-----

# 书中提到或推荐工具
##### 正则表达式匹配工具
* Rubular: 交互式正则表达式匹配工具

-----