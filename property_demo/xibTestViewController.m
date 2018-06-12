//
//  xibTestViewController.m
//  property_demo
//
//  Created by zhanqin on 2018/6/12.
//  Copyright © 2018年 zhanqin. All rights reserved.
//

#import "xibTestViewController.h"

@interface xibTestViewController ()

@property (weak, nonatomic) IBOutlet UILabel *weakLabel;

@property (strong, nonatomic) IBOutlet UILabel *strongLabel;

@end

@implementation xibTestViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self initButtons];
}

-(void)dealloc{
    NSLog(@"xibTestViewController dealloc");
}

-(void)initButtons{
    UIButton * removeButton = [UIButton buttonWithType:UIButtonTypeCustom];
    removeButton.backgroundColor = [UIColor redColor];
    removeButton.frame = CGRectMake(30, 400, 100, 40);
    [removeButton setTitle:@"删除" forState:UIControlStateNormal];
    [removeButton addTarget:self action:@selector(removeLabels) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:removeButton];
    
    UIButton * addButton = [UIButton buttonWithType:UIButtonTypeCustom];
    addButton.backgroundColor = [UIColor redColor];
    addButton.frame = CGRectMake(150, 400, 100, 40);
    [addButton setTitle:@"添加" forState:UIControlStateNormal];
    [addButton addTarget:self action:@selector(addLabels) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:addButton];
    
    UIButton * backButton = [UIButton buttonWithType:UIButtonTypeCustom];
    backButton.backgroundColor = [UIColor redColor];
    backButton.frame = CGRectMake(30, 30, 60, 40);
    [backButton setTitle:@"返回" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(backClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:backButton];
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

-(void)backClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
