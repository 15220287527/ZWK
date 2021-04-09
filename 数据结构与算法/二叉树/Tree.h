//
//  Tree.h
//  Interview
//
//  Created by 张伟康 on 2020/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Queue : NSObject

- (void)clear;
- (void)size;
- (BOOL)isEmpty;
- (void)offer:(id)element;
- (id)poll;

@end

@interface TreeNode : NSObject

@property (nonatomic, assign) int val;
@property (nonatomic, strong) TreeNode *left;
@property (nonatomic, strong) TreeNode *right;
@property (nonatomic, strong) TreeNode *parent;

- (BOOL)isLeaf;

@end

@interface Tree : NSObject

@end

NS_ASSUME_NONNULL_END
