<Qucs Schematic 0.0.19>
<Properties>
  <View=-17,-6,1489,1141,0.838818,0,0>
  <Grid=10,10,1>
  <DataSet=StubOC.dat>
  <DataDisplay=StubOC.dpl>
  <OpenDisplay=1>
  <Script=StubOC.m>
  <RunScript=0>
  <showFrame=0>
  <FrameText0=Título>
  <FrameText1=Autor:>
  <FrameText2=Data:>
  <FrameText3=Revisão:>
</Properties>
<Symbol>
</Symbol>
<Components>
  <Eqn Eqn1 1 960 180 -38 18 0 0 "dBS11=dB(S[1,1])" 1 "yes" 0>
  <SUBST Subst6 1 310 220 -30 24 0 0 "2.05" 1 "1.575 mm" 1 "25 um" 1 "0.00045" 1 "0.022e-6" 0 "0.15e-6" 0>
  <.SP SP1 1 620 160 0 80 0 0 "lin" 1 "0" 1 "4 GHz" 1 "5913" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
  <GND * 1 120 750 0 0 0 0>
  <Pac P1 1 120 720 18 -26 0 1 "1" 1 "50 Ohm" 1 "0 dBm" 0 "962 MHz" 1 "26.85" 0>
  <R Zl2 1 830 650 15 -26 0 1 "71.1" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "european" 0>
  <GND * 1 900 730 0 0 0 0>
  <L L3 1 860 680 -26 10 0 0 "8.45 nH" 1 "" 0>
  <MLIN MS 1 530 620 -26 -111 0 2 "Subst6" 1 "5.0387 mm" 1 "52.9 mm" 1 "Hammerstad" 0 "Kirschning" 0 "26.85" 0>
  <MLIN StubOC 1 390 750 15 -26 0 1 "Subst6" 1 "5.0387 mm" 1 "89.3 mm" 1 "Hammerstad" 0 "Kirschning" 0 "26.85" 0>
</Components>
<Wires>
  <390 620 390 720 "" 0 0 0 "">
  <390 620 500 620 "" 0 0 0 "">
  <120 620 120 690 "" 0 0 0 "">
  <120 620 390 620 "" 0 0 0 "">
  <560 620 830 620 "" 0 0 0 "">
  <900 680 900 730 "" 0 0 0 "">
  <890 680 900 680 "" 0 0 0 "">
</Wires>
<Diagrams>
  <Rect 980 510 240 160 3 #c0c0c0 1 00 1 0 0.2 1 1 -0.1 0.5 1.1 1 -0.1 0.5 1.1 315 0 225 "" "" "">
	<"dBS11" #0000ff 0 3 0 0 0>
	  <Mkr 9.61434e+08 118 -98 3 0 0>
  </Rect>
  <ySmith 1020 880 200 200 3 #c0c0c0 1 00 1 0 1 1 1 0 4 1 1 0 1 1 315 0 225 "" "" "">
	<"S[1,1]" #0000ff 0 3 0 0 0>
	  <Mkr 9.59405e+08 157 -159 3 0 0>
  </ySmith>
</Diagrams>
<Paintings>
</Paintings>
