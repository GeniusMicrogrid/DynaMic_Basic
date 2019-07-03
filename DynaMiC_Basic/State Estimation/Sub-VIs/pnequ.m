function [equ_pn,equ_qn] = pnequ(Num,StateVar,MeaPha,B,G)
  byphase = MeaPha.PN;    
  row_p = size(byphase,1);
  equ_pn = zeros(row_p,1); equ_qn = equ_pn;
  %% Power Injection Measure Equ
  for row = 1:row_p
    i = byphase(row,1) ; d = byphase(row,2);  
    x=2*Num.Node*(d-1)+2*i-1;y=x+1;
    for k = 1:Num.Node
      for t = 1:3
        xx=2*Num.Node*(t-1)+2*k-1;yy=xx+1;
        eid = StateVar(x);
        fid = StateVar(y);
        ekt = StateVar(xx);
        fkt = StateVar(yy);                     
        Bikdt = B(y/2,yy/2);
        Gikdt = G(y/2,yy/2);
        Term1 = fkt*Gikdt+ekt*Bikdt;
        Term2 = ekt*Gikdt-fkt*Bikdt;
        equ_pn(row) = equ_pn(row) + fid*Term1 + eid*Term2;
        equ_qn(row) = equ_qn(row) + fid*Term2 - eid*Term1;
      end
    end    
  end