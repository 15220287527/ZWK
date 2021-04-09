//
//  Tree.m
//  Interview
//
//  Created by 张伟康 on 2020/9/22.
//

#import "Tree.h"
#import "Stack.h"

@implementation Tree

#pragma mark - 翻转二叉树

/// 递归
- (TreeNode *)invertTree1:(TreeNode *)root {
    if (root == nil) return root;
    
    TreeNode *tmp = root.left;
    root.left = root.right;
    root.right = tmp;
    
    [self invertTree1:root.left];
    [self invertTree1:root.right];
    
    return root;
}

/// 非递归
- (TreeNode *)invertTree2:(TreeNode *)root {
    if (root == nil) return root;
    
    Queue *queue = [Queue new];
    [queue offer:root];
    
    while (!queue.isEmpty) {
        TreeNode *node = [queue poll];
        TreeNode *tmp = node.left;
        node.left = node.right;
        node.right = tmp;
        
        if (node.left != nil) {
            [queue offer:node.left];
        }
        
        if (node.right != nil) {
            [queue offer:node.right];
        }
    }
    
    return root;
}


#pragma mark - 遍历二叉树

///前序递归
- (void)preorder:(TreeNode *)node {
    if (node == nil) return;
    
    NSLog(@"%d", node.val);
    [self preorder:node.left];
    [self preorder:node.right];
}

///前序非递归
- (void)preorder1:(TreeNode *)node {
    if (node == nil) return;
    Stack *stack = [Stack new];
    [stack push:node];

    while (!stack.isEmpty) {
        TreeNode *node = [stack pop];
        NSLog(@"%d", node.val);
        
        if (node.right != nil) {
            [stack push:node.right];
        }
        
        if (node.left != nil) {
            [stack push:node.left];
        }
    }
}

- (void)preorder2:(TreeNode *)node {
    if (node == nil) return;
    Stack *stack = [Stack new];

    while (YES) {
        if (node != nil) {
            NSLog(@"%d", node.val);
            if (node.right != nil) {
                [stack push:node.right];
            }
            
            node = node.left;
        } else if (stack.isEmpty) {
            return;
        } else {
            node = [stack pop];
        }
    }
}

///中序递归
- (void)inorder:(TreeNode *)node {
    if (node == nil) return;
    
    [self inorder:node.left];
    NSLog(@"%d", node.val);
    [self inorder:node.right];
}

///中序非递归
- (void)inorder1:(TreeNode *)node {
    if (node == nil) return;
    Stack *stack = [Stack new];

    while (YES) {
        if (node != nil) {
            [stack push:node];
            node = node.left;
        } else if (stack.isEmpty) {
            return;
        } else {
            node = [stack pop];
            NSLog(@"%d", node.val);
            node = node.right;
        }
    }
    
}

///后序递归
- (void)postorder:(TreeNode *)node {
    if (node == nil) return;
    
    [self postorder:node.left];
    [self postorder:node.right];
    NSLog(@"%d", node.val);
}

///后序非递归
- (void)postorder1:(TreeNode *)node {
    if (node == nil) return;
    
    TreeNode *prev = nil;
    Stack *stack = [Stack new];
    [stack push:node];
    while (!stack.isEmpty) {
        TreeNode *top = [stack top];
        
        if (top.isLeaf || (prev != nil && prev.parent == top)) {
            prev = [stack pop];
            NSLog(@"%d", prev.val);
        } else {
            if (top.right != nil) {
                [stack push:top.right];
            }
            if (top.left != nil) {
                [stack push:top.left];
            }
        }
    }
}

///层序
- (void)leverOrder:(TreeNode *)node {
    if (node == nil) return;
    
    Queue *queue = [Queue new];
    [queue offer:node];
    
    while (!queue.isEmpty) {
        TreeNode *node = [queue poll];
        NSLog(@"%d", node.val);
        
        if (node.left != nil) {
            [queue offer:node.left];
        }
        
        if (node.right != nil) {
            [queue offer:node.right];
        }
    }
}


























@end
