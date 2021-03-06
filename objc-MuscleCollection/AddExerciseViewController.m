//
//  AddExerciseViewController.m
//  objc-PushupProtocols
//
//  Created by Zachary Drossman on 2/13/15.
//  Copyright (c) 2015 Zachary Drossman. All rights reserved.
//

#import "AddExerciseViewController.h"
#import "FISExercise.h"
#import "FISMuscleGroup.h"
#import "MuscleCollectionViewCell.h"

@interface AddExerciseViewController ()

@property (weak, nonatomic) IBOutlet UICollectionView *exerciseCollectionView;
@property (strong, nonatomic) NSMutableArray *muscleGroups;
@property (strong, nonatomic) FISExercise *exerciseToAdd;
@property (strong, nonatomic) NSIndexPath *index;

@end

@implementation AddExerciseViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.exerciseName.delegate = self;
    self.exerciseCollectionView.allowsMultipleSelection = YES;
    self.exerciseCollectionView.delegate = self;
    self.exerciseCollectionView.dataSource = self;
  
    
    
    
    // Do any additional setup after loading the view.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSMutableArray *)muscleGroups {
    if (!_muscleGroups) {
        
        FISMuscleGroup *trapezius = [[FISMuscleGroup alloc] initWithName:@"Trapezius" MuscleGroupImage:[UIImage imageNamed:@"Trapezius.png"]];
        FISMuscleGroup *bicepsBrachii = [[FISMuscleGroup alloc] initWithName:@"Biceps Brachii" MuscleGroupImage:[UIImage imageNamed:@"BicepsBrachii.png"]];
        FISMuscleGroup *deltoids = [[FISMuscleGroup alloc] initWithName:@"Deltoids" MuscleGroupImage:[UIImage imageNamed:@"Deltoid.png"]];
        FISMuscleGroup *externalObliques = [[FISMuscleGroup alloc] initWithName:@"External Obliques" MuscleGroupImage:[UIImage imageNamed:@"ExternalOblique.png"]];
        FISMuscleGroup *gluteusMaximus = [[FISMuscleGroup alloc] initWithName:@"Gluteus Maximus" MuscleGroupImage:[UIImage imageNamed:@"GluteusMaximus.png"]];
        FISMuscleGroup *latissimusDorsi = [[FISMuscleGroup alloc] initWithName:@"Latissimus Dorsi" MuscleGroupImage:[UIImage imageNamed:@"LatissimusDorsi.png"]];
        FISMuscleGroup *pectoralisMajor = [[FISMuscleGroup alloc] initWithName:@"Pectoralis Major" MuscleGroupImage:[UIImage imageNamed:@"PectoralisMajor.png"]];
        FISMuscleGroup *pectoralisMinor = [[FISMuscleGroup alloc] initWithName:@"Pectoralis Minor" MuscleGroupImage:[UIImage imageNamed:@"PectoralisMinor.png"]];
        FISMuscleGroup *rectusAbdominus = [[FISMuscleGroup alloc] initWithName:@"Rectus Abdominis" MuscleGroupImage:[UIImage imageNamed:@"RectusAbdominis.png"]];
        FISMuscleGroup *transverseAbdominus = [[FISMuscleGroup alloc] initWithName:@"Transverse Abdominis" MuscleGroupImage:[UIImage imageNamed:@"TransversusAbdominis.png"]];
        FISMuscleGroup *vastusLateralis = [[FISMuscleGroup alloc] initWithName:@"Quadriceps" MuscleGroupImage:[UIImage imageNamed:@"VastusLateralis.png"]];

        
        _muscleGroups = [[NSMutableArray alloc] initWithArray:@[trapezius, vastusLateralis,gluteusMaximus,pectoralisMajor,pectoralisMinor, deltoids, bicepsBrachii, rectusAbdominus, transverseAbdominus, externalObliques, latissimusDorsi]]; //@"Hamstrings"@"Triceps", @"Erector Spinae"]];
    }
    
    return _muscleGroups;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)newExerciseTapped:(UIButton *)sender {
    
    self.exerciseToAdd.name = self.exerciseName.text;
    [self.delegate addNewExercise:self.exerciseToAdd];
}

-(FISExercise *)exerciseToAdd {
    if (!_exerciseToAdd) {
        _exerciseToAdd = [[FISExercise alloc] init];
    }
    
    return _exerciseToAdd;
}

- (IBAction)cancelTapped:(UIButton *)sender {
    [self.delegate cancel];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView
     numberOfItemsInSection:(NSInteger)section{
    return [self.muscleGroups count];
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MuscleCollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"ImageView" forIndexPath:indexPath];
    
    
    
    FISMuscleGroup *muscleGroup = self.muscleGroups[indexPath.row];
    cell.muscleImageView.alpha = 0.5;
    
    cell.muscleImageView.image = muscleGroup.imageOfMuscleGroup;
    cell.muscleLabel.text = muscleGroup.name;
    
    if([self.exerciseToAdd.muscleGroups containsObject:muscleGroup]){
        cell.muscleImageView.alpha = 1;
    }
    
   
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    MuscleCollectionViewCell* cell = (MuscleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.muscleImageView.alpha = 1.0;
    FISMuscleGroup *selectedMuscleGroup = self.muscleGroups[indexPath.row];
    [self.exerciseToAdd.muscleGroups addObject:selectedMuscleGroup];
}

-(void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath{
    
    MuscleCollectionViewCell* cell = (MuscleCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.muscleImageView.alpha = 0.5;
    FISMuscleGroup *selectedMuscleGroup = self.muscleGroups[indexPath.row];
    [self.exerciseToAdd.muscleGroups removeObject:selectedMuscleGroup];

  
}








@end
