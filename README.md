# RF-Impedance-Matching-Systems
RF impedance matching network design and simulation (Smith Chart, MATLAB, Qucs) for a 962 MHz load — stub, series inductor and quarter-wave transformer.

---

## Overview

In RF and microwave systems, a load impedance rarely matches the characteristic impedance of the transmission line or source. Mismatches cause power reflection, standing waves and reduced power transfer — a problem that becomes critical near a design frequency where efficiency must be maximized.

This project designs, simulates and compares **three distinct impedance-matching techniques** for a single frequency-dependent load, using both analytical/graphical methods (Smith Chart) and two independent simulation environments (MATLAB and Qucs), developed for the course *Propagação e Radiação de Ondas Eletromagnéticas* (Electromagnetic Wave Propagation and Radiation), University of Aveiro, 2025/2026.

**Design specifications:**
- Load impedance: `Z_L = 71.1 + j51.1 Ω` (frequency-dependent, modeled as a series R-L network)
- Design frequency: `f₀ = 962 MHz`
- Reference impedance: `Z₀ = 50 Ω`
- Microstrip substrate ("Substrate 6"): εr = 2.05, height = 1.575 mm, copper thickness = 25 µm, loss tangent = 0.00045

---

## Features

- Analytical design of three impedance-matching topologies using the Smith Chart
- Frequency-sweep simulation (0–4×f₀) in MATLAB, computing S11, VSWR and transmitted power for all three systems
- Independent physical-layer verification in Qucs using realistic microstrip lines on a defined substrate
- Comparative performance analysis across all three systems at the design frequency
- Public presentation summarizing theoretical design, simulation results and comparative conclusions

---

## Matching Systems Implemented

### 1. Open-Circuit Stub Matching
A single open-circuit shunt stub placed at a distance `d` from the load, matching the line by cancelling the imaginary part of the admittance seen looking into the load.

- Distance from load: d = 0.221λ (hand calculation) / 0.226λ (MATLAB-refined) ≈ 5.29 cm
- Stub length: 0.382λ ≈ 8.93 cm
- **S11 @ 962 MHz: −30.22 dB**

### 2. Series Inductor Matching
A series inductor placed at a distance `d` from the load, added at the point where the real part of the line's input impedance equals Z₀, to cancel the remaining reactance.

- Distance from load: d = 0.152λ ≈ 3.55 cm
- Series inductance: L ≈ 8.40 nH
- **S11 @ 962 MHz: −27.40 dB**

### 3. Quarter-Wave Transformer at a Minimum Point
A λ/4 transformer section inserted at the nearest voltage-minimum point of the standing wave, where the line impedance is purely real.

- Distance to minimum: d = 0.311λ ≈ 7.27 cm
- Transformer length: λ/4 ≈ 5.85 cm
- Transformer characteristic impedance: Zt = 32.01 Ω
- **S11 @ 962 MHz: −42.81 dB**

---

## Design Traceability

This project implements matching systems **2, 5 and 7** as assigned, on **Substrate 6**, per the course's system/substrate coding scheme:

| Assignment Code | Specified System | Implemented As |
|---|---|---|
| 2 | Stub em OC (open-circuit stub) | Open-Circuit Stub Matching |
| 5 | L em série com a linha (series inductor) | Series Inductor Matching |
| 7 | Transformador de λ/4 num ponto de mínimo | Quarter-Wave Transformer at a Minimum Point |

**Substrate 6** — low-loss PTFE laminate (CraneAE CuFlon), h = 1.575 mm, εr = 2.05, tan(δ) = 0.00045, copper thickness t = 25 µm, as specified in the assignment brief and configured in all Qucs schematics.

---

## Comparative Analysis

| System | S11 @ 962 MHz | Key Characteristic |
|---|---|---|
| Open-Circuit Stub | −30.22 dB | Microstrip implementation closely validated theoretical (hand) calculations |
| Series Inductor | −27.40 dB | Widest bandwidth of the three; most tolerant to frequency drift or component tolerance |
| λ/4 Transformer (min. point) | **−42.81 dB** | Best absolute matching performance; near-zero reflection once line width was correctly dimensioned for 32.01 Ω |

The quarter-wave transformer achieved the strongest match at the exact design frequency, while the series-inductor solution traded some peak performance for a broader usable bandwidth — an expected and instructive trade-off between narrowband and wideband matching strategies.

---

## Software Used

