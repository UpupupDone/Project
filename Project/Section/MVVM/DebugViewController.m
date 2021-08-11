//
//  DebugViewController.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "DebugViewController.h"

@interface DebugViewController ()

@property (nonatomic, strong) UILabel *label;

@end

@implementation DebugViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.view.backgroundColor = [UIColor whiteColor];
    
    [self.view addSubview:self.label];
    self.label.frame = CGRectMake(0, 0, 375, 50);
    self.label.center = self.view.center;
    
}

- (void)bind:(DebugViewModel *)viewModel {

    [viewModel bind:@"title" to:self.label at:@"text"];
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.viewModel refresh];
}

- (void)dealloc {
    NSLog(@"%@ dealloc", [self class]);
}

- (UILabel *)label {
    if (!_label) {
        _label = [UILabel new];
        _label.textColor = [UIColor redColor];
        _label.font = [UIFont systemFontOfSize:80];
        _label.textAlignment = NSTextAlignmentCenter;
    }
    return _label;
}

@end
