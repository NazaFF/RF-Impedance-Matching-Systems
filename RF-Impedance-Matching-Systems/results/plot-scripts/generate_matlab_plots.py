import numpy as np
import matplotlib.pyplot as plt

# === Exact parameters and formulas from projetoPROE_113223_103963_final.m ===
fp = 962.0                    # MHz
fmax = 4 * fp
Z0 = 50.0
RL = 71.1
XL_fp = 51.1
LL = XL_fp / (2 * np.pi * fp * 1e6)
eeff = 1.7779
c = 3e8
lambda0_p = c / (fp * 1e6)
lambdap = lambda0_p / np.sqrt(eeff)

# System 2 (code): Open-Circuit Stub
d_stub_lambda = 0.226
ls_lambda = 0.382
dp_stub = d_stub_lambda * lambdap
lsp = ls_lambda * lambdap

# System 5 (code): Series Inductor
d_L_lambda = 0.152
Lp = 8.4e-9
dp_L_m = d_L_lambda * lambdap

# System 7 (code): Quarter-Wave Transformer at Minimum
d_tr_lambda = 0.311
Zt = 32.01
dp_tr = d_tr_lambda * lambdap
dquart = 0.25 * lambdap

# === Frequency sweep ===
f = np.arange(1, fmax + 1, 1)
f_Hz = f * 1e6
betaf = (2 * np.pi * f_Hz * np.sqrt(eeff)) / c
ZLf = RL + 1j * 2 * np.pi * f_Hz * LL

# Open-circuit stub
Zd_stub = Z0 * (ZLf + 1j * Z0 * np.tan(betaf * dp_stub)) / (Z0 + 1j * ZLf * np.tan(betaf * dp_stub))
Zin_1 = 1 / ((1 / Zd_stub) + 1j * (1 / Z0) * np.tan(betaf * lsp))

# Series inductor
Zd_L = Z0 * (ZLf + 1j * Z0 * np.tan(betaf * dp_L_m)) / (Z0 + 1j * ZLf * np.tan(betaf * dp_L_m))
Zin_2 = Zd_L + 1j * 2 * np.pi * f_Hz * Lp

# Quarter-wave transformer
Zd_tr = Z0 * (ZLf + 1j * Z0 * np.tan(betaf * dp_tr)) / (Z0 + 1j * ZLf * np.tan(betaf * dp_tr))
Zin_3 = Zt * (Zd_tr + 1j * Zt * np.tan(betaf * dquart)) / (Zt + 1j * Zd_tr * np.tan(betaf * dquart))

rho1 = (Zin_1 - Z0) / (Zin_1 + Z0)
rho2 = (Zin_2 - Z0) / (Zin_2 + Z0)
rho3 = (Zin_3 - Z0) / (Zin_3 + Z0)

S11_1 = 20 * np.log10(np.abs(rho1))
S11_2 = 20 * np.log10(np.abs(rho2))
S11_3 = 20 * np.log10(np.abs(rho3))

VSWR1 = (1 + np.abs(rho1)) / (1 - np.abs(rho1))
VSWR2 = (1 + np.abs(rho2)) / (1 - np.abs(rho2))
VSWR3 = (1 + np.abs(rho3)) / (1 - np.abs(rho3))

idx_p = np.argmin(np.abs(f - fp))
print(f"S11 @ {fp} MHz -> Stub: {S11_1[idx_p]:.2f} dB | Series L: {S11_2[idx_p]:.2f} dB | Quarter-wave: {S11_3[idx_p]:.2f} dB")

# === Plot 1: Comparative S11 vs Frequency ===
plt.style.use("default")
fig, ax = plt.subplots(figsize=(9, 5.5), dpi=150)
ax.plot(f, S11_1, label="Open-Circuit Stub (System 2)", color="#1f77b4", linewidth=1.8)
ax.plot(f, S11_2, label="Series Inductor (System 5)", color="#2ca02c", linewidth=1.8)
ax.plot(f, S11_3, label="Quarter-Wave Transformer (System 7)", color="#d62728", linewidth=1.8)
ax.axvline(fp, color="gray", linestyle="--", linewidth=1, label=f"Design frequency (f₀ = {fp:.0f} MHz)")
ax.axhline(-10, color="black", linestyle=":", linewidth=0.8, alpha=0.6, label="-10 dB reference")
ax.set_xlabel("Frequency (MHz)")
ax.set_ylabel("S11 (dB)")
ax.set_title("Comparative Return Loss (S11) vs Frequency\nMATLAB Frequency-Sweep Analysis (0–4×f₀)")
ax.set_xlim(0, fmax)
ax.set_ylim(-50, 2)
ax.grid(True, alpha=0.3)
ax.legend(loc="lower right", fontsize=8.5)
fig.tight_layout()
fig.savefig("/home/claude/rf_plots/matlab_S11_comparison.png")
plt.close(fig)

# === Plot 2: VSWR vs Frequency (zoomed near design frequency) ===
mask = (f >= fp * 0.7) & (f <= fp * 1.3)
fig, ax = plt.subplots(figsize=(9, 5.5), dpi=150)
ax.plot(f[mask], VSWR1[mask], label="Open-Circuit Stub", color="#1f77b4", linewidth=1.8)
ax.plot(f[mask], VSWR2[mask], label="Series Inductor", color="#2ca02c", linewidth=1.8)
ax.plot(f[mask], VSWR3[mask], label="Quarter-Wave Transformer", color="#d62728", linewidth=1.8)
ax.axvline(fp, color="gray", linestyle="--", linewidth=1, label=f"f₀ = {fp:.0f} MHz")
ax.axhline(2.0, color="black", linestyle=":", linewidth=0.8, alpha=0.6, label="VSWR = 2 reference")
ax.set_xlabel("Frequency (MHz)")
ax.set_ylabel("VSWR")
ax.set_title("VSWR vs Frequency Near the Design Frequency")
ax.grid(True, alpha=0.3)
ax.legend(loc="upper right", fontsize=8.5)
ax.set_ylim(1, 5)
fig.tight_layout()
fig.savefig("/home/claude/rf_plots/matlab_VSWR_comparison.png")
plt.close(fig)

print("Plots saved.")
