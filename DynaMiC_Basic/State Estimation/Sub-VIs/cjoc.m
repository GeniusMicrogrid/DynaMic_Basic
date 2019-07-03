function [joc_c,joc_d] = cjoc(Num,B,G,Loc)        
  joc_c=zeros(Num.Zeroinj, Num.StateVar*Num.Node);joc_d=joc_c;
  for row=1:size(Loc.Zeroinj,1)
    i=Loc.Zeroinj(row,1);
    d=Loc.Zeroinj(row,2);
    x=2*Num.Node*(d-1)+2*i-1;y=x+1;
    for k=1:Num.Node
      for t=1:3
        xx=2*Num.Node*(t-1)+2*k-1;yy=xx+1;
        Gikdt = G(y/2,yy/2);
        Bikdt = B(y/2,yy/2);                    
        joc_c(row,xx)=Gikdt;
        joc_c(row,yy)=-Bikdt;
        joc_d(row,xx)=Bikdt; 
        joc_d(row,yy)=Gikdt;                    
      end
    end           
  end