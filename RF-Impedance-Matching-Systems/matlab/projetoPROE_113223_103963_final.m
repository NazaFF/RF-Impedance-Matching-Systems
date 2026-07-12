% PROJETO: SISTEMAS DE ADAPTAÇÃO DE IMPEDÂNCIAS - PROE
%*************************************************************************
%
% NOME 1:Adriana Pires
% NMEC 1: 113223
% Turma: P6
% 
%*************************************************************************
%
% NOME 2:Tomás Ferreira
% NMEC 2: 103963
% Turma: P6
% 
clear all; close all; clc;
%% 1. DADOS DE ENTRADA E PROJETO
%-------------------------------------------------------------------------
fp = 962;                  % MHz
fmax = 4 * fp;             
Z0 = 50;                   
RL = 71.1;                 
XL_fp = 51.1;              
LL = XL_fp / (2 * pi * fp * 1e6); 
eeff = 1.7779;             
c = 3e8;                   
lambda0_p = c / (fp * 1e6);             
lambdap = lambda0_p / sqrt(eeff);       
ZLp = RL + 1i * XL_fp;                  
rho_L_p = (ZLp - Z0) / (ZLp + Z0); 

% --- Parâmetros dos Sistemas ---

% Sistema 2: Stub CA
d_stub_lambda = 0.226; 
ls_lambda = 0.382;
dp_stub = d_stub_lambda * lambdap; 
lsp = ls_lambda * lambdap;
% Sistema 5: Bobine Série
d_L_lambda = 0.152; 
Lp = 8.4e-9;            %L =8.4 nH
dp_L_m = d_L_lambda * lambdap;
% Sistema 7: Transformador L/4
d_tr_lambda = 0.311; 
Zt = 32.01;
dp_tr = d_tr_lambda * lambdap; 
dquart = 0.25 * lambdap;
dquart_lambda = 0.25;
%% 2. VARRIMENTO EM FREQUÊNCIA E CÁLCULOS
f = 1:1:fmax; 
f_Hz = f * 1e6;
betaf = (2 * pi * f_Hz * sqrt(eeff)) / c;
ZLf = RL + 1i * 2 * pi * f_Hz * LL;

% Impedâncias de Entrada (Zin) 
Zd_stub = Z0*(ZLf + 1i*Z0.*tan(betaf.*dp_stub))./(Z0 + 1i*ZLf.*tan(betaf.*dp_stub));
Zin_1 = 1./((1./Zd_stub) + 1i*(1/Z0).*tan(betaf.*lsp));

Zd_L = Z0*(ZLf + 1i*Z0.*tan(betaf.*dp_L_m))./(Z0 + 1i*ZLf.*tan(betaf.*dp_L_m));
Zin_2 = Zd_L + 1i*2*pi*f_Hz*Lp;

Zd_tr = Z0*(ZLf + 1i*Z0.*tan(betaf.*dp_tr))./(Z0 + 1i*ZLf.*tan(betaf.*dp_tr));
Zin_3 = Zt*(Zd_tr + 1i*Zt.*tan(betaf.*dquart))./(Zt + 1i*Zd_tr.*tan(betaf.*dquart));

rho1_complexo = (Zin_1-Z0)./(Zin_1+Z0); 
rho2_complexo = (Zin_2-Z0)./(Zin_2+Z0); 
rho3_complexo = (Zin_3-Z0)./(Zin_3+Z0); 

% Para os gráficos de magnitude, usamos o valor absoluto
S11_1 = 20*log10(abs(rho1_complexo));
VSWR1 = (1+abs(rho1_complexo))./(1-abs(rho1_complexo)); 
Ptr1 = 1-abs(rho1_complexo).^2; 
RL1 = -S11_1;

S11_2 = 20*log10(abs(rho2_complexo));
VSWR2 = (1+abs(rho2_complexo))./(1-abs(rho2_complexo)); 
Ptr2 = 1-abs(rho2_complexo).^2; 
RL2 = -S11_2;

S11_3 = 20*log10(abs(rho3_complexo));
VSWR3 = (1+abs(rho3_complexo))./(1-abs(rho3_complexo)); 
Ptr3 = 1-abs(rho3_complexo).^2; 
RL3 = -S11_3;

[~, idx_p] = min(abs(f - fp));

S11_fp_1 = S11_1(idx_p);
S11_fp_2 = S11_2(idx_p);
S11_fp_3 = S11_3(idx_p);

%% 3. DISPLAY DOS RESULTADOS

