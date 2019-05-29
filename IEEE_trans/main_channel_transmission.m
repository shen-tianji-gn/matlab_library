close all;
clc;

%% Parameter library
N_max = 100000;
M=5; %All relays
K=3; %Number of transmission
n=3; %Number of jammers
Pj = 5; %Power of Jammer (dBm)
P0 = 0:1:20; %Power of Signal (dBm)
gamma_th = 10; %threshold SNR (dB)
N0 = 0; %Power of noise (dBm)
q = 0.3; % Bernoulli Variance
kappa=0.3;

% Channel -- Rician
V = 5; % Rician factor
Omega = 1; % Rician omega


%% Initial Parameters

% ORS
pr_anal_ORS_outage = zeros(1,length(P0));
pr_simu_ORS_outage = zeros(1,length(P0));

% ORSJ
pr_anal_ORSJ_outage = zeros(1,length(P0));
pr_simu_ORSJ_outage = zeros(1,length(P0));

% ORSMJ

pr_anal_ORSMJ_outage = zeros(1,length(P0));
pr_simu_ORSMJ_outage = zeros(1,length(P0));

% MRCMJ

pr_anal_MRCMJ_outage = zeros(1,length(P0));
pr_simu_MRCMJ_outage = zeros(1,length(P0));


%% Program Start

for Pindex = 1 : length(P0)
    
    
    %% Parameters  (dBm --> Watt)
    p_Pj = 10^(Pj / 10)*10^(-3); % Jammer
    p_P0 = 10^(P0(Pindex)/10)*10^(-3); % Transmitter
    p_N0 = 10^(N0/10)*10^(-3); % Noise
    p_gamma_th = 10^(gamma_th/10); % threshold SNR
    
    %% Analysis
    
    % ORS
    
    
    % one hop outage
    p_out_one_ORS = 1 - marcumq(sqrt(2*V),sqrt(2*(V+1)/Omega)*sqrt(p_N0*p_gamma_th/(kappa*p_P0)));
    
    pr_anal_ORS_outage = 1 - (1 - (p_out_one_ORS)^M)*(1-p_out_one_ORS);
    
    
    % ORSJ
    
    p_out_one_ORSJ = 1 ...
                     - p_P0 * Omega* besseli(0,2 * V * sqrt(p_P0 * p_Pj * p_gamma_th)/(p_P0 + p_Pj * p_gamma_th)) ...
                     / ((V+1) * (p_P0 + p_Pj * p_gamma_th)) ...
                     - exp(V) * Omega * ...
                     (1 - marcumq(sqrt(2*V*p_Pj*p_gamma_th/(p_P0 + p_Pj * p_gamma_th))))/(1+V);
    
    pr_anal_ORSJ_outage = 1 - (1 - (p_out_one_ORSJ)^M)...
                        * (1- p_out_one_ORSJ);
                 
    
    %% Simulation 
    
    % ORS
    
    
    % Initial parameter
    outage_counter_ORS = 0;
    outage_counter_ORSJ = 0;
    
    for N = 1:N_max
        
        % ORS
        
        
        
        % Initial parameters
        
        % h
        h_max = 0;
        
        
        for n_count = 1:n
            h_k = (random('rician', ...
                            sqrt(V*Omega/(1+V)),sqrt(Omega/(2*(V+1)))))^2;
            
            if h_k > h_max
                h_max = h_k;
            end
        end
        
        
        % g
        g_k = (random('rician', sqrt(V*Omega/(1+V)),sqrt(Omega/(2*(V+1)))))^2;
        
        
        
        gamma_inst_s_r = kappa * p_P0 * h_max / p_N0;
        
        gamma_inst_r_d = kappa * p_P0 * g_k / p_N0;
        
        gamma_inst = min(gamma_inst_s_r,min_inst_r_d);
        
        
        if gamma_inst < p_gamma_th
            outage_counter_ORS = outage_counter_ORS + 1;
        end
        
        
        % ORSJ
        
        
        
        
        
        
        
        
        
        
        
        
    end
    
    
    pr_simu_ORS_outage = outage_counter_ORS / N_max;
    
    
    
    
end


%% Plot



