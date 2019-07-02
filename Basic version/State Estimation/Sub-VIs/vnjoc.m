function joc_vn = vnjoc(Num,StateVar,MeaPha)
  byphase = MeaPha.VN;
  row_v = size(byphase,1);
  joc_vn = zeros(row_v, Num.StateVar*Num.Node);

  %% Jacobian for Node Voltage
  for row = 1:row_v
    i=byphase(row,1);d=byphase(row,2);
    x=2*Num.Node*(d-1)+2*i-1;y=x+1;
    joc_vn(row,x) =  2 * StateVar(x);
    joc_vn(row,y)   =  2 * StateVar(y);
  end