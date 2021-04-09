//
//  Flutter.swift
//  Interview
//
//  Created by 张伟康 on 2020/11/6.
//

import Foundation

/*
 命令式编程
 声明式编程
 
 必选参数
 命名可选参数
 
 hot reload
    执行build
 hot restart
    重新执行全部代码
 
 main
 runAPP
 MaterialAPP material风格
 Scaffold 脚手架
    appBar
    body
 
 Widget
    有状态 StatefulWidget
    无状态 StatelessWidget
 
 State 状态类
    setState
 
 build
 
 Row Column Center Text SizedBox Container
 RaiseButton
 
 生命周期
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 一个NSObject对象占用多少内存？
 对象的isa指针指向哪里？
 OC的类信息存放在哪里？
 KVO的本质是什么？
 如何手动触发KVO？
 直接修改成员变量会触发KVO么？
 通过KVC修改属性会触发KVO么？
 Category的实现原理
 load、initialize方法的区别什么？它们在category中的调用的顺序？以及出现继承时他们之间的调用过程？
 如何给Category添加成员变量？
 block的原理是怎样的？本质是什么？
 __block的作用是什么？有什么使用注意点？
 block的属性修饰词为什么是copy？使用block有哪些使用注意？
 block在修改NSMutableArray，需不需要添加__block？
 OC的消息机制
 消息转发机制流程
 什么是Runtime？具体应用
 讲讲 RunLoop，项目中有用到吗？
 runloop和线程的关系？如何实现线程保活？
 timer 与 runloop 的关系？
 iOS的多线程方案有哪几种？你更倾向于哪一种？
 线程安全的处理手段有哪些？
 使用CADisplayLink、NSTimer有什么注意点？
 讲一下你对 iOS 内存管理的理解
 weak指针的实现原理
 autorelease对象在什么时机会被调用release
 方法里有局部对象， 出了方法后会立即释放吗
 优化你是从哪几方面着手？
 列表卡顿的原因可能有哪些？你平时是怎么优化的？
 讲讲 MVC、MVVM、MVP，以及你在项目里具体是怎么写的？
 你自己用过哪些设计模式？
 一般开始做一个项目，你的架构是如何思考的？

 
 
 
 
 
 
 请问一下代码的打印结果是什么？
 
 dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
 dispatch_async(queue, ^{
     NSLog(@"1");
     [self performSelector:@selector(test) withObject:nil afterDelay:.0];
     NSLog(@"3");
 });

 - (void)test {
     NSLog(@"2");
 }
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
 
    
 
 */
