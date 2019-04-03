% Clean all residual data
clear all;
close all;
clc;

% parameter library
N_max = 10000;
M=10; %The number of relay
V=10; %Rician Factor
Omega = 1; 
Pj = 5; %Power of Jammer (dBm)
P0 = 15:1:35; %Power of Signal (dBm)
gamma_k = 10; %threshold SNR (dB)
N0 = 0; %Power of noise (dBm)
%beta = 0.5; %time ratio
q = 0.7; % Bernoulli Variance
lambda = 0.1; %Chernoff-bound parameter

% Analysis

pr_anal_sub = zeros(1,length(P0));
pr_simu_sub = zeros(1,length(P0));
pr_simple = zeros(1,length(P0));
pr_anal_sub_infty_3 = zeros(1,length(P0));
pr_anal_sub_infty_5 = zeros(1,length(P0));
pr_anal_sub_infty_7 = zeros(1,length(P0));


%Library (Pr_type_channel_q_N0)

pr_anal_sub_3_3 = [0.922237623589537,0.865266584050771,0.792739578871841,0.713277158635836,0.639167203019247,0.580438140142489,0.540370775342630,0.516264122406250,0.503098873303810,0.496380644748786,0.493091936825423,0.491512942498835,0.490756082386593,0.490388999743337,0.490207106196810,0.490114422670196,0.490065662933210,0.490039122577509,0.490024165700546,0.490015441412166,0.490010179588675];

pr_simu_sub_3_3 = [0.976500000000000,0.944100000000000,0.891700000000000,0.819500000000000,0.733900000000000,0.648200000000000,0.584000000000000,0.547900000000000,0.519400000000000,0.497900000000000,0.499800000000000,0.490900000000000,0.491900000000000,0.490000000000000,0.491200000000000,0.495200000000000,0.496800000000000,0.490200000000000,0.490700000000000,0.484200000000000,0.496300000000000];

pr_anal_sub_6_3 = [0.999764891343086,0.998282168687249,0.991851160605874,0.973812189993778,0.937929185453609,0.880803328263656,0.803421813181332,0.715953737510919,0.635408813535812,0.574392553347976,0.535115863244500,0.512775833576152,0.501121457828127,0.495363044948994,0.492597058063460,0.491279015079498,0.490646435498821,0.490337318675158,0.490182375367376,0.490102332968295,0.490059602915630];

pr_simu_sub_6_3 = [0.999900000000000,0.999500000000000,0.995700000000000,0.985400000000000,0.959200000000000,0.916400000000000,0.849500000000000,0.764300000000000,0.680800000000000,0.601200000000000,0.550500000000000,0.521700000000000,0.508200000000000,0.501300000000000,0.494700000000000,0.490200000000000,0.500000000000000,0.489400000000000,0.489200000000000,0.490400000000000,0.483000000000000];

pr_anal_sub_10_3 = [0.999999996909530,0.999999731651592,0.999988656334239,0.999773011406335,0.997791226126417,0.988638976303185,0.964538667088789,0.920480994077440,0.853731949029531,0.767795490239942,0.678383249726110,0.603900126825047,0.552636892803402,0.522162176926976,0.505826602889159,0.497635749115699,0.493679138045046,0.491795521089681,0.490896636633736,0.490461359198653,0.490245658886821];

pr_simu_sub_10_3 = [1,1,1,0.999900000000000,0.998900000000000,0.993400000000000,0.973900000000000,0.936900000000000,0.883600000000000,0.788400000000000,0.706700000000000,0.627900000000000,0.559300000000000,0.526000000000000,0.508600000000000,0.509100000000000,0.489700000000000,0.497300000000000,0.484700000000000,0.487800000000000,0.491200000000000];

pr_anal_sub_3_5 = [0.835997170939925,0.738719742277105,0.630536001324728,0.523729524130238,0.430200120373453,0.358418778960434,0.310162193839802,0.281315422781788,0.265605660248984,0.257598884948561,0.253681607324345,0.251801317193895,0.250900153695255,0.250463111934968,0.250246560586133,0.250136219440008,0.250078170907092,0.250046574799890,0.250028768821342,0.250018382692703,0.250012118586205];

