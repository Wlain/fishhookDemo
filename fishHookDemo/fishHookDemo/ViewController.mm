//
//  ViewController.m
//  fishHookDemo
//
//  Created by william on 2021/4/23.
//

#import "ViewController.h"
#import <fishhook/fishhook.h>
#import <functional>
#import <iostream>

//struct rebinding {
//    const char *name; // 需要hook的函数名字，C字符串
//    void *replacement;// 新的函数指针
//    void **replaced;  // 原始函数指针的指针（二级指针）
//};


@interface ViewController ()

@end

@implementation ViewController

// 更改系统的NSlog函数
// 函数指针，保存原始的函数地址
static void(*nslogFunc)(NSString* format, ...);

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 实现交换
    // rebinding 结构体
    struct rebinding nslog;
    nslog.name = "NSLog";
    nslog.replacement = (void*)NSLogTest;
    nslog.replaced = (void**)&nslogFunc;
    // 定义数组
    struct rebinding rebs[1] = {nslog};
    // 用来重新绑定符号,可以一次交换多个
    // arg1: 存放rebinding结构体的数组
    // arg2: 数组的长度
    rebind_symbols(rebs, 1);
    // Do any additional setup after loading the view.
}


// 定义一个新的函数
void NSLogTest(NSString* format, ...)
{
    format = [format stringByAppendingFormat:@"\nhook successed!"];
    nslogFunc(format);
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    NSLog(@"touchBegin called");
}

- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}

- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    
}


@end
