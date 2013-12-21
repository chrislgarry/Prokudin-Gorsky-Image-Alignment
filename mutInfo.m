function [mutual_information] = mutInfo(joint_distribution)
% Compute mutual information between two discrete random variables A and B.
    
    %Marginals for each random variable
    marginals_A = sum(joint_distribution,2); %Rows
    marginals_B = sum(joint_distribution,1)';%Cols
    
    %Marginal products for each pair in joint distribution
    marginals = (marginals_A(:))*(marginals_B(1:1:end))';
    
    %Convert matrices to linear array
    joint_distribution_linear = reshape(joint_distribution,1,numel(joint_distribution));
    marginals_linear = reshape(marginals,1,numel(marginals));
    
    %Remove elements that do not contribute to mutual information
    marginals_linear = marginals_linear(joint_distribution_linear~=0);
    joint_distribution_linear = joint_distribution_linear(joint_distribution_linear~=0);
    
    %Compute mutual information
    mutual_information = sum(joint_distribution_linear.*(log2(joint_distribution_linear./marginals_linear)));

end
