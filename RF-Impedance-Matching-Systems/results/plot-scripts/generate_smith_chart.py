import numpy as np
import matplotlib.pyplot as plt
from matplotlib.patches import Circle
import matplotlib.path as mpath

Z0 = 50
ZL = 71.1 + 1j * 51.1
zL_norm = ZL / Z0
yL_norm = 1 / zL_norm

rho_ZL = (zL_norm - 1) / (zL_norm + 1)
rho_YL = (yL_norm - 1) / (yL_norm + 1)

fig, ax = plt.subplots(figsize=(7, 7), dpi=150)

# Outer unit circle (|Gamma|=1 boundary)
theta = np.linspace(0, 2 * np.pi, 400)
ax.plot(np.cos(theta), np.sin(theta), color="black", linewidth=1.2)

# Constant resistance circles (r = 0, 0.2, 0.5, 1, 2, 5)
for r in [0, 0.2, 0.5, 1, 2, 5]:
    cx = r / (1 + r)
    rad = 1 / (1 + r)
    circ = Circle((cx, 0), rad, fill=False, color="gray", linewidth=0.6)
    ax.add_patch(circ)

# Constant reactance arcs (x = 0.2, 0.5, 1, 2, 5 and negatives)
for x in [0.2, 0.5, 1, 2, 5]:
    for sign in [1, -1]:
        xv = sign * x
        cy = 1 / xv
        rad = 1 / abs(xv)
        t = np.linspace(-np.pi, np.pi, 400)
        cx_arc = 1 + rad * np.cos(t)
        cy_arc = cy + rad * np.sin(t)
        mask = cx_arc**2 + cy_arc**2 <= 1.0004
        ax.plot(cx_arc[mask], cy_arc[mask], color="gray", linewidth=0.5)

# Plot ZL and YL points
ax.plot([0, rho_ZL.real], [0, rho_ZL.imag], color="red", linewidth=2,
        marker="o", markevery=[1], label=f"Z_L = {zL_norm.real:.2f} + j{zL_norm.imag:.2f} (norm.)")
ax.plot([0, rho_YL.real], [0, rho_YL.imag], color="blue", linewidth=2,
        marker="o", markevery=[1], label=f"Y_L = {yL_norm.real:.2f} - j{abs(yL_norm.imag):.2f} (norm.)")

ax.set_xlim(-1.15, 1.15)
ax.set_ylim(-1.15, 1.15)
ax.set_aspect("equal")
ax.axis("off")
ax.set_title("Smith Chart — Load to Match\nZ_L = 71.1 + j51.1 Ω  @  f = 962 MHz  (Z₀ = 50 Ω)")
ax.legend(loc="upper left", fontsize=9, framealpha=0.9)
fig.tight_layout()
fig.savefig("/home/claude/rf_plots/smith_chart_load.png")
plt.close(fig)
print("Saved smith_chart_load.png")
