//
//  Object-C.m
//  Interview
//
//  Created by 张伟康 on 2020/10/20.
//

#import "Object-C.h"
#import <objc/runtime.h>
#import <malloc/malloc.h>

@interface Object_C ()

@property (nonatomic, strong) NSObject *obj;

@end

@implementation Object_C

#pragma mark - OC对象============================

- (void)ocCode {
    
    class_getInstanceSize([NSObject class]);//8 成员变量占据空间 内存对齐后
    malloc_size((__bridge void *)_obj);//16  真正分配的内存
    
    object_getClass(nil); //获取isa指向的类或元类对象
    objc_getClass(""); //获取类对象
    
    
    
    dispatch_queue_t queue = dispatch_get_global_queue(0, 0);
    dispatch_async(queue, ^{
        NSLog(@"1");
        [self performSelector:@selector(test) withObject:nil afterDelay:.0];
        NSLog(@"3");
    });
}

- (void)test {
    NSLog(@"2");
}

/*
 
 内存对齐：结构体的最终大小必须是最大成员大小的倍数
 
 一个NSObject对象占用多少内存
    系统分配了16个字节，64bit环境下只使用了8个字节
 
 class对象存储的信息
    isa指针
    superclass指针
    属性信息 对象方法信息
    协议信息 实例对象信息
 meta-class
     isa指针
     superclass指针
     类方法信息
 
 isa和superclass
    instance的isa指向class
    class的isa指向meta-class
    meta-class的isa指向基类的meta-class
 
    class的superclass指向父类的class，如果没有父类，superclass指针为nil
    meta-class的superclass指向父类的meta-class，基类的meta-class的superclass指向基类的class
    
 
 */


#pragma mark - Category============================

- (void)categoryCode {
    
    objc_setAssociatedObject(self, @selector(categoryCode), @"name", OBJC_ASSOCIATION_COPY_NONATOMIC);
    objc_getAssociatedObject(self, _cmd);
    objc_removeAssociatedObjects(self);//删除对象中 所有关联对象
    
    
    
}

/*
 
 Category实现原理
    Category编译之后低底层结构是struct category_t,里边存储着分类的对象方法、类方法、属性、协议信息
    在程序运行过程中，runtime会将Category的数据，合并到类信息中
 
 Category和Class Extension的区别是什么
    Extension在编译的时候，它的数据已经包含在类信息中
    Category是在运行时，才会将数据合并到类信息中
 
 +load
    load方法在runtime在加载类、分类的时候调用
    1、先调用类的+load
        按照编译先后顺序调用
        调用子类的+load之前会先调用父类的+load
    2、再调用分类的+load
        按照编译先后顺序调用
 
 +initialize
    在类第一次接收到消息时调用
    先调用父类的initialize再调用子类的initialize,先初始化父类，再调用子类，每个类只会初始化一次
 
 +load和+initialize区别
    load直接找到函数地址调用，initialize是通过objc_msgSend进行调用
    如果子类没有实现initialize，会调用父类的initialize，(父类的initialize会被调用多次)
    如果分类实现了initialize，就会覆盖类本身的initialize调用
 
 关联对象
     AssociationsManager
     AssociationsHashMap
     ObjectAssociationMap
     ObjcAssociation
 
    Category不能直接添加成员变量，可以通过关联对象间接添加
 
    关联对象并没有存储在被关联对象内存中
    存储在全局的统一的一个AssociationsManager中
    设置关联对象为nil表示移除关联对象
 */


#pragma mark - KVC============================

- (void)kvcCode {
    NSObject *obj;
    [obj setValue:@"" forKey:@""];
    [obj setValue:@"" forKeyPath:@""];
    [obj valueForKey:@""];
    [obj valueForKeyPath:@""];
    
    
    [obj willChangeValueForKey:@""];
    [obj didChangeValueForKey:@""];
}

/// 是否允许访问成员变量
+ (BOOL)accessInstanceVariablesDirectly {
    return YES;
}

/// Key找不到
- (void)setValue:(id)value forUndefinedKey:(NSString *)key {
    
}

