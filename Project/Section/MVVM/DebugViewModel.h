//
//  DebugViewModel.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "QCBaseViewModel.h"

NS_ASSUME_NONNULL_BEGIN

@interface DebugViewModel : QCBaseViewModel

@property (nonatomic, copy, readonly) NSString *title;
@property (nonatomic, copy, readonly) NSArray *dataSource;

@end

NS_ASSUME_NONNULL_END
