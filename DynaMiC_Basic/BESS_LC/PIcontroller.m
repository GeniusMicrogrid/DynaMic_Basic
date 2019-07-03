function [PIoutput PIintegrator] = PIcontroller(Kp,Ki,PIError,PIintegratorIn,Ts)

	PIintegrator = PIintegratorIn + PIError*Ki*Ts;
	PIoutput = PIintegrator + PIError*Kp;