pr_simu_sub_3_5 = [0.939500000000000,0.864400000000000,0.779600000000000,0.660600000000000,0.549000000000000,0.447000000000000,0.365800000000000,0.316600000000000,0.284600000000000,0.266300000000000,0.255100000000000,0.261300000000000,0.256100000000000,0.244800000000000,0.252800000000000,0.249500000000000,0.248000000000000,0.252600000000000,0.254600000000000,0.256700000000000,0.255000000000000];

pr_anal_sub_6_5 = [0.999355245950353,0.995341670835069,0.978425984177764,0.933945187757940,0.856128543293266,0.753921923764180,0.639303702692486,0.524506111808969,0.424709388519938,0.350886049073542,0.303812200903473,0.277138809205449,0.263245834566374,0.256386085811448,0.253092134544084,0.251522749110881,0.250769599804591,0.250401580743419,0.250217117305804,0.250121826361830,0.250070956405913];

pr_simu_sub_6_5 = [0.999900000000000,0.998700000000000,0.991300000000000,0.966300000000000,0.906400000000000,0.806700000000000,0.703800000000000,0.597200000000000,0.472000000000000,0.387100000000000,0.324900000000000,0.293200000000000,0.271400000000000,0.263200000000000,0.254200000000000,0.256600000000000,0.253700000000000,0.252800000000000,0.250500000000000,0.247500000000000,0.247500000000000];

pr_anal_sub_10_5 = [0.999999991418720,0.999999255189594,0.999968549922120,0.999372612292182,0.993948151013179,0.969602556935497,0.910327656761527,0.818783057648732,0.708562026349348,0.589904777111701,0.477031911248182,0.386330724301566,0.324749552702256,0.288331955657247,0.268851717149675,0.259092790334264,0.254380606404826,0.252137712939464,0.251067479977046,0.250549254662035,0.250292456996092];

pr_simu_sub_10_5 = [1,1,1,0.999700000000000,0.997300000000000,0.978100000000000,0.933200000000000,0.848700000000000,0.744600000000000,0.630300000000000,0.505700000000000,0.413400000000000,0.340600000000000,0.292500000000000,0.272000000000000,0.258300000000000,0.257200000000000,0.254600000000000,0.256400000000000,0.247800000000000,0.250600000000000];

pr_anal_sub_3_7 = [0.722237623589537,0.582793248924095,0.449108453008275,0.335462630747718,0.246503530000760,0.182550254090076,0.140922333618643,0.116400231507756,0.103131810988264,0.0963887067754712,0.0930939812488459,0.0915134889789582,0.0907562381113304,0.0903890473501250,0.0902071218486144,0.0901144282015648,0.0900656650290335,0.0900391234255054,0.0900241660651492,0.0900154415778494,0.0900101796678011];

pr_simu_sub_3_7 = [0.891000000000000,0.762000000000000,0.623200000000000,0.482900000000000,0.344500000000000,0.255700000000000,0.183300000000000,0.142500000000000,0.115300000000000,0.102000000000000,0.0994000000000000,0.0888000000000000,0.0910000000000000,0.0938000000000000,0.0877000000000000,0.0916000000000000,0.0886000000000000,0.0876000000000000,0.0897000000000000,0.0925000000000000,0.0893000000000000];

pr_anal_sub_6_7 = [0.998743275527122,0.990964951401279,0.958606714284034,0.876151415736750,0.741991821829389,0.589106953924507,0.448732803449187,0.331391725539636,0.239899056272267,0.175564979593973,0.135403814959224,0.112845054097569,0.101138268520216,0.0953672687244017,0.0925981745753618,0.0912793289916385,0.0906465299556061,0.0903373491728721,0.0901823859323724,0.0901023368871006,0.0900596044667538];

pr_simu_sub_6_7 = [0.999800000000000,0.998400000000000,0.984400000000000,0.932100000000000,0.811900000000000,0.672000000000000,0.515400000000000,0.394800000000000,0.280200000000000,0.196200000000000,0.152900000000000,0.127900000000000,0.107800000000000,0.0998000000000000,0.0960000000000000,0.0933000000000000,0.0930000000000000,0.0888000000000000,0.0900000000000000,0.0886000000000000,0.0909000000000000];






