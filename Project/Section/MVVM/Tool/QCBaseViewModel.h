//
//  QCBaseViewModel.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "QCViewModelProtocol.h"
#import "NSObject+Bind.h"

NS_ASSUME_NONNULL_BEGIN

@interface QCBaseViewModel : NSObject<QCViewModelProtocol>

- (void)refresh;

@end

NS_ASSUME_NONNULL_END
