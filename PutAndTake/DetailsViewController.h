//
//  DetailsViewController.h
//  PutAndTake
//
//  Created by Alexandru Savu on 7/29/12.
//
//

#import <UIKit/UIKit.h>

@interface DetailsViewController : UIViewController

@property (nonatomic, strong) UIView *cellView;
@property (nonatomic, strong) UIButton *doneButton;

- (id)initWithSize:(double )x Y:(double)y Width:(double)width Height:(double)height;

- (void)close:(id)sender;

@end
