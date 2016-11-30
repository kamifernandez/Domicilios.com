//
//  ViewController.m
//  Domicilios.com
//
//  Created by Christian camilo fernandez on 29/11/16.
//
//

#import "ViewController.h"
#import "ManageInternetRequest.h"
#import "utility.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configurerView];
    //[self performSelector:@selector(requestServerUser) withObject:nil afterDelay:0.5];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configurerView{
    float version=[[UIDevice currentDevice].systemVersion floatValue];
    if(version >=8.0){
        locationManager = [[CLLocationManager alloc] init];
        [locationManager setDelegate:(id)self];
        if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            [locationManager requestWhenInUseAuthorization];
        }
        [locationManager requestWhenInUseAuthorization];
        [locationManager startMonitoringSignificantLocationChanges];
        [locationManager startUpdatingLocation];
    }else{
        //Location
        _MyCLController = [[MyCLController alloc] init];
        [_MyCLController.locationManager startUpdatingLocation];
    }
}

#pragma mark - RequestServerUser

-(void)requestServerUser{
    NSUserDefaults * _defaults = [NSUserDefaults standardUserDefaults];
    if ([[_defaults objectForKey:@"connectioninternet"] isEqualToString:@"YES"]) {
        [self mostrarCargando];
        NSOperationQueue * queue1 = [[NSOperationQueue alloc] init];
        [queue1 setMaxConcurrentOperationCount:1];
        NSInvocationOperation *operation = [[NSInvocationOperation alloc] initWithTarget:self selector:@selector(envioServerUser) object:nil];
        [queue1 addOperation:operation];
    }else{
        NSMutableDictionary *msgDict=[[NSMutableDictionary alloc] init];
        [msgDict setValue:@"Atención" forKey:@"Title"];
        [msgDict setValue:@"No tiene conexión a internet." forKey:@"Message"];
        [msgDict setValue:@"Aceptar" forKey:@"Cancel"];
        [msgDict setValue:@"" forKey:@"Aceptar"];
        
        [self performSelectorOnMainThread:@selector(showAlert:) withObject:msgDict
                            waitUntilDone:YES];
    }
}

-(void)envioServerUser{
    _data = [ManageInternetRequest organizer:@"data" data:nil];
    NSLog(@"%@",[[_data objectAtIndex:0] objectForKey:@"categorias"]);
    [self performSelectorOnMainThread:@selector(ocultarCargandoUser) withObject:nil waitUntilDone:YES];
}

-(void)ocultarCargandoUser{
    if ([_data count] > 0) {
        /*NSSortDescriptor *sortDescriptor;
        sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"rating"
                                                     ascending:YES];
        NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
        NSArray *sortedArray = [_data sortedArrayUsingDescriptors:sortDescriptors];
        NSLog(@"%@",sortedArray);*/
        [self.tableStores reloadData];
    }else{
    }
    [self mostrarCargando];
}

