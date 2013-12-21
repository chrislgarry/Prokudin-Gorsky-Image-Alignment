image_set = {imread('00149v.jpg'),imread('00153v.jpg'),imread('00163v.jpg'),imread('00194v.jpg'),imread('00398v.jpg'),imread('00458v.jpg'),imread('00600v.jpg'),imread('01167v.jpg')}; 
shifts_Green = cell(1,8);
shifts_Red{:} = cell(1,8);
%Set number of bins for joint intensity distribution
num_bins = 256;
%For each Prokudin RGB set
for i=1:numel(image_set)
    %Parse into respective RGB channels
    current_image = image_set{i};
    base = floor(size(current_image,1)/3);
    crop_vector  = [40 40 size(current_image,2)-40 floor(size(current_image,1)/3)-40];
    layer_Blue = imcrop(current_image(1:base,:), crop_vector);
    layer_Green = imcrop(current_image(base+1:floor(base*2),:), crop_vector);
    layer_Red = imcrop(current_image(floor(base*2)+1:end,:), crop_vector);

    %Iterate through all simultaneous x,y shifts of one channel
    max_mut_info_Green = 0;
    max_mut_info_Red = 0;
    for x=-15:1:15
        for y=-15:1:15
            shifted_Red = circshift(layer_Red, [x y]);
            shifted_Green = circshift(layer_Green, [x y]);
            joint_dist_Green = jointDistFromImages(layer_Blue,shifted_Green,num_bins);
            joint_dist_Red = jointDistFromImages(layer_Blue,shifted_Red,num_bins);
            %Compute mutual info from joint distribution of base plane with
            %shifted channel
            mut_info_Green = mutInfo(joint_dist_Green);
            mut_info_Red = mutInfo(joint_dist_Red);
            %Store pixel shift values that yield maximum mutual info
            if mut_info_Green > max_mut_info_Green
                max_mut_info_Green = mut_info_Green;
                shifts_Green{i} = [x y];
            end
            if mut_info_Red > max_mut_info_Red
                max_mut_info_Red = mut_info_Red;
                shifts_Red{i} = [x y];
            end
        end
    end
    image = cat(3,circshift(layer_Red,shifts_Red{i}),circshift(layer_Green, shifts_Green{i}), layer_Blue);
    imshow(image);
    imwrite(image, sprintf('%d_set_%d_bins.png',i,num_bins));
    pause(1)
end