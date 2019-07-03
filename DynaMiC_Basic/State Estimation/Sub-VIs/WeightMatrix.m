function R = WeightMatrix(MeaIdx,SensorError)
WPN = SensorError.PN*ones(size(MeaIdx.PN));
WQN = SensorError.QN*ones(size(MeaIdx.QN));
WVN = SensorError.VN*ones(size(MeaIdx.VN));

R =diag([WPN.^2;WQN.^2;WVN.^2]);
    
    