#pragma mark - UITableView Delegate & Datasrouce

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_data count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *CellIdentifier = @"CellList";
    cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        [[NSBundle mainBundle] loadNibNamed:@"CellList" owner:self options:nil];
        cell = _cellStoresView;
        self.cellStoresView = nil;
    }
    
    [self.lblTittle setText:[[_data objectAtIndex:indexPath.row] objectForKey:@"nombre"]];
    
    NSString * urlIcon = [@"https://placeholdit.imgix.net/~text?txtsize=19&txt=60×60&w=80&h=80" stringByAddingPercentEscapesUsingEncoding:NSUTF8StringEncoding];
    if ([urlIcon isEqualToString:@""]) {
        [self.indicatorCell stopAnimating];        
    }else{
        NSURL *imageURL = [NSURL URLWithString:urlIcon];
        NSString *key = [urlIcon MD5Hash];
        NSData *data = [FTWCache objectForKey:key];
        if (data) {
            [self.indicatorCell stopAnimating];
            UIImage *image = [UIImage imageWithData:data];
            self.imgIcon.image = image;
        } else {
            dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_HIGH, 0ul);
            dispatch_async(queue, ^{
                NSData *data = [NSData dataWithContentsOfURL:imageURL];
                [FTWCache setObject:data forKey:key];
                UIImage *image = [UIImage imageWithData:data];
                dispatch_sync(dispatch_get_main_queue(), ^{
                    [self.indicatorCell stopAnimating];
                    self.imgIcon.image = image;
                });
            });
        }
    }
    NSString * rating = [[_data objectAtIndex:indexPath.row] objectForKey:@"rating"];
    if ([rating isEqualToString:@"1"]) {
        [self.imgStarOne setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
    }else if ([rating isEqualToString:@"2"]) {
        [self.imgStarOne setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarTwo setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
    }else if ([rating isEqualToString:@"3"]){
        
        [self.imgStarOne setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarTwo setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarThree setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
    }else if ([rating isEqualToString:@"4"]){
        
        [self.imgStarOne setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarTwo setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarThree setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarFour setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
    }else if ([rating isEqualToString:@"5"]){
        
        [self.imgStarOne setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarTwo setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarThree setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarFour setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarFive setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
    }else{
        [self.imgStarOne setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarTwo setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarThree setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarFour setImage:[UIImage imageNamed:@"estrella_on_peq.png"]];
        
        [self.imgStarFive setImage:[UIImage imageNamed:@"estrella_off_peq.png"]];
    }
    
    [self.lblCategory setText:[[_data objectAtIndex:indexPath.row] objectForKey:@"categorias"]];
    
    [self.housePrice setText:[NSString stringWithFormat:@"Domicilio: $%@",[[_data objectAtIndex:indexPath.row] objectForKey:@"domicilio"]]];
    
    [self.timeRequest setText:[NSString stringWithFormat:@"Tiempo domicilio: %@ Minutos",[[_data objectAtIndex:indexPath.row] objectForKey:@"tiempo_domicilio"]]];
    BOOL gpsActivo = [utility consultarGpsActivo];
    if (gpsActivo) {
        NSString * ubicacion = [[_data objectAtIndex:indexPath.row] objectForKey:@"ubicacion_txt"];
        if (![ubicacion isEqualToString:@""]) {
            NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
            double latitudPhone = [[_defaults objectForKey:@"latitud"] doubleValue];
            double longitudPhone = [[_defaults objectForKey:@"longitud"] doubleValue];
            
            NSArray * split = [ubicacion componentsSeparatedByString:@","];
            
            double latitudStore = [[split objectAtIndex:0] doubleValue];
            double longitudStore = [[split objectAtIndex:1] doubleValue];
            
            CLLocation *locA = [[CLLocation alloc] initWithLatitude:latitudPhone longitude:longitudPhone];
            CLLocation *locB = [[CLLocation alloc] initWithLatitude:latitudStore longitude:longitudStore];
            
            CLLocationDistance distance = [locA distanceFromLocation:locB];
            
            CLLocationDistance kilometers = distance / 1000.0;
            
            NSString * distanceString = [NSString stringWithFormat:@"%.1f Km",kilometers];
            
            [self.distance setText:distanceString];
        }
    }else{
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

#pragma mark - IBAction

-(IBAction)filter:(id)sender{
    [[NSBundle mainBundle] loadNibNamed:@"ViewFilter" owner:self options:nil];
    
    [self.viewFilter setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height)];
    
    CALayer * l = [self.viewContentFilter layer];
    [l setMasksToBounds:YES];
    [l setCornerRadius:10.0];
    // You can even add a border
    [l setBorderWidth:1.5];
    [l setBorderColor:[[UIColor whiteColor] CGColor]];
    
    [self.view addSubview:self.viewFilter];
    
    UITapGestureRecognizer* singleTapHiddenKeyBoard = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTapHiddenKeyBoard:)];
    
    singleTapHiddenKeyBoard.numberOfTapsRequired = 1;
    singleTapHiddenKeyBoard.numberOfTouchesRequired = 1;
    [self.viewContenAlltFilter addGestureRecognizer:singleTapHiddenKeyBoard];
}

-(IBAction)filterSelect:(id)sender{
    int tag = [sender tag];
    NSString * sortKey = @"";
    BOOL ascending;
    if (tag == 0){
        sortKey = @"domicilio";
        ascending = YES;
    }else if (tag == 1){
        sortKey = @"rating";
        ascending = NO;
    }else if (tag == 2){
        sortKey = @"ubicacion_txt";
        ascending = NO;
    }else{
        sortKey = @"tiempo_domicilio";
        ascending = YES;
    }
    
    NSSortDescriptor *sortDescriptor;
    sortDescriptor = [[NSSortDescriptor alloc] initWithKey:sortKey
                                                 ascending:ascending];
    NSArray *sortDescriptors = [NSArray arrayWithObject:sortDescriptor];
    NSArray *sortedArray = [_data sortedArrayUsingDescriptors:sortDescriptors];
    _data = nil;
    _data = [[NSMutableArray alloc] initWithArray:sortedArray];
    [self handleSingleTapHiddenKeyBoard:nil];
    [self.tableStores reloadData];
    [self.tableStores setContentOffset:CGPointZero animated:YES];
}

#pragma mark - Metodos Vista Cargando

-(void)mostrarCargando{
    @autoreleasepool {
        if (_vistaWait.hidden == TRUE) {
            _vistaWait.hidden = FALSE;
            CALayer * l = [_vistaWait layer];
            [l setMasksToBounds:YES];
            [l setCornerRadius:10.0];
            // You can even add a border
            [l setBorderWidth:1.5];
            [l setBorderColor:[[UIColor whiteColor] CGColor]];
            
            [_indicador startAnimating];
        }else{
            _vistaWait.hidden = TRUE;
            [_indicador stopAnimating];
        }
    }
}

#pragma mark - AlertView

-(void)showAlert:(NSMutableDictionary *)msgDict
{
    if ([[msgDict objectForKey:@"Aceptar"] length]>0) {
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:[msgDict objectForKey:@"Title"]
                            message:[msgDict objectForKey:@"Message"]
                            delegate:self
                            cancelButtonTitle:[msgDict objectForKey:@"Cancel"]
                            otherButtonTitles:[msgDict objectForKey:@"Aceptar"],nil];
        [alert setTag:[[msgDict objectForKey:@"Tag"] intValue]];
        [alert show];
    }else{
        UIAlertView *alert=[[UIAlertView alloc]
                            initWithTitle:[msgDict objectForKey:@"Title"]
                            message:[msgDict objectForKey:@"Message"]
                            delegate:self
                            cancelButtonTitle:[msgDict objectForKey:@"Cancel"]
                            otherButtonTitles:nil];
        [alert setTag:[[msgDict objectForKey:@"Tag"] intValue]];
        [alert show];
    }
}

#pragma mark - Gesture

-(void)handleSingleTapHiddenKeyBoard:(UIGestureRecognizer *)gesture{
    [self.viewFilter setHidden:TRUE];
}

#pragma mark - Delegate Location

- (void)requestAlwaysAuthorization{
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if (status == kCLAuthorizationStatusAuthorizedWhenInUse || status == kCLAuthorizationStatusDenied) {
        NSString *title;
        title = (status == kCLAuthorizationStatusDenied) ? @"Location services are off" : @"Background location is not enabled";
        NSString *message = @"Para utilizar la localización debe activar esta opción en Ajustes -> Servicios de localización -> Siempre";
        
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
    }
    // The user has not enabled any location services. Request background authorization.
    else if (status == kCLAuthorizationStatusNotDetermined) {
        if ([locationManager respondsToSelector:@selector(requestAlwaysAuthorization)]) {
            [locationManager requestAlwaysAuthorization];
        }
    }
}

-(void)locationManager:(CLLocationManager *)manager didChangeAuthorizationStatus:(CLAuthorizationStatus)status {
    if (status == kCLAuthorizationStatusDenied) {
        // permission denied
        [self requestServerUser];
    }
    else if (status == kCLAuthorizationStatusAuthorizedAlways) {
        //[self updateMap];
        [self requestServerUser];
    }else if (status == kCLAuthorizationStatusAuthorizedWhenInUse) {
        [self requestServerUser];
    }
}

- (void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{
    NSLog(@"didFailWithError: %@", error);
}

- (void)locationManager:(CLLocationManager *)manager didUpdateToLocation:(CLLocation *)newLocation fromLocation:(CLLocation *)oldLocation{
    NSLog(@"didUpdateToLocation: %@", newLocation);
    CLLocation *currentLocation = newLocation;
    if (currentLocation != nil) {
        NSUserDefaults *_defaults = [NSUserDefaults standardUserDefaults];
        [_defaults setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] forKey:@"latitud"];
        [_defaults setObject:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude] forKey:@"longitud"];
    }
}

@end
