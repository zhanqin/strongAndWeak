//
//  ViewController.m
//  property_demo
//
//  Created by zhanqin on 2018/6/12.
//  Copyright © 2018年 zhanqin. All rights reserved.
//

#import "ViewController.h"
#import "xibTestViewController.h"

@interface ViewController ()

@property(nonatomic,strong) UILabel * strongLabel;
@property(nonatomic,weak) UILabel * weakLabel;
@property(nonatomic,strong) NSArray * strongArray;
@property(nonatomic,weak) NSArray * weakArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.strongArray = @[@"111",@"222"];
    //警告:Assigning array literal to a weak property; object will be released after assignment
    self.weakArray = @[@"3333",@"4444"];
    NSLog(@"===== %@",self.strongArray);
    NSLog(@"===== %@",self.weakArray);
    NSArray * array = @[@"3333",@"4444"];
    self.weakArray = array;
    NSLog(@"===== %@",self.weakArray);
    self.view.backgroundColor = [UIColor whiteColor];
    [self initView];
}

-(void)initView{
    [self.view addSubview:self.strongLabel];
    [self initWeakLabel];
    //[self.view addSubview:self.weakLabel];
    NSLog(@"weak array===== %@",self.weakArray);
    NSLog(@"init strong===== %@",_strongLabel);
    NSLog(@"init weak===== %@",_weakLabel);
    [self initButtons];
}

-(void)initButtons{
    UIButton * removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.backgroundColor = [UIColor redColor];
    removeButton.frame = CGRectMake(30, 360, 100, 40);
    [removeButton setTitle:@"删除" forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeLabels) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.backgroundColor = [UIColor redColor];
    addButton.frame = CGRectMake(150, 360, 100, 40);
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addLabels) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton * xibButton = [UIButton buttonWithType:UIButtonTypeCustom];
    xibButton.backgroundColor = [UIColor redColor];
    xibButton.frame = CGRectMake(30, 420, 200, 40);
    [xibButton setTitle:@"跳转xib" forState:UIControlStateNormal];
    [xibButton addTarget:self action:@selector(gotoXibVC) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:xibButton];
}

-(UILabel *)strongLabel{
    if (!_strongLabel) {
        _strongLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 100, 200, 60)];
        _strongLabel.backgroundColor = [UIColor orangeColor];
        _strongLabel.text = @"我是strong";
        _strongLabel.textAlignment = NSTextAlignmentCenter;
    }
    return _strongLabel;
}

/**
-(UILabel *)weakLabel{
    if (!_weakLabel) {
        //警告：Assigning retained object to weak variable; object will be released after assignment
        _weakLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 120, 200, 60)];
        _weakLabel.backgroundColor = [UIColor cyanColor];
        _weakLabel.text = @"我是weak";
        _weakLabel.textAlignment = NSTextAlignmentCenter;
        [self.view addSubview:self.weakLabel];//因为代码执行到这里weakLabel为nil，所以这句会导致死循环，所以weak修饰的懒加载不能这样写
    }
    return _weakLabel;
}
*/

-(UILabel *)weakLabel{
    if (!_weakLabel) {
        UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 200, 60)];
        label.backgroundColor = [UIColor cyanColor];
        label.text = @"我是weak";
        label.textAlignment = NSTextAlignmentCenter;
        _weakLabel = label;
        [self.view addSubview:self.weakLabel];//如果不加这一句，下面return的时候_weakLabel依然为nil
    }
    return _weakLabel;
}

-(void)initWeakLabel{
//    _weakLabel = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 200, 60)];
//    _weakLabel.backgroundColor = [UIColor cyanColor];
//    _weakLabel.text = @"我是weak";
//    _weakLabel.textAlignment = NSTextAlignmentCenter;
//    [self.view addSubview:_weakLabel];
    
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(30, 170, 200, 60)];
    label.backgroundColor = [UIColor cyanColor];
    label.text = @"我是weak";
    label.textAlignment = NSTextAlignmentCenter;
    _weakLabel = label;
    [self.view addSubview:self.weakLabel];//如果不加这一句，在别处调用_weakLabel时依然为nil
}


-(void)removeLabels{
    [self.strongLabel removeFromSuperview];
    NSLog(@"remove strong===== %@",_strongLabel);
    [self.weakLabel removeFromSuperview];
    NSLog(@"remove weak===== %@",_weakLabel);
}

-(void)addLabels{
    [self.view addSubview:self.strongLabel];
    NSLog(@"add strong===== %@",_strongLabel);
    NSLog(@"add111 weak===== %@",_weakLabel);
    //如果没有用懒加载的方式来初始化weakLabel，那么此处的weakLabel为nil，添加无效，每次weakLabel被remove之后，再次添加都需要调用initWeakLabel方法才能添加成功
    [self.view addSubview:self.weakLabel];
    NSLog(@"add weak===== %@",_weakLabel);
}

-(void)gotoXibVC{
    xibTestViewController * vc = [[xibTestViewController alloc] init];
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
