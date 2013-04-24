//
//  ViewController.h
//  PutAndTake
//
//  Created by Alexandru Savu on 6/11/12Week24.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TestDragView;

@interface ViewController : UIViewController

@property (nonatomic) int touchPoint;
@property (nonatomic, strong) TestDragView *testDrag;
@property (nonatomic, strong) UILabel *nordjylland;
@property (nonatomic, strong) UILabel *oestjylland;
@property (nonatomic, strong) UILabel *vestjylland;
@property (nonatomic, strong) UILabel *sjaelland;
@property (nonatomic, strong) UILabel *sonderjylland;
@property (nonatomic, strong) UILabel *fyn;

-(void) moveNextView;


@end
