function seResult = funDSE(iterMax,tol,G,B,SlackBus,Num,Loc,...
  measure,Weight,StateVar,MeaPha)
  
for i = 1:iterMax
  % Jocobian matrix
  [joc_pn,joc_qn] = pnjoc(Num,StateVar,MeaPha,B,G);
  joc_vn          = vnjoc(Num,StateVar,MeaPha);
  H = [joc_pn;joc_qn;joc_vn];
  H(:,2*SlackBus:2*Num.Node:end)=0;   
  H(:,2*SlackBus-1:2*Num.Node:end)=0; 

  % MeaEqu
  [equ_pn,equ_qn] = pnequ(Num,StateVar,MeaPha,B,G);
  equ_vn = vnequ(Num,StateVar,MeaPha);
  MeaEqu = [equ_pn;equ_qn;equ_vn];
  
  delta_z = measure-MeaEqu;
  G2 = H'/Weight*delta_z;
  G3 = H'/Weight*H;    
  Ginv = pinv(G3);
  
  [joc_c,joc_d] = cjoc(Num,B,G,Loc);
  C = [joc_c;joc_d];
  C(:,2*SlackBus:2*Num.Node:end)=0;
  C(:,2*SlackBus-1:2*Num.Node:end)=0;
  [equ_c,equ_d] = cequ(Num,StateVar,B,G,Loc);
  delta_c = [-equ_c;-equ_d];  
  C_temp1 = C*Ginv*C';
  C_temp2 = pinv(C_temp1);
  deltaX = Ginv * G2 -Ginv*C'*(C_temp2*(C*Ginv*G2-delta_c)); 

  deltaX(abs(deltaX)<1e-8)=0;
  tol_temp = max(abs(deltaX));
  if tol_temp < tol
      break;
  end
  StateVar = StateVar + deltaX;
end

tempVe=StateVar(1:2:6*Num.Node-1);
tempVf=StateVar(2:2:6*Num.Node);
seResult.Ve=reshape(tempVe,Num.Node,3);
seResult.Vf=reshape(tempVf,Num.Node,3);
seResult.VOL=seResult.Ve+1i*seResult.Vf;
seResult.AN=angle(seResult.VOL);
seResult.VN=abs(seResult.VOL);
return
