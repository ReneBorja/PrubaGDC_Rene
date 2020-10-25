//
//  SharedManager.h
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject {
    NSString *someProperty;
}

@property (nonatomic, retain) NSString *someProperty;

+ (id)sharedManager;

@end
