//
//  CocoaHTTPServerViewController.m
//  Project
//
//  Created by MELO on 2021/4/1.
//

#import "CocoaHTTPServerViewController.h"
#import <ifaddrs.h>
#import <arpa/inet.h>
#import "HTTPServer.h"
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "MyHTTPConnection.h"

#import "GCDWebServer.h"
#import "GCDWebServerDataResponse.h"
#import "GCDWebServerURLEncodedFormRequest.h"

@interface CocoaHTTPServerViewController ()<GCDWebServerDelegate>
{
    GCDWebServer *_localServer;
}

@property (strong, nonatomic) HTTPServer *httpServer;

@property(nonatomic, assign) BOOL startServer;

@end

@implementation CocoaHTTPServerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //    [self openServer];
    [self startLocalServer];
}

- (void)startLocalServer {
    
    _localServer = [[GCDWebServer alloc] init];
    _localServer.delegate = self;
    //设置监听
    [_localServer addHandlerForMethod:@"OPTIONS"      //跨域请求会先发起该类型的请求
                            pathRegex:@"^/"           //接口正则匹配
                         requestClass:[GCDWebServerURLEncodedFormRequest class]
                         processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
        GCDWebServerDataResponse *response;
        NSLog(@"request %@",request);
        //对请求来源做合法性判断
        //                             NSString *origin = [request.headers objectForKey:@"Origin"];
        //                             NSString *referer = [request.headers objectForKey:@"Referer"];
        //
        //                             if ([origin containsString:@"xxxxxxx"] && [referer containsString:@"yyyyyy"]) {//合法规则跟后台协商
        //                                 //请求合法，继续其他操作
        //                             }else{
        //                                 //请求不合法，返回对应的状态
        //                                 response = [GCDWebServerDataResponse responseWithText:@"failure"];
        //                             }
        
        //响应
        response = [GCDWebServerDataResponse responseWithStatusCode:200];
        //响应头设置，跨域请求需要设置，只允许设置的域名或者ip才能跨域访问本接口）
        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        [response setValue:@"Content-Type" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        //设置options的实效性（我设置了12个小时=43200秒）
        [response setValue:@"43200" forAdditionalHeader:@"Access-Control-max-age"];
        return response;
    }];
    [_localServer addHandlerForMethod:@"POST"
                                 path:@"/test"                        //接口名
                         requestClass:[GCDWebServerURLEncodedFormRequest class]
                         processBlock:^GCDWebServerResponse *(GCDWebServerRequest* request) {
        GCDWebServerDataResponse *response;
        //对请求来源做合法性判断
        //                             NSString *origin = [request.headers objectForKey:@"Origin"];
        //                             NSString *referer = [request.headers objectForKey:@"Referer"];
        //
        //                             if ([origin containsString:@"xxxxxxx"] && [referer containsString:@"yyyyyy"]) {//合法规则跟后台协商
        //                                 //请求合法，继续其他操作
        //                             }else{
        //                                 //请求不合法，返回对应的状态
        //                                 response = [GCDWebServerDataResponse responseWithText:@"failure"];
        //                             }
        //获取请求中的参数（body）
        NSJSONSerialization *json = [NSJSONSerialization JSONObjectWithData:[(GCDWebServerURLEncodedFormRequest*)request data] options:NSJSONReadingAllowFragments error:nil];
        NSLog(@"请求参数 %@",json);
        
        response = [GCDWebServerDataResponse responseWithText:@"success"];
        //响应头设置，跨域请求需要设置，只允许设置的域名或者ip才能跨域访问本接口）
        [response setValue:@"*" forAdditionalHeader:@"Access-Control-Allow-Origin"];
        
        [response setValue:@"Content-Type" forAdditionalHeader:@"Access-Control-Allow-Headers"];
        
        return response;
    }];
    
    
    //设置监听端口
    [_localServer startWithPort:5555 bonjourName:nil];
    NSLog(@"Visit %@ in your web browser", _localServer.serverURL);
}

- (void)webServerDidStart:(GCDWebServer *)server{
    NSLog(@"本地服务启动成功");
}

//- (void)openServer {
//
//    self.httpServer = [[HTTPServer alloc]init];
//    [self.httpServer setType:@"_http.tcp"];
//    [self.httpServer setPort:6080];
//    NSString *webPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"Web"];
//    [self.httpServer setDocumentRoot:webPath];
//    [self.httpServer setConnectionClass:[MyHTTPConnection class]];
//
//    NSLog(@"Setting document root: %@", webPath);
//    NSString *ipStr = [self getIpAddresses];
//    NSLog(@"ip地址 %@", ipStr);
//
//    //    NSFileManager *fileManager = [[NSFileManager alloc] init];
//    //    NSLog(@"%@",webPath);
//
//    //    if (![fileManager fileExistsAtPath:webPath]){
//    //        NSLog(@"File path error!");
//    //    } else {
//
//    //        [self.httpServer setDocumentRoot:webPath];
//    NSLog(@"服务器路径：%@", webPath);
//    _startServer = [self startServer];
//    //    }
//}
//
//- (BOOL)startServer {
//
//    BOOL ret = NO;
//    NSError *error = nil;
//    if( [self.httpServer start:&error]) {
//
//        NSLog(@"HTTP服务器启动成功端口号为： %hu", [_httpServer listeningPort]);
//        ret = YES;
//
//        UIWebView *web = [UIWebView new];
//        web.frame = self.view.bounds;
//        NSURL *url = [NSURL URLWithString:[NSString stringWithFormat:@"http://localhost:%hu", [_httpServer listeningPort]]];
//        NSLog(@"%@",[NSString stringWithFormat:@"http://localhost:%hu", [_httpServer listeningPort]]);
//        NSURLRequest *request = [NSURLRequest requestWithURL:url];
//        [web loadRequest:request];
//        [self.view addSubview:web];
//
//    } else {
//        NSLog(@"启动HTTP服务器出错: %@", error);
//    }
//    return ret;
//}
//
//- (void)stopServer {
//
//    if (self.httpServer != nil) {
//        [self.httpServer stop];
//        _startServer = NO;
//    }
//}

- (NSString *)getIpAddresses {
    
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *temp_addr = NULL;
    int success = 0;
    // retrieve the current interfaces - returns 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        // Loop through linked list of interfaces
        temp_addr = interfaces;
        while(temp_addr != NULL)
        {
            if(temp_addr->ifa_addr->sa_family == AF_INET)
            {
                // Check if interface is en0 which is the wifi connection on the iPhone
                if([[NSString stringWithUTF8String:temp_addr->ifa_name] isEqualToString:@"en0"])
                {
                    // Get NSString from C String
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)temp_addr->ifa_addr)->sin_addr)];
                }
            }
            temp_addr = temp_addr->ifa_next;
        }
    }
    // Free memory
    freeifaddrs(interfaces);
    return address;
}

@end
