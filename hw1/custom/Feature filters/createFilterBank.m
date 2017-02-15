function [filterBank] = createFilterBank() 
% Code to generate reasonable filter bank

    gaussianScales = [1 2 4 8 sqrt(2)*8];
    logScales      = [1 2 4 8 sqrt(2)*8];
    dxScales       = [1 2 4 8 sqrt(2)*8];
    dyScales       = [1 2 4 8 sqrt(2)*8];
    % two more directions
    daScales= [1 2 4 8 sqrt(2)*8]; % degree= 45
    dbScales= [1 2 4 8 sqrt(2)*8]; % degree= -45
    

    filterBank = cell(numel(gaussianScales) + numel(logScales) + numel(dxScales) + numel(dyScales),1);

    idx = 0;

    for scale = gaussianScales
        idx = idx + 1;
        filterBank{idx} = fspecial('gaussian', 2*ceil(scale*2.5)+1, scale);
    end

    for scale = logScales
        idx = idx + 1;
        %2*ceil(scale*2.5)+1
        filterBank{idx} = fspecial('log', 2*ceil(scale*2.5)+1, scale);
    end
    
countx=0;
    for scale = dxScales
        countx=countx+1;
        idx = idx + 1;
        f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
        fx = imfilter(f, [-1 0 1], 'same');
        filterBankx{countx}=fx;
        filterBank{idx} = fx;
    end
    
county=0;
    for scale = dyScales
        county=county+1;
        idx = idx + 1;
        f = fspecial('gaussian', 2*ceil(scale*2.5) + 1, scale);
        fy= imfilter(f, [-1 0 1]', 'same');
        filterBanky{county}=fy;
        filterBank{idx} = fy;
    end
    
    
    
    
%% two more directions
counta=0;
    for scale = daScales
        counta=counta+1;
        idx = idx + 1;
        f = 0.7071 * filterBankx{counta}+ 0.7071 * filterBanky{counta};
        filterBank{idx} = f;
    end
    
  countb=0;  
    for scale = dbScales
        countb=countb+1;
        idx = idx + 1;
        f = 0.7071 * filterBankx{countb} - 0.7071 * filterBanky{countb};
        filterBank{idx} = f;
    end
    
    % sobel : 3 5 7 9

s3=[1 0 -1;2 0 -2;1 0 -1];
idx = idx + 1;
    filterBank{idx} =s3;
    idx = idx + 1;
       filterBank{idx} =s3';
    s5=    [2   1   0   -1  -2;3   2   0   -2  -3;4   3   0   -3  -4;3   2   0   -2  -3;2   1   0   -1  -2];        
    idx = idx + 1;
    filterBank{idx}=s5;
    idx = idx + 1;
    filterBank{idx}=s5';
    
    s7=[3   2   1   0   -1  -2  -3;4   3   2   0   -2  -3  -4;5   4   3   0   -3  -4  -5;6   5   4   0   -4  -5  -6;5   4   3   0   -3  -4  -5;4   3   2   0   -2  -3  -4;3   2   1   0   -1  -2  -3];
    idx = idx + 1;
    filterBank{idx}=s7;
        idx = idx + 1;
    filterBank{idx}=s7';
    
    s9=[4   3   2   1   0   -1  -2  -3  -4;5   4   3   2   0   -2  -3  -4  -5;6   5   4   3   0   -3  -4  -5  -6;7   6   5   4   0   -4  -5  -6  -7;8   7   6   5   0   -5  -6  -7  -8;7   6   5   4   0   -4  -5  -6  -7;6   5   4   3   0   -3  -4  -5  -6;5   4   3   2   0   -2  -3  -4  -5;4   3   2   1   0   -1  -2  -3  -4];
    idx = idx + 1;
    filterBank{idx}=s9; 
    idx = idx + 1;
    filterBank{idx}=s9';
    
    % Unsharp
    idx = idx + 1;
    f = fspecial('unsharp');
    filterBank{idx}=f;
    
end
