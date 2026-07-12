import sys
sys.path.insert(0, "/home/claude/rf_plots")
from parse_qucs import parse_dat
import matplotlib.pyplot as plt

base = "/home/claude/rf_repo/RF-Impedance-Matching-Systems/qucs"

f1, v1 = parse_dat(f"{base}/01_Open_Circuit_Stub/StubOC.dat", "dBS11")
f2, v2 = parse_dat(f"{base}/02_Series_Inductor/LemSerie.dat", "dBS11")
f3, v3 = parse_dat(f"{base}/03_Quarter_Wave_Transformer/TransformadorMinimo.dat", "dBS11")

f1 = [x / 1e6 for x in f1]
f2 = [x / 1e6 for x in f2]
f3 = [x / 1e6 for x in f3]

fp = 962

fig, ax = plt.subplots(figsize=(9, 5.5), dpi=150)
ax.plot(f1, v1, label="Open-Circuit Stub (System 2)", color="#1f77b4", linewidth=1.6)
ax.plot(f2, v2, label="Series Inductor (System 5)", color="#2ca02c", linewidth=1.6)
ax.plot(f3, v3, label="Quarter-Wave Transformer (System 7)", color="#d62728", linewidth=1.6)
ax.axvline(fp, color="gray", linestyle="--", linewidth=1, label=f"Design frequency (f₀ = {fp} MHz)")
ax.axhline(-10, color="black", linestyle=":", linewidth=0.8, alpha=0.6, label="-10 dB reference")
ax.set_xlabel("Frequency (MHz)")
ax.set_ylabel("S11 (dB)")
ax.set_title("Comparative Return Loss (S11) vs Frequency\nQucs Microstrip Simulation (Substrate 6)")
ax.set_xlim(0, 4000)
ax.set_ylim(-45, 2)
ax.grid(True, alpha=0.3)
ax.legend(loc="lower right", fontsize=8.5)
fig.tight_layout()
fig.savefig("/home/claude/rf_plots/qucs_S11_comparison.png")
plt.close(fig)
print("Saved qucs_S11_comparison.png")