/*
 1、通过KVC修改属性会触发KVO吗
    会触发KVO
    KVC内部调用willChangeValueForKey和didChangeValueForKey
 
 2、KVC的赋值和取值过程是怎样的，原理是什么
    赋值:
     setKey: _setKey:
     accessInstanceVariablesDirectly
     _key、_isKey、key、isKey
     NSUnknownKeyException
    取值:
    getKey、key、isKey、_key
    accessInstanceVariablesDirectly
    _key、_isKey、key、isKey
    NSUnknownKeyException
 
 */


#pragma mark - KVO============================

- (void)dealloc
{
    [self.obj removeObserver:self forKeyPath:@""];
}

- (void)kvoCode {
    NSKeyValueObservingOptions options = NSKeyValueObservingOptionNew | NSKeyValueObservingOptionOld;
    [self.obj addObserver:self forKeyPath:@"" options:options context:@"123"];
}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    
}


- (void)setAge:(int)age {
    _NSSetIntValueAndNotify();
}

void _NSSetIntValueAndNotify() {
//    [self willChangeValueForKey:@""];
//    [super setAge:age];
//    [self didChangeValueForKey:@""];
//    didChangeValueForKey内部会触发监听器（Observer）的监听方法
}

/*
 
 1、iOS用什么方式实现对一个对象的KVO（KVO的本质是什么）
    NSKVONotifying_MJPersion
    利用RuntimeAPI动态生成一个子类，并且让instance对象的isa指向这个全新的子类
    当修改instance对象的属性时，会调用Foundtion的_NSSetXXXValueAndNotify函数
 
 2、如何手动触发KVO
    手动调用willChangeValueForKey：和didChangeValueForKey:
 
 3、直接修改成员变量会触发KVO吗
    不会触发KVO，KVO的原理是动态生成子类，重写父类的set方法
 */


#pragma mark - Block============================

- (void)blockCode {
   ^{
       NSLog(@"this is a block!");
   }();
   
   void (^block)(int, int) = ^(int a, int b){};
   
   block(10, 20);
    
    
   
}

/*

block变量捕获机制
   auto局部变量 值传递
   static局部变量 指针传递
   全局变量 不捕获 直接访问

block的类型
   _NSGlobalBlock  全局区 没有访问auto变量        调用copy什么也不做
   _NSStackBlock   栈区   访问了auto变量         调用copy从栈复制到堆
   _NSMallocBlock  堆区   NSStackBlock调用copy  调用copy引用计数+1

循环引用
   __weak(指向的对象销毁时，指针自动置为nil)
   __unsafe_unretained

1、block的原理是怎样的，本质是什么
   block是封装了函数调用以及函数调用环境的OC对象

2、__block的作用是什么，有什么使用注意点
   编译器会将__block变量包装成一个对象
   注意点：MRC环境下不会对OC对象产生强引用

3、block的属性修饰词为什么是copy，使用block有哪些使用注意
   block一旦没有进行copy操作，就不会在堆上
   注意点：循环引用问题

4、block在修改NSMutableArray，需不需要添加__block
   不需要，只是使用指针地址，没有修改指针地址



*/


#pragma mark - Runtime============================

/// 动态方法解析
+ (BOOL)resolveInstanceMethod:(SEL)sel {
    return YES;
}

+ (BOOL)resolveClassMethod:(SEL)sel {
    return YES;
}

//消息转发 

