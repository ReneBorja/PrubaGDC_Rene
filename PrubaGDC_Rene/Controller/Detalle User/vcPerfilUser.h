//
//  vcPerfilUser.h
//  PrubaGDC_Rene
//
//  Created by Rene Borja on 10/26/20.
//

#import <UIKit/UIKit.h>


@interface vcPerfilUser : UIViewController
@property (strong, nonatomic) IBOutlet UIView *viewContent;
@property (strong, nonatomic) IBOutlet UILabel *lblLogin;
@property (strong, nonatomic) IBOutlet UILabel *lblIdUser;
@property (strong, nonatomic) IBOutlet UILabel *lblType;
@property (strong, nonatomic) IBOutlet UILabel *lblSite_admin;
@property (strong, nonatomic) IBOutlet UIImageView *imgAvatar;


-(void)getUserData:(NSString*)login :(int)idUser :(NSString*)type :(NSString*)site_admin :(NSString*)avatar;
@end

