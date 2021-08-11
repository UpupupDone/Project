//
//  KVCViewController.m
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import "KVCViewController.h"
#import "KVCPerson.h"
#import "NSObject+QCKVC.h"
#import <objc/message.h>

@interface KVCViewController ()

@property (nonatomic, strong) KVCPerson *person;

@end

@implementation KVCViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
//    KVCPerson *person = [KVCPerson new];
//    _person = person;
    
    // KVC 设值
//    [_person setValue:@"11111" forKey:@"key"];
    
    // KVC 取值
//    NSObject *obj = [_person valueForKey:@"key"];
//    NSLog(@"%@", obj);
//    [_person desc];
    
    
    KVCPerson *person1 = [KVCPerson new];
    person1.dog.age = 1;

    KVCPerson *person2 = [KVCPerson new];
    person2.dog.age = 1;

    KVCPerson *person3 = [KVCPerson new];
    person3.dog.age = 3;

    KVCPerson *person4 = [KVCPerson new];
    person4.dog.age = 4;

    NSArray *arr = @[person1, person2, person3, person4];
    NSNumber *sum = [arr valueForKeyPath:@"@sum.dog.age"];
    NSLog(@"sum:%.f", sum.floatValue);
    NSNumber *avg = [arr valueForKeyPath:@"@avg.dog.age"];
    NSLog(@"avg:%.f", avg.floatValue);
    NSNumber *count = [arr valueForKeyPath:@"@count"];
    NSLog(@"count:%.f", count.floatValue);
    NSNumber *min = [arr valueForKeyPath:@"@min.dog.age"];
    NSLog(@"min:%.f", min.floatValue);
    NSNumber *max = [arr valueForKeyPath:@"@max.dog.age"];
    NSLog(@"max:%.f", max.floatValue);
    
    NSArray *distinctPayees = [arr valueForKeyPath:@"@distinctUnionOfObjects.dog.age"];
    NSLog(@"%@", distinctPayees);
    
    NSLog(@"distinctUnionOfObjects");
    NSArray *arrDistinct = [arr valueForKeyPath:@"@distinctUnionOfObjects.dog.age"];
    for (NSNumber *age in arrDistinct) {
        NSLog(@"%.f", age.floatValue);
    }
    NSLog(@"unionOfObjects");
    NSArray *arrUnion = [arr valueForKeyPath:@"@unionOfObjects.dog.age"];
    for (NSNumber *age in arrUnion) {
        NSLog(@"%.f", age.floatValue);
    }
    
//    NSArray *collectedDistinctPayees = [arr valueForKeyPath:@"@distinctUnionOfArrays.dog.age"];
//    NSLog(@"%@", collectedDistinctPayees);
//    
//    NSArray *collectedPayees = [arr valueForKeyPath:@"@unionOfArrays.dog.age"];
//    NSLog(@"%@", collectedPayees);
    
//    NSArray *distinctUnionOfSets = [arr valueForKeyPath:@"@distinctUnionOfSets.dog.age"];
//    NSLog(@"%@", distinctUnionOfSets);

    

}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static NSInteger i = 0;
    NSString *name = [NSString stringWithFormat:@"%ld", (long)i++];
   
}

- (void)dealloc
{
//    [_person removeObserver:self forKeyPath:@"arr"];
}

@end