for Pindex = 1:length(P0)
    
     % Parameters (dbm --> watt)    
    p_Pj = 10^(Pj/10)*10^(-3);
    p_P0 = 10^(P0(Pindex)/10)*10^(-3);
    p_gamma_k = 10^(gamma_k/10);
    p_N0 = 10^(N0/10)*10^(-3);
    
    
    % main
    tau1 = 2*(1-q)*q
    
   % tau3

    tau3 = q^2
    

    
    %tau2

    %initial sum part
    sum_tau2=0;
    %sum part
    for k = 0:1:M-2
        for j = 0:1:M-k-2
            
            sum_tau2 = sum_tau2+ (-1)^j *pochhammer(2+k-M,j) /factorial(j) ...
                     * (p_P0*(M-1)/(p_Pj*p_gamma_k))^((j+k)/2) ...
                     * ((p_P0+p_Pj*p_gamma_k)/p_P0)^k ...
                     * besseli(2+j+k-M, 2*V*sqrt(p_P0*p_Pj*(M-1)*p_gamma_k)/(p_P0+p_Pj*p_gamma_k));
            
        end
    end
                 
    tau2 = 2*(1-q)*q*(1 ...
         + exp(-V*(p_P0+(M-1)*p_Pj*p_gamma_k)/(p_P0+p_Pj*p_gamma_k))*(M-1)*(p_P0+p_Pj*p_gamma_k)/p_P0 ...
         * (p_P0*p_Pj*p_gamma_k/((M-1)*(p_P0+p_Pj*p_gamma_k)^2))^(M/2) ...
         * sum_tau2 ...
         - marcumq(sqrt(2*p_P0*V/(p_P0+p_Pj*p_gamma_k)), ...
           sqrt(2*V*(M-1)*p_Pj*p_gamma_k/(p_P0+p_Pj*p_gamma_k)),1))
    
    % tau4
    

    % initial sum part
    sum_tau4=0;
    %sum part
    for k = 0:1:M-1
        for j = 0:1:M-k-1
                  
            sum_tau4 = sum_tau4 ...
                     + (-1)^j * pochhammer(1+k-M,j) / factorial(j) ...
                     * (p_P0*(M-1)/(2*p_Pj*p_gamma_k))^((j+k)/2) ...
                     * ((p_P0 +p_Pj*p_gamma_k)/p_P0)^k ...
                     * besseli(2+j+k-M, ...
                            2*V*sqrt(2*p_P0*p_Pj*(M-1)*p_gamma_k)/(p_P0+p_Pj*p_gamma_k));
        end
    end
    
    tau4 = q^2 ...
           * (1 ...
           + 2^((M-2)/2) ...
           * exp(-(V*(2*p_P0+(M-1)*p_Pj*p_gamma_k)/(p_P0+p_Pj*p_gamma_k))) ...
           * (M-1)*p_Pj*p_gamma_k/p_P0 ...
           * (p_P0*p_Pj*p_gamma_k/((M-1)*(p_P0+p_Pj*p_gamma_k)^2))^(M/2) ...
           * sum_tau4 ...
           - marcumq(2*sqrt(p_P0*V/(p_P0+p_Pj*p_gamma_k)), ...
           sqrt(2*V*(M-1)*p_Pj*p_gamma_k/(p_P0+p_Pj*p_gamma_k)),2))
    
    %analysis result
    pr_anal_sub(Pindex) = 1-(tau1-tau2+tau3-tau4)
    
        %simulation part
    
    %initial parameters
    outage_counter=0;
    
    for N = 1:N_max
        i_sum_1 = 0;
        i_sum_2 = 0;
        j_2 = 0;
        
        
        for Mindex = 1:M-1
            j_2 = j_2 + (random('rician',sqrt(V/(1+V)*Omega),sqrt(Omega/(2*(V+1)))))^2;
        end
        
        
        
        f_1 = (random('rician',sqrt(V/(1+V)*Omega),sqrt(Omega/(2*(V+1)))))^2;
        f_2 = (random('rician',sqrt(V/(1+V)*Omega),sqrt(Omega/(2*(V+1)))))^2;

       %bernoulli distribution
        i_1 = random('binomial',1,q);
        i_2 = random('binomial',1,q);
       
        
        if (p_P0*i_1*f_1/(2*p_N0+j_2*p_Pj)+p_P0*i_2*f_2/(2*p_N0+j_2*p_Pj))< p_gamma_k
            outage_counter =outage_counter+1;
        end
    end
    pr_simu_sub(Pindex) = outage_counter/N_max
                     
    pr_anal_sub_infty_3(Pindex) = (1-0.3)^2;   
    pr_anal_sub_infty_5(Pindex) = (1-0.5)^2;
    pr_anal_sub_infty_7(Pindex) = (1-0.7)^2;
    
    
