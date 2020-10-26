//
//  vcDetalleUser.h
//  PrubaGDC_Rene
//
//  Created by Prueba IOS on 10/24/20.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface vcDetalleUser : UIViewController
@property (weak, nonatomic) IBOutlet UITableView *tvRepositorios;

@property (nonatomic, weak) NSString *urlRepos;
-(void)getRequest:(NSString*)url;
@end

NS_ASSUME_NONNULL_END
