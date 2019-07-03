function [equ_c,equ_d] = cequ(Num,StateVar,B,G,Loc)
  byphase = Loc.Zeroinj;    
  row_p = size(byphase,1);
  equ_c = zeros(row_p,1); equ_d = equ_c;
  %%  
for row=1:row_p
  i=byphase(row,1); d=byphase(row,2);
  x=2*Num.Node*(d-1)+2*i-1;y=x+1;
  for k = 1:Num.Node
    for t = 1:3
      xx=2*Num.Node*(t-1)+2*k-1;yy=xx+1;
      ekt = StateVar(xx);
      fkt = StateVar(yy);                     
      Bikdt = B(y/2,yy/2);
      Gikdt = G(y/2,yy/2);
      equ_c(row) =  equ_c(row) + Gikdt*ekt - Bikdt*fkt;
      equ_d(row) =  equ_d(row) + Gikdt*fkt + Bikdt*ekt;
    end
  end                
end