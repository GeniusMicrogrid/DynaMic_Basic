function [Feeder,Ybus,SlackBus,Base,puTrue] = SimuSetup()
load('EPBSHE215.mat');
SlackBus=67;  
Base.Sbase = abs(P_node(SlackBus,1));
Base.Vbase = abs(V_node(SlackBus,1));
Base.Ibase=Base.Sbase/Base.Vbase;
Base.Ybase =  Base.Sbase/Base.Vbase^2;

puTrue.VOL=V_node/Base.Vbase;
puTrue.PN=real(P_node)/Base.Sbase;
puTrue.QN=imag(P_node)/Base.Sbase;
puTrue.IN=abs(I_node)/Base.Ibase;
puTrue.Ve=real(puTrue.VOL);
puTrue.Vf=imag(puTrue.VOL); 
puTrue.VN=abs(puTrue.VOL);
puTrue.AN=angle(puTrue.VOL);

puTrue.PN(abs(puTrue.PN)<1e-8)=0;
puTrue.QN(abs(puTrue.QN)<1e-8)=0;
puTrue.IN(abs(puTrue.IN)<1e-8)=0;