- **MATLAB** — frequency-domain modeling, Smith Chart plotting, S11/VSWR/power-transfer sweep analysis
- **[Qucs](https://qucs.sourceforge.net/)** — circuit-level and microstrip-level simulation, S-parameter verification
- Manual Smith Chart analysis for initial design values

---

## Results

**Smith Chart — Load to Match**

![Smith Chart of the load](results/smith_chart_load.png)

**Return Loss (S11) — MATLAB Frequency Sweep**

![S11 comparison from MATLAB formulas](results/matlab_S11_comparison.png)

**VSWR — MATLAB Frequency Sweep (near design frequency)**

![VSWR comparison from MATLAB formulas](results/matlab_VSWR_comparison.png)

**Return Loss (S11) — Qucs Microstrip Simulation**

![S11 comparison from Qucs simulation data](results/qucs_S11_comparison.png)

> **Methodology note:** MATLAB was not available in the environment used to generate these plots, so the two MATLAB-derived charts were reproduced in Python using the exact same input parameters, formulas and design values as `matlab/projetoPROE_113223_103963_final.m` (line-by-line equivalent computation). The reproduced S11 values at 962 MHz (−30.22 / −27.40 / −42.81 dB) match the original MATLAB output reported in the presentation exactly. The Qucs chart, in contrast, is plotted directly from the real `.dat` simulation datasets produced by Qucs itself — no reproduction involved. The Python scripts used to generate all four plots are included in `results/plot-scripts/` for full transparency and reproducibility.

---

## Repository Structure

```
RF-Impedance-Matching-Systems/
├── matlab/                  MATLAB scripts: load characterization and full frequency-sweep analysis
├── qucs/                    Qucs schematics and simulation datasets, one folder per matching system
│   ├── 01_Open_Circuit_Stub/
│   ├── 02_Series_Inductor/
│   └── 03_Quarter_Wave_Transformer/
├── smith-charts/            Hand-derived Smith Chart design sheets (PDF) for each system
├── results/                 Result plots (S11, VSWR, Smith Chart) and the scripts used to generate them
├── presentation/            Project presentation (PowerPoint)
└── documentation/           Assignment brief, system/substrate code reference, and full technical report (PDF)
```

---

## Installation & Usage

**MATLAB:**
1. Open `matlab/dadosprojeto_113223_103963.m` to visualize the load impedance/admittance on a Smith Chart (requires the `smithplot` function/toolbox).
2. Run `matlab/projetoPROE_113223_103963_final.m` to compute and plot the frequency sweep (S11, VSWR, Smith Chart trajectories) for all three matching systems and print the full numerical report to the console.

**Qucs:**
1. Open any `.sch` file inside `qucs/<system>/` in [Qucs](https://qucs.sourceforge.net/).
2. Run the S-parameter simulation to reproduce the S11 results reported above.

---

## Observations & Challenges

- The hand (Smith Chart) design values and the MATLAB-refined values differ slightly (e.g. stub distance 0.221λ by hand vs. 0.226λ from the numerical sweep) — a expected and instructive gap between graphical estimation and numerical optimization, rather than a discrepancy to hide.
- Designing the microstrip line widths for the exact required characteristic impedances (e.g. 32.01 Ω for the quarter-wave transformer) required iterative adjustment in Qucs, since physical line width and impedance are related through a nonlinear function of the substrate parameters.

---

## Future Improvements

- Extend the frequency sweep comparison with a bandwidth metric (e.g. −10 dB return-loss bandwidth) for each system, to quantify the narrowband/wideband trade-off numerically rather than only qualitatively.
- Add practical/tolerance analysis: simulate the effect of ±5% component or fabrication tolerance on each matching system's performance.
- Validate designs against a fabricated prototype using a Vector Network Analyzer.

---

## Skills Demonstrated

| Category | Skills |
|---|---|
| RF Engineering | Impedance matching, Smith Chart analysis, S-parameters, VSWR, return loss |
| Transmission Lines | Microstrip design, characteristic impedance, quarter-wave transformers, stub matching |
| Simulation | MATLAB frequency-domain analysis, Qucs circuit/microstrip simulation |
| Engineering Analysis | Comparative performance evaluation, bandwidth vs. peak-performance trade-off analysis |

---

## Engineering Concepts

- **Smith Chart** — graphical tool mapping normalized impedance/admittance to reflection coefficient, used here for initial matching-network design.
- **Impedance matching** — the process of making a load appear as Z₀ to a transmission line, maximizing power transfer and minimizing reflections.
- **S11 / Return Loss** — the ratio of reflected to incident power at a port, expressed in dB; more negative values indicate better matching.
- **Quarter-wave transformer** — a transmission-line section of length λ/4 that transforms a real impedance Z_d into `Zt² / Z_d`, used to match real impedances at a single frequency.

---

## Authors

Project developed in collaboration for the course *Propagação e Radiação de Ondas Eletromagnéticas*, University of Aveiro (2025/2026).

- Tomás Ferreira
- Adriana Pires

---

## License

This project is licensed under the MIT License — see [LICENSE](LICENSE) for details.
