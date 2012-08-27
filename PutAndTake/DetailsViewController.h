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
@property (nonatomic, strong) NSArray *sharedLocations;

@property (nonatomic ,strong) NSString *price;
@property (nonatomic ,strong) NSString *phone;
@property (nonatomic ,strong) NSString *address;

- (id)initWithSize:(double )x Y:(double)y Width:(double)width Height:(double)height;
- (void)close:(id)sender;
- (void)getServerData;

@end
