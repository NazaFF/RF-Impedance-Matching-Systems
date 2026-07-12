<Qucs Schematic 0.0.19>
<Properties>
  <View=0,-110,1524,909,0.909093,0,0>
  <Grid=10,10,1>
  <DataSet=TransformadorMinimo.dat>
  <DataDisplay=TransformadorMinimo.dpl>
  <OpenDisplay=1>
  <Script=TransformadorMinimo.m>
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
  <Eqn Eqn1 1 830 100 -38 18 0 0 "dBS11=dB(S[1,1])" 1 "yes" 0>
  <SUBST Subst1 1 180 140 -30 24 0 0 "2.05" 1 "1.575 mm" 1 "25 um" 1 "0.00045" 1 "0.022e-6" 0 "0.15e-6" 0>
  <GND * 1 110 520 0 0 0 0>
  <Pac P1 1 110 490 18 -26 0 1 "1" 1 "50 Ohm" 1 "0 dBm" 0 "962 MHz" 1 "26.85" 0>
  <R Zl1 1 820 420 15 -26 0 1 "71.1" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "european" 0>
  <GND * 1 890 500 0 0 0 0>
  <L Ll 1 850 450 -26 10 0 0 "8.45 nH" 1 "" 0>
  <MLIN Transformador 1 270 390 -26 15 0 0 "Subst1" 1 "9.35795 mm" 1 "58.5 mm" 1 "Hammerstad" 0 "Kirschning" 0 "26.85" 0>
  <MLIN LinhaTransmissao 1 520 390 -26 15 0 0 "Subst1" 1 "5.0387 mm" 1 "72.463 mm" 1 "Hammerstad" 0 "Kirschning" 0 "26.85" 0>
  <.SP SP1 1 490 80 0 80 0 0 "lin" 1 "0" 1 "4 GHz" 1 "5913" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
</Components>
<Wires>
  <550 390 820 390 "" 0 0 0 "">
  <890 450 890 500 "" 0 0 0 "">
  <880 450 890 450 "" 0 0 0 "">
  <110 390 110 460 "" 0 0 0 "">
  <300 390 490 390 "" 0 0 0 "">
  <110 390 240 390 "" 0 0 0 "">
</Wires>
<Diagrams>
  <Rect 1000 380 240 160 3 #c0c0c0 1 00 1 0 0.2 1 1 -0.1 0.5 1.1 1 -0.1 0.5 1.1 315 0 225 "" "" "">
	<"dBS11" #0000ff 0 3 0 0 0>
	  <Mkr 9.64141e+08 176 -99 3 0 0>
  </Rect>
  <ySmith 1000 680 200 200 3 #c0c0c0 1 00 1 0 1 1 1 0 4 1 1 0 1 1 315 0 225 "" "" "">
	<"S[1,1]" #0000ff 0 3 0 0 0>
	  <Mkr 9.64141e+08 160 -159 3 0 0>
  </ySmith>
</Diagrams>
<Paintings>
</Paintings>
