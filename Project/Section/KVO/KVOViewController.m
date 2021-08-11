//
//  KVOViewController.m
//  Project
//
//  Created by MELO on 2021/3/24.
//

#import "KVOViewController.h"
#import "KVOPerson.h"
#import "NSObject+QCKVO.h"
#import <objc/message.h>

@interface KVOViewController ()

@property (nonatomic, strong) KVOPerson *person;

@end

@implementation KVOViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    
    KVOPerson *person = [KVOPerson new];
    _person = person;

    // 1、观察person的name属性的变化
//    [_person addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];
//
//    // 2、 观察 person的arr属性的变化, 数组的增删改查
//    [_person addObserver:self forKeyPath:@"arr" options:(NSKeyValueObservingOptionNew) context:nil];
    
    // 3、 观察 person内dog属性anme、age变化
//    [_person addObserver:self forKeyPath:@"dog.name" options:(NSKeyValueObservingOptionNew) context:nil];
//    [_person addObserver:self forKeyPath:@"dog.name" options:(NSKeyValueObservingOptionNew) context:nil];
    [_person addObserver:self forKeyPath:@"dog" options:(NSKeyValueObservingOptionNew) context:nil];
    
    // 4、自定义KVO
//    [_person melo_addObserver:self forKeyPath:@"name" options:(NSKeyValueObservingOptionNew) context:nil];

}

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    NSLog(@"%@", change);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    static NSInteger i = 0;
    NSString *name = [NSString stringWithFormat:@"%ld", (long)i++];
    _person.name = name;
    _person.dog.name = name;
    _person.age = i;
    
    // 通过KVC获取到数组，
    NSMutableArray *arr = [_person mutableArrayValueForKey:@"arr"];
    
    // add 对应 NSKeyValueChange 为 NSKeyValueChangeInsertion, 即：kind 为 2
    [arr addObject:name];
    
    // replace 对应 NSKeyValueChange 为 NSKeyValueChangeReplacement, 即：kind 为 4
    [arr replaceObjectAtIndex:0 withObject:@"1111"];
    
    // remove 对应 NSKeyValueChange 为 NSKeyValueChangeRemoval, 即：kind 为 3
    [arr removeObjectAtIndex:0];
}

- (void)dealloc
{
    [_person removeObserver:self forKeyPath:@"arr"];
}

@end
