function [ meanAngErr meanEndPointErr ] = flowError( tu, tv, u, v, ...
                                                    bord, smallFlowThresh, UNKNOWN_FLOW_THRESH )
%compute the end-point and angular error; 
%   the border pixels, specified with bord parameter, are ignored in evaluation; 
%   the same for flow smaller than flowThresh; 
%   the UNKNOWN_FLOW_THRESH is used to ignore unknown real flow;

tu=tu(bord+1:end-bord,bord+1:end-bord);
tv=tv(bord+1:end-bord,bord+1:end-bord);
u=u(bord+1:end-bord,bord+1:end-bord);
v=v(bord+1:end-bord,bord+1:end-bord);

% ignore a pixel if both u and v are  smaller than smallFlowThresh
%ind2=find((stu(:).*stv(:)|sv(:).*su(:))~=0);
onlyLargeFlowCondition = abs(tu)>smallFlowThresh | abs(tv)>smallFlowThresh;
onlyKnownFlowCondition = abs(tu)<=UNKNOWN_FLOW_THRESH+10 & abs(tv)<=UNKNOWN_FLOW_THRESH+10;

ind2=find(onlyLargeFlowCondition & onlyKnownFlowCondition); 
%length(ind2)
n=1.0./sqrt(u(ind2).^2 + v(ind2).^2+1);
un=u(ind2).*n;
vn=v(ind2).*n;
tn=1./sqrt(tu(ind2).^2 + tv(ind2).^2+1);
tun=tu(ind2).*tn;
tvn=tv(ind2).*tn;
angErr = acos(un.*tun+vn.*tvn+(n.*tn));
meanAngErr = mean(angErr);
meanAngErr = meanAngErr * 180/pi;

%ind1 = find(ignoreUnknownFlowCondition;
epErr = sqrt((tu-u).^2 + (tv-v).^2);
epErr = epErr(ind2);
meanEndPointErr = mean(epErr(:));
    
end

