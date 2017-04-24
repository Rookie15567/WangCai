//
//  RGBColor.h

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>//要包含

@interface RGBColor : NSObject

//颜色
//http://tool.oschina.net/commons?type=3
+(UIColor *) colorWithHexString: (NSString *)stringToConvert;

+(UIImage*) createImageWithColor:(UIColor*) color;
@end
