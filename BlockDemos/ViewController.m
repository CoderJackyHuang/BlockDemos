//
//  ViewController.m
//  BlockDemos
//
//  Created by huangyibiao on 16/3/25.
//  Copyright © 2016年 huangyibiao. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
  [super viewDidLoad];
  
  [self session1Demo];
}

- (void)session1Demo {
  int multiplier = 7;
  int (^myBlock)(int) = ^(int num) {
    return num * multiplier;
  };
  
  printf("%d", myBlock(3));
  // prints "21"
  
  char *names[4] = {"henishuo.com", "weibo.com/huangyibiao520", "GITHUB", "CSDN"};
  qsort_b(names, 4, sizeof(char *), ^int(const void *name1, const void *name2) {
    char *lhs = *(char **)name1;
    char *rhs = *(char **)name2;
    
    return strcmp(lhs, rhs);
  });
  for (NSUInteger i = 0; i < 4; ++i) {
    NSLog(@"%s", names[i]);
  }
  
  
  NSArray *stringsArray = @[ @"string 1",
                             @"String 21",
                             @"string 12",
                             @"String 11",
                             @"String 02" ];
  
  NSStringCompareOptions comparisonOptions = NSCaseInsensitiveSearch
  | NSNumericSearch
  | NSWidthInsensitiveSearch
  | NSForcedOrderingSearch;
  
  NSLocale *currentLocale = [NSLocale currentLocale];
  
  NSArray *finderSortArray = [stringsArray sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
    NSRange string1Range = NSMakeRange(0, [obj1 length]);
    return [obj1 compare:obj2 options:comparisonOptions range:string1Range locale:currentLocale];
    
  }];
  
  NSLog(@"finderSortArray: %@", finderSortArray);
  
  __block int count = 0;
  void (^TestBlock)(BOOL) = ^(BOOL isOk) {
    if (isOk) {
      count++;
    }
  };

  TestBlock(YES);
  NSLog(@"count = %d", count);
  
  typedef void (^HYBResponseSuccessBlock)(id response);
  typedef void (^HYBResponseFailureBlock)(NSError *error);
  typedef void (^HYBStatusBlock)(BOOL status);
 
  HYBStatusBlock block = [self testStatus];
  block(YES);
}

typedef void (^HYBStatusBlock)(BOOL);
- (HYBStatusBlock)testStatus {
  HYBStatusBlock block = ^(BOOL status) {
    NSLog(@"status is %d", status);
  };
  
  return [block copy];
}

@end
