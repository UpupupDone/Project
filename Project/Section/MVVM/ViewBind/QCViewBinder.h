//
//  QCViewBinder.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import <Foundation/Foundation.h>
#import "QCViewModelProtocol.h"

@protocol QCViewBinder<NSObject>

- (void)bind:(id<QCViewModelProtocol>)viewModel;

@end
