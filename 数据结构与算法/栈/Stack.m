//
//  Stack.m
//  Interview
//
//  Created by 张伟康 on 2020/9/22.
//

#import "Stack.h"

@interface Stack ()

@property (nonatomic, strong) NSDictionary *map;

@property (nonatomic, strong) Stack *inStack;
@property (nonatomic, strong) Stack *outStack;

@end

@implementation Stack

- (instancetype)init
{
    self = [super init];
    if (self) {
        _map = @{@"(" : @")",
                 @"[" : @"]",
                 @"{" : @"}",
        };
    }
    return self;
}

#pragma mark - 有效的括号

- (BOOL)isValid1:(NSString *)s {
    Stack *stack = [[Stack alloc] init];
    NSInteger len = s.length;
    for (int i = 0; i < len; i++) {
        NSString *c = [s substringWithRange:NSMakeRange(i, 1)];
        if ([c isEqualToString:@"("] || [c isEqualToString:@"["] || [c isEqualToString:@"{"]) {
            [stack push:c];
        } else {
            if (stack.isEmpty) return NO;
            
            NSString *left = [stack pop];
            if ([left isEqualToString:@"("] && ![c isEqualToString:@")"]) return NO;
            if ([left isEqualToString:@"["] && ![c isEqualToString:@"]"]) return NO;
            if ([left isEqualToString:@"{"] && ![c isEqualToString:@"}"]) return NO;
        }
    }
    
    return stack.isEmpty;
}

- (BOOL)isValid2:(NSString *)s {
    while ([s containsString:@"()"]
            || [s containsString:@"[]"]
            || [s containsString:@"{}"]) {
        s = [s stringByReplacingOccurrencesOfString:@"()" withString:@""];
        s = [s stringByReplacingOccurrencesOfString:@"[]" withString:@""];
        s = [s stringByReplacingOccurrencesOfString:@"{}" withString:@""];
    }
    return !s.length;
}

- (BOOL)isValid3:(NSString *)s {
    Stack *stack = [[Stack alloc] init];
    NSInteger len = s.length;
    for (int i = 0; i < len; i++) {
        NSString *c = [s substringWithRange:NSMakeRange(i, 1)];
        if ([_map.allKeys containsObject:c]) {
            [stack push:c];
        } else {
            if (stack.isEmpty) return NO;
            
            if (c != _map[[stack pop]]) return NO;
        }
    }
    
    return stack.isEmpty;
}

#pragma mark - 栈实现队列


/*
  
 */
- (void)checkOutStack {
    if (_outStack.isEmpty) {
        while (!_inStack.isEmpty) {
            [_outStack push:[_inStack pop]];
        }
    }
    
    //入队
//    [_inStack push:@""];
    
    //出队
//    [self checkOutStack];
//    [_outStack pop];
}




































@end
