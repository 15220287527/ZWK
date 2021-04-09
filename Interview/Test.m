//
//  Test.m
//  Interview
//
//  Created by zhangweikang on 2021/3/3.
//

#import "Test.h"

@implementation Test

- (instancetype)init
{
    self = [super init];
    if (self) {
        NSLog(@"[self class] = %@", [self class]);
        NSLog(@"[super class] = %@", [super class]);
        NSLog(@"[self superclass] = %@", [self superclass]);
        NSLog(@"[super superclass] = %@", [super superclass]);
        
        
        NSLog(@"%d", [[NSObject class] isKindOfClass:[NSObject class]]);
        NSLog(@"%d", [[NSObject class] isMemberOfClass:[NSObject class]]);
        NSLog(@"%d", [[Test class] isKindOfClass:[Test class]]);
        NSLog(@"%d", [[Test class] isMemberOfClass:[Test class]]);
    }
    return self;
}

/*
 
 19:17
 伴鱼：
 算法题：判断平衡二叉树
 weak的实现原理:（Runtime维护了一个weak表，用于存储指向某个对象的所有weak指针。weak表其实是一个hash（哈希）表，Key是所指对象的地址，Value是weak指针的地址（这个地址的值是所指对象指针的地址）数组.
 weak弱引用表是可变的么还是不可变的
 weak是在什么时候置nil的，如果同时有很多对象对性能影响大怎么办
 UIView 和 CALayer的关系和区别
 UIView 和 CALayer在动画上的区别
 frame和bounds在什么情况下是不相等的
 bounds x,y 一定是0,0么，为什么
 bounds 改成 (50, 50, width, height)会发生什么，view本身，子View？
 58:
 说下你在开发过程中遇到过的内存泄漏
 NSTimer 怎么处理内存泄漏
 Delegate什么情况下会出现内存泄漏，怎么解决
 Delegate和Notification的区别
 多线程相关
 iOS中有哪些多线程技术
 如果有两个同步任务嵌套会怎样
 常见的锁，为什么要加锁
 C依赖A B任务执行完才能执行，你怎么设计
 读写锁底层怎么实现
 JavaScriptCore相关
 什么是JavaScriptCore，JS和Native是怎么进行通信的
 你知道hybrid么
 拼多多
 算法: 手写LFU（用字典写了二十多分钟，面试官让优化只知道可以用双链表优化，但是集体没能写出来）
 一个操作如果耗时5s后返回nil，否则返回一个字符串，你怎么设计（要求手写代码）
 GCD中常见的操作（要求写代码）
 Struct中有一些成员变量占多少字节
 一个OC对象在iOS中所占内存的字节数 受限于内存分配的机制，(一个 NSObject对象都会分配 16byte 的内存空间。但是实际上在 64位 下，只使用了 8byte;在32位下，只使用了 4byte)
 你看过alloc的源码么，你刚刚说的代码是在哪个文件哪一行
 dealloc的整个过程->首先调用_objc_rootDealloc(),然后调用rootDeallock(),然后判断五个条件
           如果有一任意一个，调用objc_dealloc(),否者执行free()函数；
        
 NSURLSession相关的内容（具体忘了）
 web和native怎么共享cookie，加载web时候先为webview的cinfiguration设置cookie， 并让多个webView共享WLProcessPool
 xx(前司)有动态库打包么，你看过xx ipa(前司app)的结构么
 内联函数和普通函数的区别
 怎么hook一个C函数
 有什么想问的么
 百度
 聊项目：主要问了项目的技术栈选择，以及项目中有哪些难点
 http header 和 body
 GET和POST请求
 GET请求参数一定是放在URL中的么
 HTTPS （TLS是啥，怎么建立连接等）
 动态库和静态库的区别
 +load 和 initialized方法的区别
 +load的调用时机
 +load分类中的处理
 分类的实现机制
 分类和类别的区别
 分类中添加属性
 关联对象的原理
 算法：有一个很大的整形数据，转成二进制求1的个数（因为前面聊比较多，只要求说了下思路
 二面
 聊项目：自己项目偏后端，问了很多和后端相关的内容，后续问的问题也基本上要求从客户端和后端双重角度回答
 你了解的网络协议
 HTTP和TCP、UDP的联系
 HTTP和HTTPS的区别
 HTTPS的原理
 在HTTPS建立连接的时候都用了哪些加密算法，为什么要这么设计
 常见的加密算法
 对称加密算法和非对称加密算法的区别
 说说点击一个按钮后打开一个web页面从发送网络请求到页面展示都做了啥
 为什么能通过一个URL就能请求到对应的资源（域名解析等）
 如果客户端上有个按钮，点击会触发一次网络请求，在短时间内快速点击，怎么处理（从客户端以及服务端角度思考）
 知道什么是HTTPDNS么
 GET请求和POST的区别，POST请求参数能放在URL中么为啥
 你了解的HTTP请求响应状态码
 说说为什么要设计304这个状态码
 Web登录时怎么保持会话状态的
 你知道cookie和session的区别么
 你知道常见的网络攻击么
 什么是中间人攻击原理，怎么预防
 平常用过抓包工具么，说说抓包的原理
 如果让你设计一个HTTPS抓包你回怎么设计
 进程和线程的区别是啥
 进程的通信机制
 进程A和进程B通过管道通信的话是在同一个管道么
 多线程容易出现的问题，怎么解决
 死锁产生的条件以及对应的解决方案
 自旋锁和互斥锁的却别
 什么是虚拟内存，虚拟内存和物理内存的关系和区别
 行间的换页算法有哪些
 LRU、LFU
 继续问项目，为啥要做这些东西，碰到了什么难点
 你觉得你的优势和缺点是啥
 自己的未来规划
 还有什么想问的
 腾讯音乐
 想看机会的原因
 RN是这么做到和native通信的
 如果让你实现RN的效果你会怎么设计(这个问题看你功底了)
 Native是怎么将方法暴露出去的
 需求中的难点，你是怎么解决的
 A调用了B方法都做了什么事情
 ISA指针
 64位后怎么获取ISA指针
 runloop、runtime工作中有接触过嘛
 手指触摸屏幕后系统都做了哪些事情
 怎么监听页面的卡顿
 怎么监听函数执行时间
 Bigo
   算法(三道手写)
 字符串转整形
 反转链表（递归和非递归）
 将两个有序链表合并成一个有序链表

 iOS基础：
 Objective-C的内存管理
 ARC和MRC的区别
 Timer的使用，怎么避免循环引用
 autoreleasePool的底层实现机制
 autoreleasePool的底层数据结构，为什么要这么设计
 iOS中常见的多线程技术
 常见的锁，有什么区别
 如果让你设计读写锁，你怎么设计

 RN、flutter、weex：
 你怎么看待这些动态化技术
 RN、flutter以及weex的区别
  二面
 算法: 山脉数组找目标值(要求logN的时间复杂度)
 QA发现了一个按钮无法响应点击事件，可能是什么原因导致的（说了五种情况好像没有答到面试官要的点）
 iOS响应者链，怎么寻找最合适的响应者，如果为nil会怎么办
 frame和bounds的区别
 如果bounds的origin不是00会怎样
 你平常用过Charles么，说说Charles的抓包原理
 Charles能抓HTTPS么，怎么实现
 HTTPS怎么建立连接的
 中间人攻击，怎么避免
 多线程一般会有什么问题，请举个例子
 为什么会造成上述问题以及解决方案
 主队列和主线程的关系
 全局并发队列一定在主线程上运行的么
 项目相关，用了什么技术，有哪些难点，怎么处理的
 
 
 */

@end
