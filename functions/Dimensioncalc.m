%Dimensions Calculator Lots of Innacuracy due to not accounting for things
%For the moment does not account for K lambda
mdot= input('Enter mass flow rate: ');
pressuret=input('Enter Pressure drop: ');%liquid overpressure/pressure drop
rho=input('Enter density of fluid: ');
kvisco=input('Enter kinematic viscosity of fluid: ');%kinematic viscosity
K=input('Enter K based on desired spray cone angle: ');%Injector geometry constant
fillingco=input('***DEBUG*** Enter fillingco: ');
numinlet= 4;%number of inlet holes     v---- Inverse function of K(filling coefficient) bayvel 261 using finverse function
%fillingco=((((2^(1/2)/(2*K) - (2*2^(1/2))/(27*K^3))^2 - 8/(729*K^6))^(1/2) + 2^(1/2)/(2*K) - (2*2^(1/2))/(27*K^3))^(1/3) - 2^(1/2)/(3*K) + 2/(9*K^2*(((2^(1/2)/(2*K) - (2*2^(1/2))/(27*K^3))^2 - 8/(729*K^6))^(1/2) + 2^(1/2)/(2*K) - (2*2^(1/2))/(27*K^3))^(1/3)))^2;
dischargeco=fillingco*sqrt(fillingco/(2-fillingco));%discharge coefficient
do=sqrt((4*mdot)/(pi*dischargeco*sqrt(2*rho*pressuret)));%diameter of orifice
R=3*(do/2);%assumption based on Bayvel 263
dp=sqrt((2*R*do)/(K*numinlet));%diameter of inlet
d=sqrt(numinlet)*dp;%total diameter/diameter of hole if there was just one inlet
vp=(4*mdot)/(pi*rho*numinlet*(dp^2));%velocity at inlet?
alpha=2*atand((2*sqrt(2)*(1-fillingco))/(sqrt(fillingco)*(1+sqrt(1-fillingco))));%spray cone angle just to make sure
Re=(4*mdot)/(pi*rho*kvisco*sqrt(numinlet)*dp);%Reynolds number
frictco=10^((25.8/((log10(Re))^2.58))-2);%friction coefficient
dprimep=dp/.87;%bayvel 264
Ds=2*R+dprimep;%diameter of swirl chamber
ls=2*dprimep;%length of inlet orifice
if K<4
    l=.7*do;        %length of discharge orifice
else
    l=.37*do;
end
disp(['Inlet Diameter: ',num2str(dp),'m or ft'])%units "Shouldn't" matter as long as inputs were consistent
disp(['Orifice Diameter: ',num2str(do),'m or ft'])% if orifice diameter = swirler diameter, the injector is open-type, else it is closed type
disp(['Spray angle: ',num2str(alpha),'degrees'])
disp(['Swirl Chamber Diameter: ',num2str(Ds),'m or ft'])
disp(['Length of inlet orifice: ',num2str(ls),'m or ft'])