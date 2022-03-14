function out = saturate(in,mn,mx)
in(in>mx)=mx;
in(in<mn)=mn;
out=in;