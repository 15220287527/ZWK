//
//  LinkedList.h
//  Interview
//
//  Created by 张伟康 on 2020/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Node : NSObject

@property (nonatomic, assign) int val;
@property (nonatomic, strong) Node *next;

@end

@interface LinkedList : NSObject

@end

NS_ASSUME_NONNULL_END
