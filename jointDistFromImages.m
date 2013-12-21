function [joint_dist] = jointDistFromImages(image_A, image_B, num_bins)
%% Map joint pixel values for image_A and image_B into an n*n bin matrix 
    
    %Keeps executing this at every function call unneccessary
    num_pixels = numel(image_A);
    image_linear_A = reshape(image_A,1,num_pixels);
    image_linear_B = reshape(image_B,1,num_pixels);
    joint_dist = zeros(num_bins, num_bins);
    increment = (1/num_pixels);
    
    %Populate histograms for each image by computing bin values per pixel
    a_hist = floor((image_linear_A(:).*num_bins)./256)+1;
    b_hist = floor((image_linear_B(:).*num_bins)./256)+1;
    
    for i=1:num_pixels
        joint_dist(a_hist(i),b_hist(i)) = joint_dist(a_hist(i),b_hist(i)) + increment; 
    end
end