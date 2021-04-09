//
//  LinkedList.m
//  Interview
//
//  Created by 张伟康 on 2020/9/22.
//

#import "LinkedList.h"

@implementation LinkedList

#pragma mark - 环形链表

- (BOOL)hasCycle:(Node *)head {
    if (head == nil || head.next == nil) return NO;
    
    Node *slow = head;
    Node *fast = head.next;
    while (fast != nil && fast.next != nil) {
        slow = slow.next;
        fast = fast.next.next;
        
        if (slow == fast) return YES;
    }
    
    return false;
}

#pragma mark - 删除节点

- (void)deleteNode:(Node *)node {
    node.val = node.next.val;
    node.next = node.next.next;
}

#pragma mark - 反转链表

/// 递归
- (Node *)reverseList:(Node *)head {
    if (head == nil || head.next == nil) return head;
    
    Node *newHead = [self reverseList:head.next];
    head.next.next = head;
    head.next = nil;
    return newHead;
}

/// 非递归
- (Node *)reverseList2:(Node *)head {
    if (head == nil || head.next == nil) return head;
    
    Node *newHead = nil;
    while (head != nil) {
        Node *tmp = head.next;
        head.next = newHead;
        newHead = head;
        head = tmp;
    }
    return newHead;
}






























@end
