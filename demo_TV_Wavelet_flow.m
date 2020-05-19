
close all;
clear;

% parametert settings
ps = parameter_settings();

   
    ps.pyramid_factor = 0.5;
    ps.warps = 5; % the numbers of warps per level
    ps.max_its = 30; % the number of per warp for per level 
    ps.lambda = 11; %[9,10,11]
    ps.noise =1; %  Outliers with the standard deviation \sigma = [0, 1, 2, 3, 4, 5]
    ps.th1 =2;   %  Threshold for low frequency [CA] =[0,1,2,3,4]
    ps.th2 =50;  %  Threshold for high frequency [CH,CV,CD]


show_flow = 1; % 1 : display the evolution of the flow, 0 : do not show
h = figure('Name', 'Optical flow');

I1 = double(imread('data/frame10.png'))/255;
I2 = double(imread('data/frame11.png'))/255;

floPath = 'data/flow10.flo';
% read the ground-truth flow
tflow = readFlowFile(floPath);
tu = tflow(:, :, 1);
tv = tflow(:, :, 2);

[flow] = coarse_to_fine(I1, I2, ps, tu, tv, show_flow, h);

u = flow(:, :, 1);
v = flow(:, :, 2);


% compute the mean end-point error (mepe) and the mean angular error (mang)
UNKNOWN_FLOW_THRESH = 1e9;
[mang, mepe] = flowError(tu, tv, u, v, ...
    0, 0.0, UNKNOWN_FLOW_THRESH);
disp(['Mean end-point error: ', num2str(mepe)]);
disp(['Mean angular error: ', num2str(mang)]);

% display the flow
flowImg = uint8(flowToColor(flow));
figure; imshow(flowImg);
