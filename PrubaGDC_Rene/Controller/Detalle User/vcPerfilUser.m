//
//  vcPerfilUser.m
//  PrubaGDC_Rene
//
//  Created by Rene Borja on 10/26/20.
//

#import "vcPerfilUser.h"
#import "SharedManager.h"
#import <SDWebImage/SDWebImage.h>
@interface vcPerfilUser (){
    MyManager* sharedManager;
}

@end

@implementation vcPerfilUser

- (void)viewDidLoad {
    [super viewDidLoad];
    sharedManager = [MyManager sharedManager];
    [self configUI];
    // Do any additional setup after loading the view.
}

-(void)configUI{
    _viewContent.layer.cornerRadius = 15;
    _imgAvatar.layer.cornerRadius = _imgAvatar.frame.size.width *0.50;
}

-(void)setUpUI{
    _lblLogin.text = sharedManager.login;
    _lblIdUser.text =[NSString stringWithFormat:@"%d",sharedManager.idUser];
    _lblType.text = sharedManager.type;
    _lblSite_admin.text = sharedManager.site_admin;
    
    [_imgAvatar sd_setImageWithURL:[NSURL URLWithString:sharedManager.Avatar]
                 placeholderImage:[UIImage imageNamed:@""]];
}
-(void)getUserData:(NSString*)login :(int)idUser :(NSString*)type :(NSString*)site_admin :(NSString*)avatar{
    sharedManager.login = login;
    sharedManager.idUser = idUser;
    sharedManager.type = type;
    sharedManager.site_admin = site_admin;
    sharedManager.Avatar = avatar;
}
@end
