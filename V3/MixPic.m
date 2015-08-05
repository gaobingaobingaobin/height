function[pic] = MixPic(pc1_1,pc2_1,f_c,f_r)
%f_c:p1_1和p1_2之间列的差别，－7等价于p1_2左移动7个单位与p1_1重合
%f_r:两张图行之间的差别
[row,col,color] = size(pc1_1);
a_c = abs(f_c);
a_r = abs(f_r);
%f_r=0;f_c=7;
%%%补列
if a_c 
    for i=1:row
        for j=1:a_c
            for k=1:color
                m(i,j,k) = uint8(1);
            end
        end
    end
    if f_c<0
        pic = [pc1_1,m];
    end
    if f_c>0
        pic = [m,pc1_1];
end
%%补行
if a_r
    for i=1:a_r
        for j=1:col
            for k=1:color
                n(i,j,k) = uint8(1);
            end
        end
    end
    if f_r<0
        pic = [pc1_1;n];
    end
    if f_r>0
        pic = [n;pc1_1];
end
%%补小块下角
if a_r&&a_c
    for i=1:a_r
        for j=1:a_c
            for k=1:color
                p(i,j,k) = uint8(1);
            end
        end
    end
    if f_c<0&&f_r<0
        pic = [pc1_1,m;n,p];
    end
    if f_c>0&&f_r<0
        
end
    
