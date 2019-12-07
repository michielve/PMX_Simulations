$PARAM @annotated
TVKA : 1 : Absorption rate constant
TVCL : 1 : Clearance
TVVC : 1 : Central volume
TVVP1 : 1 : Peripheral volume 1
TVVP2 : 1 : Peripheral volume 2
TVQ1 : 1 : Intercompartmental clearance 1
TVQ2 : 1 : Intercompartmental clearance 2

$CMT GUT CENT P1 P2

$MAIN
// Define parameters
double KA = TVKA*exp(ETA(1));
double CL = TVCL*exp(ETA(2));
double VC = TVVC*exp(ETA(3));
double VP1 = TVVP1*exp(ETA(4));
double VP2 = TVVP2*exp(ETA(5));
double Q1 = TVQ1*exp(ETA(6));
double Q2 = TVQ2*exp(ETA(7));


// Define rate constants
double k10 = CL/VC;

double k12 = Q1/VC;
double k21 = Q1/VP1;

double k13 = Q2/VC;
double k31 = Q2/VP2;


// Define omega and sigma
$OMEGA 0 0 0 0 0 0 0
$SIGMA @labels PROP ADD
0 0



$ODE
// Define ODEs for a 3-cmt model with depot compartment
dxdt_GUT = -KA*GUT;
dxdt_CENT = KA*GUT -k12*CENT+k21*P1-k13*CENT+k31*P2 - k10*CENT;
dxdt_P1 = k12*CENT-k21*P1;
dxdt_P2 = k13*CENT-k31*P2;


$TABLE
double IPRED = CENT/VC;
double DV = IPRED*(1+PROP)+ADD;

// If negative simulation - repeat sigma
while(DV < 0) {
  simeps();
  DV = IPRED*(1+PROP)+ADD;
}


$CAPTURE IPRED DV
