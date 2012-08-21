//
//  NSString+Tools.m
//  PutAndTake
//
//  Created by Alexandru Savu on 8/18/12.
//
//

#import "NSString+Tools.h"

@implementation NSString (Tools)

- (BOOL)isNotEmpty
{
	BOOL result = ([self length] > 0);
	return result;
}

@end
