function [ normalized] = normalize(vector)
    normalized = vector./norm(vector);
end

