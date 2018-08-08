function output = crossProduct(Vec)

output = [];
for i=1:length(Vec)
    inter = zeros(1, length(Vec));
    inter(i) = Vec(i);
    last = [];
    for j=1:length(Vec)
        help = zeros(1, length(Vec));
        help(j) = Vec(j);
        cr = cross(inter, help);
        index = find(cr ~= 0);
        if length(index) == 0
            last = [last, 0];
        else
            last = [last, cr(index)];
        end 
    end
    output = [output;last];
end

end