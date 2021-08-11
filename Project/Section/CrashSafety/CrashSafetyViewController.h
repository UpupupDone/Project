//
//  CrashSafetyViewController.h
//  Project
//
//  Created by MELO on 2021/3/12.
//

#import <UIKit/UIKit.h>

@interface KVCCrashObject : NSObject

@property (nonatomic, copy) NSString *name;
@property (nonatomic, assign) NSInteger age;

@end

NS_ASSUME_NONNULL_BEGIN

@interface CrashSafetyViewController : UIViewController

@end

NS_ASSUME_NONNULL_END
