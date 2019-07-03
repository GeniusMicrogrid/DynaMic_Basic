function Noise = Add_noise(Num,SensorError)
spn = SensorError.PN;
sqn = SensorError.QN;
svn = SensorError.VN;

for i=1:Num.Node
    sspn(i,1)=TruncatedGaussian(spn, [- 3 * spn 3 * spn]);
    ssqn(i,1)=TruncatedGaussian(sqn, [- 3 * sqn 3 * sqn]);
    ssvn(i,1)=TruncatedGaussian(svn, [- 3 * svn 3 * svn]);
end

Noise.PN = [1-sspn , 1-sspn , 1-sspn];
Noise.QN = [1-sspn , 1-sspn , 1-sspn];
Noise.VN = [1-ssvn , 1-ssvn , 1-ssvn];
