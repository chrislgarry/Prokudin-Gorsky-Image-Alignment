function [entropy] = entropy(distribution)
%% Compute the entropy of a discrete probability distribution in bits.
    %Remove discrete probabilities of zero which do not contribute to entropy.
    distribution = distribution(distribution~=0);
    %Compute entropy
    entropy = -sum(distribution.*log2(distribution));
end