fprintf('\n=================================================================\n');
fprintf('       RELATÓRIO DO PROJETO - FREQUÊNCIA DE %d MHz\n', fp);
fprintf('=================================================================\n');
fprintf('PARÂMETROS :\n');
fprintf(' -> Impedância da Carga (ZL) : %.1f + j%.1f Ohms\n', RL, XL_fp);
fprintf(' -> Lambda no vácuo          : %.2f cm\n', lambda0_p * 100);
fprintf(' -> Lambda na microstrip     : %.2f cm\n', lambdap * 100);
fprintf('-----------------------------------------------------------------\n');
fprintf('SISTEMA 1 (STUB EM CIRCUITO ABERTO):\n');
fprintf(' -> Distância d              : %.3f lambda (%.2f cm)\n', d_stub_lambda, dp_stub * 100);
fprintf(' -> Comprimento do Stub      : %.3f lambda (%.2f cm)\n', ls_lambda, lsp * 100);
fprintf(' -> S11 @ %d MHz             : %.2f dB\n', fp, S11_fp_1);
fprintf('-----------------------------------------------------------------\n');
fprintf('SISTEMA 2 (Bobine EM SÉRIE):\n');
fprintf(' -> Distância d              : %.3f lambda (%.2f cm)\n', d_L_lambda, dp_L_m * 100);
fprintf(' -> Indutância               : %.2f nH\n', Lp * 1e9);
fprintf(' -> S11 @ %d MHz             : %.2f dB\n', fp, S11_fp_2);
fprintf('-----------------------------------------------------------------\n');
fprintf('SISTEMA 3 (TRANSFORMADOR LAMBDA/4):\n');
fprintf(' -> Distância ao Mínimo (d)  : %.3f lambda (%.2f cm)\n', d_tr_lambda, dp_tr * 100);
fprintf(' -> Comprimento L/4          : %.3f lambda (%.2f cm)\n', dquart_lambda, dquart * 100);
fprintf(' -> Impedância Zt            : %.2f Ohms\n', Zt);
fprintf(' -> S11 @ %d MHz             : %.2f dB\n', fp, S11_fp_3);
fprintf('=================================================================\n\n');

%% 4. CARTAS DE SMITH 
%% VARRIMENTO NA CARTA DE SMITH (1-4000 MHz)
%-------------------------------------------------------------------------
figure('Name', 'Varrimento na Carta de Smith', 'Color', 'w', 'Units', 'normalized', 'Position', [0.1 0.3 0.8 0.4]);

% Sistema 1: Stub
subplot(1,3,1); 
smithplot(f_Hz, rho1_complexo, 'Color', 'b', 'LineWidth', 1.2); hold on;

smithplot(fp*1e6, rho1_complexo(idx_p), 'Marker', 'o', 'MarkerSize', 10, 'Color', 'r'); 
title('1 - Stub C.A');

% Sistema 2: Bobine
subplot(1,3,2); 
smithplot(f_Hz, rho2_complexo, 'Color', 'm', 'LineWidth', 1.2); hold on;

smithplot(fp*1e6, rho2_complexo(idx_p), 'Marker', 'o', 'MarkerSize', 10, 'Color', 'r'); 
title('2 - Bobine em série');

% Sistema 3: Transf L/4
subplot(1,3,3); 
smithplot(f_Hz, rho3_complexo, 'Color', 'g', 'LineWidth', 1.2); hold on;

smithplot(fp*1e6, rho3_complexo(idx_p), 'Marker', 'o', 'MarkerSize', 10, 'Color', 'r'); 
title('3 - Transf \lambda/4');

%% 5. GRÁFICOS INDIVIDUAIS POR SISTEMA

% Stub em circuito aberto
figure('Name','Stub em CA','Color','w');

subplot(2,2,1); 
plot(f,S11_1,'b'); 
hold on; grid on; 
plot(f(idx_p),S11_1(idx_p),'ro','MarkerFaceColor','r'); 

text(f(idx_p)+20, S11_1(idx_p), sprintf('%.2f dB', S11_fp_1));

title('S_{11} (dB)');

