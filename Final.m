%%%%%%%%%%% AJ Iglesias %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Basic SVD algorithm using test and training sets of handwritten digits
% from 0 - 9 


%loads in training set from online link provided
A = load('zip.train');
b = load('zip.test');

%creates matrices that contain all of a specific number (1-9) in the data
%set
picnum0 = A(A(:,1)== 0, :);
picnum1 = A(A(:,1)== 1, :);
picnum2 = A(A(:,1)== 2, :);
picnum3 = A(A(:,1)== 3, :);
picnum4 = A(A(:,1)== 4, :);
picnum5 = A(A(:,1)== 5, :);
picnum6 = A(A(:,1)== 6, :);
picnum7 = A(A(:,1)== 7, :);
picnum8 = A(A(:,1)== 8, :);
picnum9 = A(A(:,1)== 9, :);

%creates matrices that contain all of a specific number (1-9) in the test
%set
picnum0b = b(b(:,1)== 0, :);
picnum1b = b(b(:,1)== 1, :);
picnum2b = b(b(:,1)== 2, :);
picnum3b = b(b(:,1)== 3, :);
picnum4b = b(b(:,1)== 4, :);
picnum5b = b(b(:,1)== 5, :);
picnum6b = b(b(:,1)== 6, :);
picnum7b = b(b(:,1)== 7, :);
picnum8b = b(b(:,1)== 8, :);
picnum9b = b(b(:,1)== 9, :);

%Takes a 1 x 256 matrix of a number from test set to use for latter LLS
%calculation to obtain alphas for distance formula

%%% CHANGE THE 9 IN picnum9b TO WHATEVER NUMBER YOU WANT TO DETERMINE
%%% DISTANCE FOR TO CHANGE TO THE CORRECT B MATRIX FOR THAT NUMBER

B = picnum9b(2, 2:257)';


%creates a series of 256 x 1 matrices for SVD calculation for each number
%in training set

%%% CHANGE THE 9 IN picnum9 TO WHATEVER NUMBER YOU WANT TO GET SVD FOR TO
%%% CHANGE TO THE CORRECT U1,S1,V1 MATRICES FOR THAT SPECIFIC NUMBER

picnumsvd = picnum9(:, 2:257)';

%%% NOTHING NEEDS TO BE CHANGED BEYOND THIS POINT FOR EACH NUMBER, CHANGING
%%% THE LINES ABOVE WILL BE ENOUGH TO CHANGE WHAT NUMBER WE ACCOUNTING FOR

%perform SVD calculation on training set
[U1,S1,V1] = svd(picnumsvd);
diag(S1);

%Log plot for singular values to check decay of values for given number
semilogy(diag(S1))

%k = 5 is a known solid value for constructing image distance functions/images
%Obtain A matrix for LLS method obtains U1,U2,U3,..Uk
k = 5;
Amat = [];
for i = 1:k
    Amat = [Amat,U1(:,i)];
end

%transpose A in order to solve linear system using LLS

AT = Amat';

ATA = AT*Amat;
ATB = AT*B;

%LLS Atranspose * Amat \ Atranspose * B
%alpha values should be as many as I make my k
%therefore should be 5 different values

alpha = ATA \ ATB;

%First U value in summation formula is commonly the AVG of the SVD hence
%U(1) can be understood as AVG

% Used to obtain projection for distance calculations
projection = 0;
for i = 1:k
   projection = projection + alpha(i) * U1(:,i);
end

%to solve for euclidian distance
distance = norm(projection - B)

%This project on Image distance shows that the least distance between training and test set
%is number 1 which makes sense because it is the simplest to write in
%terms of universally while 8 is the highest distance which makes sense as
%well because of the abstract amount of ways you can write it 





