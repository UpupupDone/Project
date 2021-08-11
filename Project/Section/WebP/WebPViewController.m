//
//  WebPViewController.m
//  Project
//
//  Created by MELO on 2021/3/14.
//

#import "WebPViewController.h"
#import <YYKit/YYKit.h>

/// gif 转 webp, 文档https://developers.google.com/speed/webp/docs/gif2webp
@interface WebPViewController ()

@property (nonatomic, strong) YYAnimatedImageView *gifView;
@property (nonatomic, strong) YYAnimatedImageView *webPView;


@end

@implementation WebPViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    // Do any additional setup after loading the view.
    
    self.gifView = [YYAnimatedImageView new];
    self.gifView.frame = CGRectMake(0, 0, 300, 300);
    [self.view addSubview:self.gifView];
    self.gifView.center = CGPointMake(self.view.centerX, self.view.centerY - 200);
    [self.gifView setImageWithURL:[NSURL fileURLWithPath:@"/Users/melo/Desktop/ojbk/Demo/Project/Project/Section/WebP/input_file.gif"] placeholder:nil options:YYWebImageOptionProgressive completion:^(UIImage * _Nullable image, NSURL * _Nonnull url, YYWebImageFromType from, YYWebImageStage stage, NSError * _Nullable error) {
        
    }];
   
    NSData *gifData = [NSData dataWithContentsOfFile:@"/Users/melo/Desktop/ojbk/Demo/Project/Project/Section/WebP/input_file.gif"];
    NSInteger gifSize = gifData.length / 1024.0;
    UILabel *gifLab = [UILabel new];
    gifLab.text = [NSString stringWithFormat: @"gif 大小%ld KB", (long)gifSize];
    gifLab.textAlignment = NSTextAlignmentCenter;
    gifLab.frame = CGRectMake(0, self.gifView.centerY + 150 + 20, self.view.width, 20);
    [self.view addSubview:gifLab];
    
    self.webPView = [YYAnimatedImageView new];
    self.webPView.frame = CGRectMake(0, 0, 300, 300);
    [self.view addSubview:self.webPView];
    self.webPView.center = CGPointMake(self.view.centerX, self.view.centerY + 200);
    self.webPView.imageURL = [NSURL fileURLWithPath:@"/Users/melo/Desktop/ojbk/Demo/Project/Project/Section/WebP/output_file.webp"];
    
    NSData *webPData = [NSData dataWithContentsOfFile:@"/Users/melo/Desktop/ojbk/Demo/Project/Project/Section/WebP/output_file.webp"];
    NSInteger webPSize = webPData.length / 1024.0;
    UILabel *webPLab = [UILabel new];
    webPLab.text = [NSString stringWithFormat: @"webP 大小%ld KB", (long)webPSize];
    webPLab.textAlignment = NSTextAlignmentCenter;
    webPLab.frame = CGRectMake(0, self.webPView.centerY + 150 + 20, self.view.width, 20);
    [self.view addSubview:webPLab];
}

@end
