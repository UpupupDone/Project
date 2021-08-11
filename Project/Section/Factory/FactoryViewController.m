//
//  FactoryViewController.m
//  Factory
//
//  Created by MELO on 2021/2/28.
//

#import "FactoryViewController.h"
#import "BaseModel.h"
#import "BaseModelCell.h"
#import "SimpleFactory.h"
#import "AbstractFactory.h"
#import "TextAndImageAbstractFactory.h"

@interface FactoryViewController ()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSMutableArray *dataSource;

@end

@implementation FactoryViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];

    [self initWithData];
    [self.view addSubview:self.tableView];
    [self registerCell];
}


- (void)initWithData {
    
    NSArray *dataArr = @[
    @{@"style": @"text", @"title": @"我是文本✍️✍️✍️✍️✍️✍️✍️✍️✍️", @"color": @"redColor"},
    @{@"style": @"image", @"title": @"我是视频📷📷📷📷📷📷📷📷📷", @"color": @"grayColor"},
    @{@"style": @"music", @"title": @"我是音乐🎵🎵🎵🎵🎵🎵🎵🎵🎵", @"color": @"blueColor"},
    @{@"style": @"video", @"title": @"我是视频🎬🎬🎬🎬🎬🎬🎬🎬🎬", @"color": @"orangeColor", @"other": @"cc"}];
    
    AbstractFactory *textAndImageFactory = [AbstractFactory factoryWithType:AbstractFactoryModelTextAndImage];
    AbstractFactory *musicAndVideoFactory = [AbstractFactory factoryWithType:AbstractFactoryModelMusicAndVideo];

    BaseModel *model = nil;
    for (NSDictionary *dic in dataArr) {
        if ([dic[@"style"] isEqualToString:@"text"] || [dic[@"style"] isEqualToString:@"image"]) {
             model = [textAndImageFactory newModelWithDic:dic];
        } else {
            model = [musicAndVideoFactory newModelWithDic:dic];
        }
//        model = [SimpleFactory newModelWithDic:dic];
        [self.dataSource addObject:model];
    }
}

- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
        _tableView.dataSource = self;
        _tableView.delegate = self;
        _tableView.estimatedRowHeight = 50;
    }
    return _tableView;
}

- (NSMutableArray *)dataSource {
    if (!_dataSource) {
        _dataSource = [NSMutableArray array];
    }
    return _dataSource;
}

- (void)registerCell {
    
    [_tableView registerClass:NSClassFromString(@"BaseModelCell") forCellReuseIdentifier:@"BaseModelCell"];
    [_tableView registerClass:NSClassFromString(@"TextModelCell") forCellReuseIdentifier:@"TextModelCell"];
    [_tableView registerClass:NSClassFromString(@"TextModelCell") forCellReuseIdentifier:@"ImageModelCell"];
    [_tableView registerClass:NSClassFromString(@"MusicModelCell") forCellReuseIdentifier:@"MusicModelCell"];
    [_tableView registerClass:NSClassFromString(@"VideoModelCell") forCellReuseIdentifier:@"VideoModelCell"];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    return 50;
}

- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    
    BaseModel *model = self.dataSource[indexPath.row];    
    NSString *cellName = [NSString stringWithFormat:@"%sCell", object_getClassName(model)];
    BaseModelCell *cell = [tableView dequeueReusableCellWithIdentifier:cellName forIndexPath:indexPath];
    [cell setModel:model];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.dataSource.count ? : 4;
}

@end
