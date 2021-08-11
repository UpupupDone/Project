//
//  NSObject+SwizzleMethod.h
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

FOUNDATION_EXTERN BOOL QC_OverrideImplementation(Class cls, SEL sel, id(^implBlock)(Class originCls, SEL originSel, IMP originImp));

@interface NSObject (SwizzleMethod)

+ (BOOL)qc_swizzleInstanceMethod:(SEL)originalSel with:(SEL)swizzleSel;
+ (BOOL)qc_swizzleClassMethod:(SEL)originalSel with:(SEL)swizzleSel;

+ (BOOL)qc_swizzleAddMethod:(SEL)addSel fromClass:(Class)implCls method:(SEL)implSel;

+ (void)qc_hookMapPrint;

@end

NS_ASSUME_NONNULL_END
