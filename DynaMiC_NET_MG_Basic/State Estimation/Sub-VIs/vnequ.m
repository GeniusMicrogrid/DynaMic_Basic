function equ_vn = vnequ(Num,StateVar,MeaPha)
  byphase = MeaPha.VN;    
  row_v = size(byphase,1);
  equ_vn = zeros(row_v,1);

  for row = 1: row_v
    i = byphase(row,1); d = byphase(row,2);
    equ_vn(row) = StateVar(2*Num.Node*(d-1)+2*i-1).^2+StateVar(2*Num.Node*(d-1)+2*i).^2;
  end
