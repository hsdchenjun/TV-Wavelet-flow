 % ��ֵ������absС��thres�� ��ֵ 0
function [val]=thres_shrink(data,thres)
    val=data;
    val(abs(data)<thres)=0;
end