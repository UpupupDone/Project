//
//  main.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "QCSymbolTracker.h"

int main(int argc, char * argv[]) {
    NSString * appDelegateClassName;
    @autoreleasepool {
        // Setup code that might create autoreleased objects goes here.
        appDelegateClassName = NSStringFromClass([AppDelegate class]);
//        NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Project.order"];
//        [QCSymbolTracker exportSymbolsWithFilePath:filePath];

    }
    return UIApplicationMain(argc, argv, nil, appDelegateClassName);
}

//int sum(int a,int b){
//    int c = a + b;
//    return c;
//}
