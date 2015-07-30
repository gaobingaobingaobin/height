for i=1:30
    for j=1:30
        for k=1:30
            d(i,j,k)=(i^2+j^2+k^2)^0.5;
        end
    end
end
find d=fix(d)
