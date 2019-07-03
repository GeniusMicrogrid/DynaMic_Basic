function [joc_pn,joc_qn] = pnjoc(Num,StateVar,MeaPha,B,G)
    byphase = MeaPha.PN;    
    row_p = size(byphase,1);
    joc_pn = zeros(row_p, Num.StateVar*Num.Node); joc_qn = joc_pn;
    
    %% Jacobian for Power injection
    TermA = zeros(row_p,1); TermB = zeros(row_p,1);
    for row = 1:row_p
      i = byphase(row,1);d = byphase(row,2);
      x=2*Num.Node*(d-1)+2*i-1;y=x+1;
        for t = 1:3
            for k = 1:Num.Node 
                 eid = StateVar(x);
                 fid = StateVar(y);
                 xx=2*Num.Node*(t-1)+2*k-1;yy=xx+1;

                 ekt = StateVar(xx);
                 fkt = StateVar(yy);

                 Bikdt = B(y/2,yy/2);
                 Gikdt = G(y/2,yy/2);                     

                 joc_pn(y/2,xx) = (fid*Bikdt+eid*Gikdt);  
                 joc_pn(y/2,yy) =   (fid*Gikdt-eid*Bikdt);  
                 joc_qn(y/2,xx) =   (fid*Gikdt-eid*Bikdt);  
                 joc_qn(y/2,yy) =     (-fid*Bikdt-eid*Gikdt); 
                 TermA(row) =  TermA(row) + Gikdt*ekt - Bikdt*fkt;
                 TermB(row) =  TermB(row) + Gikdt*fkt + Bikdt*ekt;     
            end
        end
        
        
        joc_pn(y/2,x)   =  joc_pn(y/2,x) + TermA(row); 
        joc_pn(y/2,y)   =  joc_pn(y/2,y)   + TermB(row);  
        joc_qn(y/2,x)   =  joc_qn(y/2,x)   - TermB(row);   
        joc_qn(y/2,y)   =  joc_qn(y/2,y)      + TermA(row);    

     end  
     
     