%kNN on my MNIST

%cleanup
clear all;
close all;
%load and init
load MNIST_Xtestp.mat;
load MNIST_Xtrain.mat;
load MNIST_ytrain.mat;
ytest = zeros(10000,1);

%kNN
for i = 1:10000
    
    %init
    dist = zeros(60000,1);
    vote = zeros(10,1);
    
    %calculate distance
    test = Xtest(i,:);
    for j = 1:60000
        train = Xtrain(j,:);
        dist(j) = sqrt((test-train)*(test-train).');
    end
    
    %find k-neighbor and vote
    k = 11;
    [val ind] = sort(dist);
    for j = 1:k
        vote(ytrain(ind(k))+1) = vote(ytrain(ind(k))+1) + 1;
    end
    
    %put result into ytest
    [vote_num vote_ind] = max(vote);
    ytest(i) = vote_ind - 1;
    percentage = i/100
end

%output
temp = 1:10000;
write = [temp.', ytest];
csvwrite('Ytest.csv', write);
