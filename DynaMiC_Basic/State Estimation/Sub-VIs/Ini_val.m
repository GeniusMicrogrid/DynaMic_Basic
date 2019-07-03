function [InitialValue,StateVar_true]=Ini_val(Num,puTrue,SlackBus)

Ve1 = reshape(puTrue.Ve,3*Num.Node,1);
Vf1 = reshape(puTrue.Vf,3*Num.Node,1);
VV1 = [Ve1,Vf1];
StateVar_true= reshape(VV1',Num.StateVar * Num.Node,1);
       
Ve_temp = zeros(Num.Node,3);
Vf_temp = zeros(Num.Node,3);

for i=1:Num.Node
    for d=1:3
        if puTrue.Ve(i,d) == 0
            Ve_temp(i,d)=0;Vf_temp(i,d)=0;
        else
            if d==1
                Ve_temp(i,d)=0.989*cos(-33.49*pi/180);
                Vf_temp(i,d)=-0.989*sin(-33.49*pi/180);
            end
            if d==2
                Ve_temp(i,d)=0.993*cos(-153.64*pi/180);
                Vf_temp(i,d)=-0.993*sin(-153.64*pi/180);
            end
            if d==3
                Ve_temp(i,d)=0.99*cos(86.14*pi/180);
                Vf_temp(i,d)=-0.99*sin(86.14*pi/180);            
            end
        end
    end
end

Ve1p = reshape(Ve_temp,3*Num.Node,1);
Vf1p = reshape(Vf_temp,3*Num.Node,1);
VV1p = [Ve1p,-Vf1p];
InitialValue = reshape(VV1p',Num.StateVar*Num.Node,1);



