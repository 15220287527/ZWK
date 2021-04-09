//
//  Swift.swift
//  Interview
//
//  Created by 张伟康 on 2020/10/24.
//

import Foundation

/*
 
 函数式编程
    柯力化
 
 面向协议编程
    协议可以扩展方法实现
 
 
 类型推断 不用编写main函数
 
 */


//语法树 中间代码 LLVM中间代码 生成汇编代码

/*
 
 类型安全
 值类型 引用类型
 区间运算符
 inout输入输出参数的本质是地址传递
 mov 值传递
 lea 地址传递
 rip 寄存器（存储CPU要执行的下一条指令地址）全局变量
 rbp 局部变量
 
 
 枚举
    关联值
    原始值
 
 
 可选项
    可选项绑定自动解包 if let num = num?
    空合并运算符 a ?? b
    guard语句用来提前退出 guard else
    隐式解包 ! （不用可选项代替）
 
 lldb
    register read
    register write
    x/3xw
    n s 源码级别
    ni si  汇编级别
    finish
    bt 打印函数调用栈
 
 结构体
    初始化器：保证所有成员都有初始值
 
 类
 
 闭包表达式
    简写 省略类型 省略return $0表示第一个参数
    尾随闭包
    闭包 一个函数和它捕获的变量、常量环境组合起来，叫做闭包
    自动闭包 @autoclosure
 
 inout 输入输出参数传地址值
 
 方法
 
 下标
 
 继承
    方法、下标、属性
    final 不能被子类继承
 
 多态
    虚表
 
 初始化器
    便捷初始化器 -> 指定初始化器 -> 父类指定初始化器
    required 子类必须实现
  
 is
    判断是否是某种类型
 
 as
    as   强制转换
    as？ 返回可选类型
    as!  返回可选类型 强制解包
 
 do catch 捕捉异常
 
 defer 离开代码块必须要执行的代码
    
 泛型
    
 运算符重载
    函数名相同，功能不同
    Equatable
    === 引用类型地址值是否相等
 
 访问权限
    open public internal fileprivate private
 
 内存管理
    闭包使用捕获列表
    逃逸闭包 @escaping
    
    
    
 
 */


