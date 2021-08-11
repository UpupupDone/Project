//
//  QCBaseViewController.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import <UIKit/UIKit.h>
#import "QCViewBinder.h"
#import "QCViewModelProtocol.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCBaseViewController<ViewModelType: id<QCViewModelProtocol>> : UIViewController

@property (nonatomic, strong) ViewModelType viewModel;

@end

NS_ASSUME_NONNULL_END
