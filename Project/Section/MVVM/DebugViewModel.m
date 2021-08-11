//
//  DebugViewModel.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "DebugViewModel.h"

@interface DebugViewModel ()

@property (nonatomic, strong, readwrite) NSString *title;

@end

@implementation DebugViewModel

- (instancetype)init {
    self = [super init];
    if (self) {
        _dataSource = @[@"OC", @"SWift", @"Flutter", @"ReactNative", @"weex", @"H5"];
        _title = _dataSource[1];
    }
    return self;
}

- (void)refresh {

    self.title = _dataSource[[self getRandomNumber:0 to:4]];
}

- (void)dealloc {
    NSLog(@"DebugViewModel dealloc");
}

- (NSInteger)getRandomNumber:(int)from to:(int)to {

    return (NSInteger)(from + (arc4random() % (to - from + 1)));
}

@end
