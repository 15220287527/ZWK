//
//  Sort.m
//  Interview
//
//  Created by 张伟康 on 2020/9/18.
//

#import "Sort.h"

@interface Sort ()

@property (nonatomic, strong) NSMutableArray *array;

@end

@implementation Sort

#pragma mark - 冒泡排序

- (void)bubbleSort1 {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        for (NSInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin - 1 :begin] > 0) {
                [self swap:begin - 1 :begin];
            }
        }
    }
}

- (void)bubbleSort2 {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        BOOL sorted = YES;
        for (NSInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin - 1 :begin] > 0) {
                [self swap:begin - 1 :begin];
                sorted = NO;
            }
        }
        if (sorted) break;
    }
}

- (void)bubbleSort3 {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        NSInteger sortedIndex = 1;
        for (NSInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin - 1 :begin] > 0) {
                [self swap:begin - 1 :begin];
                sortedIndex = begin;
            }
        }
        end = sortedIndex;
    }
}

#pragma mark - 选择排序

- (void)selectionSort {
    for (NSInteger end = _array.count - 1; end > 0; end--) {
        NSInteger max = 0;
        for (NSInteger begin = 1; begin <= end; begin++) {
            if ([self cmp:begin :max] > 0) {
                max = begin;
            }
        }
        [self swap:max :end];
    }
}

#pragma mark - 插入排序

- (void)insertionSort1 {
    for (NSInteger begin = 1; begin < _array.count; begin++) {
        NSInteger cur = begin;
        while (cur > 0 && [self cmp:cur - 1 :cur] > 0) {
            [self swap:cur - 1 :cur];
            cur--;
        }
    }
}

- (void)insertionSort2 {
    for (NSInteger begin = 1; begin < _array.count; begin++) {
        NSInteger cur = begin;
        id v = _array[begin];
        while (cur > 0 && [self cmp:cur - 1 :cur] > 0) {
            _array[cur] = _array[cur - 1];
            cur--;
        }
        _array[cur] = v;
    }
}

- (void)insertionSort3 {
    for (NSInteger begin = 1; begin < _array.count; begin++) {
        [self inset:begin :[self search:begin]];
    }
}

- (void)inset:(NSInteger)source :(NSInteger)dest {
    id v = _array[source];
    for (NSInteger i = source; i > dest; i--) {
        _array[i] = _array[i - 1];
    }
    _array[dest] = v;
}

- (NSInteger)search:(NSInteger)index {
    NSInteger begin = 0;
    NSInteger end = index;
    while (begin < end) {
        NSInteger mid = (begin + end) >> 1;
        if ([self cmp:mid :index] > 0) {
            end = mid;
        } else {
            begin = mid + 1;
        }
    }
    return begin;
}

#pragma mark - 快速排序

- (void)quickSort {
    [self quickSort:0 :_array.count];
}

- (void)quickSort:(NSInteger)begin :(NSInteger)end {
    if (end - begin < 2) return;
    
    NSInteger mid = [self pivotIndex:begin :end];
    [self quickSort:begin :mid];
    [self quickSort:mid + 1 :end];
}

- (NSInteger)pivotIndex:(NSInteger)begin :(NSInteger)end {
    
    [self swap:begin :begin + arc4random() % (end - begin)];
    
    id pivot = _array[begin];
    end--;
    
    while (begin < end) {
        while (begin < end) {
            if (_array[end] <= pivot) {
                _array[begin++] = _array[end];
                break;;
            } else {
                end--;
            }
        }
        while (begin < end) {
            if (_array[begin] >= pivot) {
                _array[end--] = _array[begin];
                break;
            } else {
                begin++;
            }
        }
    }
    
    _array[begin] = pivot;
    return begin;
}

#pragma mark - 堆排序

- (void)heapSort {
    NSInteger heapSize = _array.count;
    for (NSInteger i = (heapSize >> 1) - 1; i >= 0; i--) {
        [self siftDown:i :heapSize];
    }
    
    while (heapSize) {
        [self swap:0 :--heapSize];
        
        [self siftDown:0 :heapSize];
    }
}

- (void)siftDown:(NSInteger)index :(NSInteger)heapSize {
    id element = _array[index];
    
    NSInteger half = heapSize >> 1;
    while (index < half) {
        NSInteger childIndex = (index << 1) + 1;
        id child = _array[childIndex];
        
        NSInteger rightIndex = childIndex + 1;
        if (rightIndex < heapSize && _array[rightIndex] > child) {
            child = _array[childIndex = rightIndex];
        }
        
        if (element >= child) break;
        
        _array[index] = child;
        index = childIndex;
    }
    _array[index] = element;
}

#pragma mark - 归并排序

- (void)mergeSort {
    [self mergeSort:0 :_array.count];
}

- (void)mergeSort:(NSInteger)begin :(NSInteger)end {
    if (end - begin < 2) return;
    
    NSInteger mid = (begin + end) >> 1;
    [self mergeSort:begin :mid];
    [self mergeSort:mid :end];
    [self merge:begin :mid :end];
}

- (void)merge:(NSInteger)begin :(NSInteger)mid :(NSInteger)end {
    NSInteger li = 0, le = mid - begin;
    NSInteger ri = mid, re = end;
    NSInteger ai = begin;
    
    NSMutableArray *leftArray = [[NSMutableArray alloc] initWithCapacity:le];
    for (NSInteger i = li; i < le; i++) {
        leftArray[i] = _array[begin + i];
    }
    
    while (li < le) {
        if (ri < re && _array[ri] < leftArray[li]) {
            _array[ai++] = _array[ri++];
        } else {
            _array[ai++] = leftArray[li++];
        }
    }
}

#pragma mark - 希尔排序

- (void)shellSort {
    NSArray *stepSequence = [self shellStepSequence];
    for (NSNumber *number in stepSequence) {
        [self shellSort:number.integerValue];
    }
}

- (void)shellSort:(NSInteger)step {
    for (NSInteger col = 0; col < step; col++) {
        for (NSInteger begin = col + step; begin < _array.count; begin += step) {
            NSInteger cur = begin;
            while (cur > col && _array[cur] < _array[cur - step]) {
                [self swap:cur - step :cur];
                cur -= step;
            }
        }
    }
}

- (NSArray *)shellStepSequence {
    NSMutableArray *stepSequence = [NSMutableArray new];
    NSInteger setp = _array.count;
    while ((setp >> 1) > 0) {
        [stepSequence addObject:[NSNumber numberWithInteger:setp]];
    }
    return stepSequence;
}




















#pragma mark - 比较、交换

- (NSInteger)cmp:(NSInteger)i1 :(NSInteger)i2 {
    return (NSInteger)_array[i1] - (NSInteger)_array[i2];
}

- (void)swap:(NSInteger)i1 :(NSInteger)i2 {
    id tmp = _array[i1];
    _array[i1] = _array[i2];
    _array[i2] = tmp;
}

@end
