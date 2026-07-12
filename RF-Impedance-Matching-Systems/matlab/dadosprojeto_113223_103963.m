%% CARTA DE SMITH: ENQUADRAMENTO DO PROJETO
%-------------------------------------------------------------------------
% Dados: ZL = 71.1 + j51.1 | f = 962 MHz
%-------------------------------------------------------------------------

% 1. Configuração dos Dados
Z0 = 50;
ZL = 71.1 + 1i*51.1;       %
zL_norm = ZL/Z0;           % 1.42 + j1.02
yL_norm = 1/zL_norm;       % 0.46 - j0.33

% Coeficientes de Reflexão
rho_ZL = (zL_norm - 1) / (zL_norm + 1);
rho_YL = (yL_norm - 1) / (yL_norm + 1);

% 2. Criação da Figura
figure('Name', 'Dados do Trabalho: Carga para Adaptar', 'Color', 'w', 'Position', [100 100 800 700]);
s_frame = smithplot(0,0); % Ponto no centro (índice 1 da legenda)
hold on;

% 3. Desenho da Impedância ZL (Vermelho)
smithplot([0, rho_ZL], 'Color', [1 0 0], 'LineWidth', 2); %
text(real(rho_ZL)-0.05, imag(rho_ZL)+0.08, ...
    sprintf('Z_L = %.2f + j%.2f', real(zL_norm), imag(zL_norm)), ...
    'Color', [1 0 0], 'FontSize', 9, 'FontWeight', 'bold'); %

% 4. Desenho da Admitância YL (Azul)
smithplot([0, rho_YL], 'Color', [0 0 1], 'LineWidth', 2); %
text(real(rho_YL)+0.05, imag(rho_YL)-0.08, ...
    sprintf('Y_L = %.2f - j%.2f', real(yL_norm), abs(imag(yL_norm))), ...
    'Color', [0 0 1], 'FontSize', 9, 'FontWeight', 'bold'); %

% 5. Setas de Sentido (Laranja e Verde) - Sem legendas extra
t_arrow = linspace(0.5, 1.2, 50);
smithplot(1.15 * exp(1i*(pi/2 + t_arrow)), 'Color', [1 0.6 0], 'LineWidth', 1.5); % Sentido Gerador
smithplot(1.15 * exp(1i*(-pi/4 - t_arrow)), 'Color', [0 1 0], 'LineWidth', 1.5); % Sentido Carga

% 6. Controle Estrito da Legenda (Resolve o erro "Cannot access method legend")
% Passamos os nomes para os primeiros 5 elementos. O MATLAB ignora os "datas" seguintes.
nomes = {'', 'Impedância ZL', 'Admitância YL', 'Sentido do Gerador', 'Sentido da Carga'}; %
legend(nomes, 'Location', 'northeastoutside'); %

title({'DADOS DO TRABALHO:','Carga para adaptar (f = 962 MHz)'}); %
grid on;