+ (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (id)forwardingTargetForSelector:(SEL)aSelector {
    return [super forwardingTargetForSelector:aSelector];
}

- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector {
    return [NSMethodSignature signatureWithObjCTypes:""];
}

- (void)forwardInvocation:(NSInvocation *)anInvocation {
    [anInvocation invokeWithTarget:[NSObject new]];
}

- (void)doesNotRecognizeSelector:(SEL)aSelector {
    
}

/*
 ISA
    arm64之前之前存放类对象和元类对象的地址值，arm64之后采用共用体存储更多信息，其中33位拿来存放地址值
 
 方法缓存cache
    使用散列表
 
 @dynamic 提醒编译器不要自动生成setter和getter的实现，不要自动生成成员变量
 
 super
    消息接收者依然是子类对象
    从父类开始查找方法的实现
     
 
 1、讲一下OC的消息机制 objc_msgSend
    OC中的方法调用其实都是转成了objc_msgSend函数调用，给receiver发送一条消息
    objc_msgSend底层有三大阶段 消息发送 动态方法解析 消息转发
 
 2、消息转发流程
 
 3、什么是Runtime,平时项目中有用过吗
    OC是一门动态性比较强的编程语言，允许很多操作推迟到程序运行时再进行，
    OC的动态性就是有Runtime来支撑和实现的，
    Runtime是一套C语言API，封装 了很多动态性相关的函数，
    平时编写的OC代码，底层都是转换成了Runtime API进行调用
 
    利用关联对象给分类添加属性
    遍历类的所有成员变量（访问私有成员变量，字典转模型，归档解档）
    交换方法实现（交换系统的方法--监听所有按钮点击事件、拦截数组和字典赋值nil、适配字体大小）
    利用消息转发机制解决方法找不到的问题
 
 
 */


#pragma mark - RunLoop============================

- (void)runLoopCode {
    [NSRunLoop currentRunLoop];
    CFRunLoopGetCurrent();
    
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer new] forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] addTimer:[NSTimer new] forMode:UITrackingRunLoopMode];
    [[NSRunLoop currentRunLoop] addTimer:[NSTimer new] forMode:NSRunLoopCommonModes];
    
    
    [[NSRunLoop currentRunLoop] addPort:[NSPort new] forMode:NSDefaultRunLoopMode];
//    [[NSRunLoop currentRunLoop] run];//是无法停止的，专门开启永不销毁的线程
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate distantFuture]];
    
    CFRunLoopStop(CFRunLoopGetCurrent());
}

/*
 
 运行循环-在程序运行过程中循环做一些事情
    定时器、PerformSelector、GCD、事件响应、手势识别、界面刷新、网络请求、AutoreleasePool
 
 RunLoop内部逻辑
    进入RunLoop-即将处理Timers-即将处理Sources-处理blocks-处理Sources0-处理Sources1-开始休眠-结束休眠
    -处理Timer\GCD\Source1-处理Blocks-返回第2步或者退出Loop-退出Loop
 
 RunLoop和线程的关系
    一对一的关系，线程默认没有创建RunLoop，在第一次获取RunLoop时创建
 
 timer与runLoop的关系
    timer运行在runLoop中，runLoop控制timer什么时候执行
 
 runLoop是怎么响应用户操作的，具体流程是怎么样的
    由Sources1捕捉响应事件，交给Sources0去处理
 
 runLoop的几种状态
    即将进入Loop-即将处理Timer-即将处理Source-即将进入休眠-从休眠中唤醒-即将退出Loop
 
 runLoop的mode的作用
    将不同模式下的source、timers、observers隔离开来，只运行一种模式下的source、timers、observers，在某种模式下就会比较流畅
 
 项目中使用RunLoop
     控制线程生命周期（线程保活）
     
     解决NSTimer在滑动时停止工作的问题
        [[NSRunLoop currentRunLoop] addTimer:[NSTimer new] forMode:NSRunLoopCommonModes];
     
     监控设备卡顿
     
     性能优化
 
 */

#pragma mark - 多线程============================

- (void)asyncCode {
    dispatch_queue_t queue = dispatch_queue_create("myqueue", DISPATCH_QUEUE_SERIAL);
    dispatch_async(queue, ^{
        
    });
    
    
    //队列组 执行完前两个再执行第三个
    dispatch_group_t group = dispatch_group_create();
    dispatch_queue_t queue1 = dispatch_queue_create("myqueue1", DISPATCH_QUEUE_CONCURRENT);
    
    dispatch_group_async(group, queue1, ^{
        
    });
    dispatch_group_async(group, queue1, ^{
        
    });
    dispatch_group_notify(group, queue, ^{
        
    });
    
}

