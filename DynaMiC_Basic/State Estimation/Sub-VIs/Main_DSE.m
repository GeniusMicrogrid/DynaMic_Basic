%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%  =====================      DSE Toolbox     =====================   %%%
%%%      Three phase unbalanced distribution state estimation toolbox   %%%
%%%                         Author: Jiaojiao Dong                       %%%
%%%                           Date: SEP 21 2017                         %%%
%%%               For ARPA-E Microgrid Project DSE Function             %%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clear;clc;warning off;global Base;
display('Loading the data, please wait...')
%% Step 1: Input system parameters and power flow results
[Feeder,Ybus,SlackBus,Base,puTrue] = SimuSetup();% SHE215
G = real(Ybus)/Base.Ybase; B = imag(Ybus)/Base.Ybase;
Num.Node                        = Feeder.NumN;
Num.Line                        = Feeder.NumL;
Num.StateVar                    = 3 * 2;  
[Num.Zeroinj, Loc.Zeroinj]      = zeroinjec(puTrue.IN);
[Num1.Zeroinj, Loc1.Zeroinj]    = zeroinjec(puTrue.PN);
Loc.Line                        = Feeder.Topology(:,1:2);
% EPB system intelliRupter Locations
aa = [127,26,109,194,272]'; %% IntelliRupter
bb = [];
for i=1:size(aa,1)
  for j=1:3
    bb=[bb;aa(i),j];
  end
end
idx_rupter = pha2idx(bb,Num.Node);
pha_rupter = bb;
display('Data loaded, please wait...')
%% Step 2: The user settings
iterMax         =    10; % Max Iteration in Newton method
tol             =    1e-3;% tolerance of the Newton Method
%% Step 3: Types,locations, errors of available measurements
SensorError.PN      = 0.06;
SensorError.QN      = 0.06;
SensorError.VN      = 0.0005;
MeaIdx.PN = [1:3*Num.Node]';
MeaIdx.QN = MeaIdx.PN;
MeaIdx.VN = [SlackBus:Num.Node:3*Num.Node]';
MeaIdx.VN = [MeaIdx.VN;idx_rupter]; %% IntelliRupter loc is added
MeaPha.PN = idx2pha(MeaIdx.PN,Num.Node);
MeaPha.QN = idx2pha(MeaIdx.QN,Num.Node);
MeaPha.VN = idx2pha(MeaIdx.VN,Num.Node);
%% Step 4: Creat measure with noise
Noise   = Add_noise(Num,SensorError);
Mea.PN  = puTrue.PN .* Noise.PN; 
Mea.QN  = puTrue.QN .* Noise.QN;
Mea.VN  = puTrue.VN.^2 .* Noise.VN;
Mea.PN  = reshape(Mea.PN,3*Num.Node,1);
Mea.QN  = reshape(Mea.QN,3*Num.Node,1);
Mea.VN  = reshape(Mea.VN,3*Num.Node,1);
measure = [Mea.PN(MeaIdx.PN); Mea.QN(MeaIdx.QN);Mea.VN(MeaIdx.VN)];
Weight  = WeightMatrix(MeaIdx,SensorError);
%% Step 5: Initialize the state variables
[StateVar,~] = Ini_val(Num,puTrue,SlackBus);
%% Step 6: Solve the state estimation
display('Code is running, please wait...')
seResult = funDSE(iterMax,tol,G,B,SlackBus,Num,Loc,...
  measure,Weight,StateVar,MeaPha);
%% Step 7: Display results
DATA=[seResult.VN,seResult.AN];
display('==============Voltage=======================Angle============')
display('==== Phase A  Phase B  Phase C == Phase A  Phase B  Phase C==')
display(DATA)

