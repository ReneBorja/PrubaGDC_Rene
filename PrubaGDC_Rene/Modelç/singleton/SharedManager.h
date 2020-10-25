//
//  SharedManager.h
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import <Foundation/Foundation.h>

@interface MyManager : NSObject {
    NSString *urlRepos;
}

@property (nonatomic, retain) NSString *urlRepos;

+ (id)sharedManager;

@end
