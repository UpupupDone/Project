//
//  ViewController.m
//  Project
//
//  Created by MELO on 2021/3/10.
//

#import "ViewController.h"
#import "QCSymbolTracker.h"
#import "CodeCoverageTool.h"

@interface ViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSDictionary *dic;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.tableView];
    
    test();
    NSString *filePath = [NSTemporaryDirectory() stringByAppendingPathComponent:@"Project.order"];
    [QCSymbolTracker exportSymbolsWithFilePath:filePath];
    
    NSNumber *number = @1;
    NSLog(@"%p", number);
    
    
    number = [NSNumber numberWithUnsignedLongLong:1111111111111111111];
    NSLog(@"%p", number);
    
    NSString *str = @"1";
    NSLog(@"%@%p", [str class], str);
    
    str = @"fdjvbfdjkvlvnfdbcjhdvhcvxvhchjvbjkxzbcjhdfvjkzcvbbhvdihfvh";
    NSLog(@"%@%p", [str class], str);
    
    [[CodeCoverageTool sharedManager] flush];

}

void(^block1)(void) = ^(void) {
    
};

void test() {
    block1();
    
}

+ (void)initialize {
    
}

+ (void)load {
    
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    
    
}

- (UITableView *)tableView {
    
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
    }
    return _tableView;
}

- (NSDictionary *)dic {
    
    if (!_dic) {
        _dic = @{@"CCButton": @"CCButtonViewController",
                 @"Factory": @"FactoryViewController",
                 @"GCD": @"GCDViewController",
                 @"MVVM": @"DebugViewController",
                 @"OOM": @"OOMViewController",
                 @"QCEventCalendar": @"QCEventCalendarViewController",
                 @"QCSingleton": @"QCSingletonViewController",
                 @"QCThreadSafeCollection": @"QCThreadSafeCollectionViewController",
                 @"Realm": @"RealmViewController",
                 @"LRU": @"LRUViewController",
                 @"CrashSafety": @"CrashSafetyViewController",
                 @"WebP": @"WebPViewController",
                 @"KVO": @"KVOViewController",
                 @"KVC": @"KVCViewController",
                 @"CocoaHTTPServer": @"CocoaHTTPServerViewController"
        };
    }
    return _dic;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.dic.allKeys.count;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    cell.textLabel.text = self.dic.allKeys[indexPath.row];
    cell.textLabel.textColor = [UIColor blackColor];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSString *key = cell.textLabel.text;
    Class class = NSClassFromString(self.dic[key]);
    UIViewController *vc = [class new];
    vc.title = key;
    [self.navigationController pushViewController:vc animated:YES];
}

@end