subplot(2,2,2); 
plot(f,VSWR1,'b'); 
hold on; 
grid on; 
plot(f(idx_p),VSWR1(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, VSWR1(idx_p), sprintf('%.2f', VSWR1(idx_p)));
title('VSWR'); 
ylim([1 10]);

subplot(2,2,3); 
plot(f,Ptr1,'b'); 
hold on; 
grid on; 
plot(f(idx_p),Ptr1(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, Ptr1(idx_p), sprintf('%.2f', Ptr1(idx_p)));
title('Potência Transmitida');

subplot(2,2,4); 
plot(f,RL1,'b'); 
hold on; 
grid on; 
plot(f(idx_p),RL1(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, RL1(idx_p), sprintf('%.2f dB', RL1(idx_p)));
title('Return Loss (dB)');

sgtitle('SISTEMA 2: Stub em Circuito Aberto');

% L em serie com a linha
figure('Name','Bobine Série','Color','w');

subplot(2,2,1); 
plot(f,S11_2,'m'); 
hold on; 
grid on; 
plot(f(idx_p),S11_2(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, S11_2(idx_p), sprintf('%.2f dB', S11_fp_2));
title('S_{11} (dB)');

subplot(2,2,2); 
plot(f,VSWR2,'m'); 
hold on; 
grid on; 
plot(f(idx_p),VSWR2(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, VSWR2(idx_p), sprintf('%.2f', VSWR2(idx_p)));
title('VSWR'); 
ylim([1 10]);

subplot(2,2,3); 
plot(f,Ptr2,'m'); 
hold on; 
grid on; 
plot(f(idx_p),Ptr2(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, Ptr2(idx_p), sprintf('%.2f', Ptr2(idx_p)));
title('Potência Transmitida');

subplot(2,2,4); 
plot(f,RL2,'m'); 
hold on; 
grid on; 
plot(f(idx_p),RL2(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, RL2(idx_p), sprintf('%.2f dB', RL2(idx_p)));
title('Return Loss (dB)');

sgtitle('SISTEMA 2: Bobine em Série');

% Transformador L/4 num ponto de minimo
figure('Name','Transf. L/4','Color','w');

subplot(2,2,1); 
plot(f,S11_3,'g'); 
hold on; 
grid on; 
plot(f(idx_p),S11_3(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, S11_3(idx_p), sprintf('%.2f dB', S11_fp_3));
title('S_{11} (dB)');

subplot(2,2,2); 
plot(f,VSWR3,'g'); 
hold on; 
grid on; 
plot(f(idx_p),VSWR3(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, VSWR3(idx_p), sprintf('%.2f', VSWR3(idx_p)));
title('VSWR'); 
ylim([1 10]);

subplot(2,2,3); 
plot(f,Ptr3,'g'); 
hold on; 
grid on; 
plot(f(idx_p),Ptr3(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, Ptr3(idx_p), sprintf('%.2f', Ptr3(idx_p)));
title('Potência Transmitida');

subplot(2,2,4); 
plot(f,RL3,'g'); 
hold on; 
grid on; 
plot(f(idx_p),RL3(idx_p),'ro','MarkerFaceColor','r'); 
text(f(idx_p)+20, RL3(idx_p), sprintf('%.2f dB', RL3(idx_p)));
title('Return Loss (dB)');


sgtitle('SISTEMA 3: Transformador \lambda/4');

%% 6. GRÁFICOS COMPARATIVOS 

figure('Name','Comparação','Color','w','Position',[50 50 1000 750]);

subplot(2,2,1); % S11
plot(f,S11_1,'b', f,S11_2,'m', f,S11_3,'g','LineWidth',1.5); 
hold on; 
grid on;
plot(f(idx_p), S11_1(idx_p), 'ro', 'MarkerFaceColor', 'r'); 

text(f(idx_p)+20, S11_1(idx_p), sprintf('%.2f dB', S11_fp_1));
text(f(idx_p)+20, S11_2(idx_p), sprintf('%.2f dB', S11_fp_2));
text(f(idx_p)+20, S11_3(idx_p), sprintf('%.2f dB', S11_fp_3));

title('S_{11} (dB)'); ylabel('dB'); xlabel('Freq (MHz)'); 
legend('Stub','Bobine','Transf','fp');

subplot(2,2,2); % VSWR
plot(f,VSWR1,'b', f,VSWR2,'m', f,VSWR3,'g','LineWidth',1.5); 
hold on; 
grid on;
plot(f(idx_p), VSWR1(idx_p), 'ro', 'MarkerFaceColor', 'r');
text(f(idx_p)+20, VSWR1(idx_p), sprintf('%.2f', VSWR1(idx_p)));
text(f(idx_p)+20, VSWR2(idx_p), sprintf('%.2f', VSWR2(idx_p)));
text(f(idx_p)+20, VSWR3(idx_p), sprintf('%.2f', VSWR3(idx_p)));
title('VSWR'); 
ylabel('Razão'); 
xlabel('Freq (MHz)'); 
ylim([1 10]);

subplot(2,2,3); % Potência Transmitida
plot(f,Ptr1,'b', f,Ptr2,'m', f,Ptr3,'g','LineWidth',1.5); 
hold on; 
grid on;
plot(f(idx_p), Ptr1(idx_p), 'ro', 'MarkerFaceColor', 'r');
text(f(idx_p)+20, Ptr1(idx_p), sprintf('%.2f', Ptr1(idx_p)));
text(f(idx_p)+20, Ptr2(idx_p), sprintf('%.2f', Ptr2(idx_p)));
text(f(idx_p)+20, Ptr3(idx_p), sprintf('%.2f', Ptr3(idx_p)));
title('Fração de Potência Transmitida'); 
ylabel('P_{tr}/P_{inc}'); 
xlabel('Freq (MHz)');

subplot(2,2,4); % Return Loss
plot(f,RL1,'b', f,RL2,'m', f,RL3,'g','LineWidth',1.5); 
hold on; 
grid on;
plot(f(idx_p), RL1(idx_p), 'ro', 'MarkerFaceColor', 'r');
text(f(idx_p)+20, RL1(idx_p), sprintf('%.2f dB', RL1(idx_p)));
text(f(idx_p)+20, RL2(idx_p), sprintf('%.2f dB', RL2(idx_p)));
text(f(idx_p)+20, RL3(idx_p), sprintf('%.2f dB', RL3(idx_p)));
title('Return Loss (dB)'); 
ylabel('dB'); 
xlabel('Freq (MHz)');

%% *********************** Comentários dos resultados **********************
% O presente projeto permitiu validar, de forma consistente, três metodologias distintas
% de adaptação de impedâncias — stub em circuito aberto, bobine em série e transformador
% de λ/4 — evidenciando que todas convergem para uma adaptação eficaz na
% frequência de projeto (962 MHz), com valores de S11 inferiores a -25 dB, o que traduz
% uma reflexão praticamente nula (-20 dB´s => 1% pot. refletida, -30 dB´s => 0.1% pot. refletida)
% e consequentemente máxima transferência de potência.
% 
% A análise em frequência demonstrou, no entanto, diferenças relevantes no comportamento
% fora da frequência de projeto. O sistema com bobine em série apresentou maior largura
% de banda, revelando menor sensibilidade a desvios de frequência, enquanto o stub e o 
% transformador λ/4 evidenciaram comportamentos mais seletivos e periódicos, típicos
% de estruturas baseadas em linhas de transmissão. Esta diferença é claramente visível
% nos gráficos, onde o sistema com bobine mantém valores de S11 reduzidos numa gama
% de frequências mais alargada, enquanto os restantes apresentam variações mais
% abruptas em torno da frequência de projeto. 
%
%Os gráficos de VSWR, potência transmitida e return loss corroboram estas conclusões.
% Em particular, observa-se que, na frequência de projeto, o VSWR aproxima-se de 1,
% a potência transmitida tende para o máximo (próxima de 100%) e o return loss apresenta
% valores elevados, confirmando a eficiência da adaptação. Fora da frequência de projeto,
% estas grandezas evidenciam novamente a maior robustez do sistema com bobine e a maior
% seletividade dos sistemas baseados em linhas.
% 
% As cartas de Smith confirmaram graficamente o processo de adaptação, mostrando
% a evolução da impedância desde a carga até ao centro da carta (Z0 = 50 ohm), independentemente
% do método utilizado, reforçando a coerência entre a análise teórica e os
% resultados simulados.
% 
% Em termos práticos, conclui-se que a escolha do método de adaptação depende do 
% compromisso entre largura de banda, sensibilidade a variações de frequência,
% complexidade de implementação e custo, nomeadamente ao nível das dimensões das linhas
% microstrip e tolerâncias dos componentes discretos: soluções distribuídas 
% (stub e transformador) são mais simples de integrar em microstrip,
% mas apresentam maior seletividade, enquanto soluções com componentes discretos (bobine)
% oferecem maior robustez em frequência, sendo mais adequada para aplicações com 
% requisitos de maior largura de banda.
% 
% Este trabalho permitiu consolidar conceitos fundamentais de linhas de transmissão 
% e adaptação de impedâncias, destacando a importância de uma análise conjunta entre 
% domínio da frequência e representação gráfica na carta de Smith.