/*
 dispatch_sync和dispatch_async用来控制是否开启新的线程
 队列的类型，决定了任务的执行方式
 
 dispatch_sync立马在当前线程同步执行任务
 dispatch_async不要求立马在当前线程同步执行任务
 
 死锁
    使用sync函数往当前串行队列中添加任务，会卡住当前的串行队列（产生死锁）
 
 线程同步（加锁）
    1、OSSpinLock 自旋锁 忙等（一直占用CPU）不再安全，可能出现优先级反转
    2、os_unfair_lock 互斥锁 休眠
    3、pthread_mutex 互斥锁 休眠  递归锁，允许同一个线程重复加锁
    4、NSLock 对mutex普通锁的封装
    5、NSRecursiveLock 对mutex递归锁的封装
    6、NSCondition 对mutex和cond的封装  条件锁
    7、NSConditionLock 对NSCondition的进一步封装，可以设置条件值
    8、dispatch_queue GCD的串行队列
    9、dispatch_semaphore 信号量 初始值可以控制并发访问的最大数量
    10、@synchronized 对mutex递归锁的封装
 
 自旋锁、互斥锁比较
    自旋锁
        预计线程等待锁的时间很短
        临界区经常被调用，但竞争情况很少发生
        CPU资源不紧张 多核
    互斥锁
        预计线程等待锁的时间较长
        单核处理器
        临界区有IO操作
        临界区代码复杂或者循环量大
        临界区竞争非常激烈
 
 读写安全（多读单写）
    pthread_rwlock 读写锁
    dispatch_barrier_async 异步栅栏调用  必须是自己创建的并发队列
    
 
 */


#pragma mark - 内存管理============================

/*
 NSString使用copy修饰符
    保证NSString是不可变对象 防止赋值可变字符串时原字符串修改引起当前字符串改变
 
 CADisplayLink NSTimer会对target产生强引用
    使用block不用target
    使用中间变量弱引用target、使用消息转发机制将定时器调用转发给target
    NSProxy作为中间变量 直接进行消息转发，效率高
 
 NSTimer基于RunLoop，不准时，GCD基于内核，准时
 
 
 内存布局
    代码段 数据段 堆 栈
 
 Tagged Pointer
    优化小对象的存储，将数据添加直接存储到指针中
 
 copy
    产生不可变副本 不可变传不可变是浅拷贝，其他都是深拷贝
 mutableCopy
    产生可变副本 都是深拷贝
 
 autorelease什么时候释放
    可能是在某次RunLoop循环中，RunLoop休眠之前调用了release

 */


#pragma mark - 性能优化============================

/*
 
 卡顿优化
    CPU角度
        使用轻量级对象，CALayer替代UIView
        不要频繁修改UIView布局属性
        控制线程并发数量
        耗事操作放到子线程，文字尺寸计算，图片提前绘制
    GPU角度
        控制图片尺寸
        减少视图数量和层级
        减少透明的视图
        避免出现离屏渲染 (光栅化、遮罩、阴影、圆角使用绘制裁剪)
 
 卡顿检测
    使用Runloop监控状态 从结束休眠到处理source0所花费的时间
 
 耗电优化
    尽可能降低CPU、GPU功耗
    少用定时器
    优化I/O操作
    网络优化
    定位优化
 
 网络优化
    压缩网络数据
    多次请求结果相同时使用缓存
    发起网络请求之前先判断网络是否可用
    设置超时时间，让用户可以取消速度很慢的网络请求
    批量传输，一次性多下载一些数据
 
 启动优化
    dyld 动态连接器 加载可执行文件和依赖的动态库
    runtime 解析可执行文件，调用类和分类的+load方法
    main
 
 */


#pragma mark - 架构设计============================

/*
 
 
 
 
 讲讲MVC、MMVM、MVP，以及你在项目中是怎么写的
     MVC Apple：View、Model可以重复利用 Controller的代码过于臃肿
     MVC 变种：对Controller进行瘦身 View依赖于Model
     MVP Presenter
     MVVM 数据绑定
 
 三层架构
    界面层  业务层  数据层（网络层、本地数据层）
 
 你自己用过哪些设计模式
    工厂模式
 
 一般开始做一个项目，你的架构是如何思考的
    三层架构、四层架构
 */


#pragma mark - 面试

/*
    drawReact调用时机
    HTTPDNS怎么全局替换域名
    webSocket内部实现
    HTTP怎么实现长连接
    WKWebView使用难点
    检测卡顿除了RunLoop还有什么方法
    
    组件化
    crash符号表
    路由
    NSTimer复用
    GCD挂起后pop掉页面对APP有没有影响
    数据加密
    SDWebImage滑动闪退
    Masonry
 
 
 
    组件化
    路由
    crash
    数据加密
    
 
 
 */


@end
