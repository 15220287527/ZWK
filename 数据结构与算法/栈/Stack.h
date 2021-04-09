//
//  Stack.h
//  Interview
//
//  Created by 张伟康 on 2020/9/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Stack : NSObject

- (void)clear;
- (void)size;
- (BOOL)isEmpty;
- (void)push:(id)element;
- (id)pop;
- (id)top;

@end

NS_ASSUME_NONNULL_END
