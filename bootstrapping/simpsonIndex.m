function index = simpsonIndex(sizes)
    total = sum(sizes);
    proportions = sizes / total;
    index = sum(proportions.^2);
end