end




%plot 
p1=semilogy(P0,pr_anal_sub_3_3,'-');
ax = gca;
ax.FontSize=16;
ax.YLim = [0.03,1];
grid on
p1.Color='Red';
p1.LineWidth=2;
xlabel('Transmission Power (P_0)','FontSize',16)
ylabel('Eavesdropping Channel Transmission Outage Probability','FontSize',12)

hold on;
p2=semilogy(P0,pr_simu_sub_3_3,'v');
p2.Color='Red';
p2.MarkerSize=10;
p2.LineWidth=2;

p3=semilogy(P0,pr_anal_sub_6_3,'-');
p3.Color='Green';
p3.LineWidth=2;

p4=semilogy(P0,pr_simu_sub_6_3,'o');
p4.Color='Green';
p4.MarkerSize=10;

p5=semilogy(P0,pr_anal_sub_10_3,'-');
p5.Color='Blue';
p5.LineWidth=2;

p6=semilogy(P0,pr_simu_sub_10_3,'^');
p6.Color='Blue';
p6.MarkerSize=10;

p7=semilogy(P0,pr_anal_sub_3_5,'-');
p7.Color='Red';
p7.LineWidth=2;

p8=semilogy(P0,pr_simu_sub_3_5,'v');
p8.Color='Red';
p8.MarkerSize=10;

p9=semilogy(P0,pr_anal_sub_6_5,'-');
p9.Color='Green';
p9.LineWidth=2;

p10=semilogy(P0,pr_simu_sub_6_5,'o');
p10.Color='Green';
p10.MarkerSize=10;

p11=semilogy(P0,pr_anal_sub_10_5,'-');
p11.Color='Blue';
p11.LineWidth=2;

p12=semilogy(P0,pr_simu_sub_10_5,'^');
p12.Color='Blue';
p12.MarkerSize=10;

p13=semilogy(P0,pr_anal_sub_3_7,'-');
p13.Color='Red';
p13.LineWidth=2;

p14=semilogy(P0,pr_simu_sub_3_7,'v');
p14.Color='Red';
p14.MarkerSize=10;

p15=semilogy(P0,pr_anal_sub_6_7,'-');
p15.Color='Green';
p15.LineWidth=2;

p16=semilogy(P0,pr_simu_sub_6_7,'o');
p16.Color='Green';
p16.MarkerSize=10;

p17=semilogy(P0,pr_anal_sub,'-');
p17.Color='Blue';
p17.LineWidth=2;

p18=semilogy(P0,pr_simu_sub,'^');
p18.Color='Blue';
p18.MarkerSize=10;

p19=semilogy(P0,pr_anal_sub_infty_3,'--');
p19.Color='Black';
p19.LineWidth=2;

p20=semilogy(P0,pr_anal_sub_infty_5,'--');
p20.Color='Black';
p20.LineWidth=2;

p21=semilogy(P0,pr_anal_sub_infty_7,'--');
p21.Color='Black';
p21.LineWidth=2;

p0=semilogy(P0,pr_simple,'-');
p0.Color='Black';
p0.LineWidth=2;




lgd=legend([p0,p2,p4,p6,p19],'Anal.','M=3','M=6','M=10','P_{out}^{E^\infty} in (16)');
% set(lgd,'Interpreter','latex')
lgd.FontSize=14;
lgd.Location='southwest';

text(33,0.65,'q=0.3 \downarrow','FontSize',14);
text(33,0.35,'q=0.5 \downarrow','FontSize',14);
text(33,0.12,'q=0.7 \downarrow','FontSize',14);

fname = '/users/shin/dropbox/programming/matlab';
saveas(p1,fullfile(fname,'sub_fig'),'fig');
