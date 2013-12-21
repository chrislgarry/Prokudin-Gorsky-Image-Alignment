function [bin_proportions] = distributionFromImage(image, num_bins)
%% Map pixel values in image layer into n bins based on value
    image_linear = reshape(image,1,numel(image));
    bin_proportions = histc(image_linear,0:(256/num_bins):256);
    bin_proportions = bin_proportions(1:end-1)/numel(image);
end