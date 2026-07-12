<Qucs Schematic 0.0.19>
<Properties>
  <View=-40,34,1297,870,1,0,1>
  <Grid=10,10,1>
  <DataSet=LemSerie.dat>
  <DataDisplay=LemSerie.dpl>
  <OpenDisplay=1>
  <Script=LemSerie.m>
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
  <SUBST Subst6 1 130 220 -30 24 0 0 "2.05" 1 "1.575 mm" 1 "25 um" 1 "0.00045" 1 "0.022e-6" 0 "0.15e-6" 0>
  <.SP SP1 1 330 190 0 79 0 0 "lin" 1 "0" 1 "4 GHz" 1 "5913" 1 "no" 0 "1" 0 "2" 0 "no" 0 "no" 0>
  <Eqn Eqn1 1 660 200 -38 18 0 0 "dBS11=dB(S[1,1])" 1 "yes" 0>
  <GND * 1 60 670 0 0 0 0>
  <Pac P1 1 60 640 18 -26 0 1 "1" 1 "50 Ohm" 1 "0 dBm" 0 "962 MHz" 1 "26.85" 0>
  <R Zl 1 630 630 15 -26 0 1 "71.1" 1 "26.85" 0 "0.0" 0 "0.0" 0 "26.85" 0 "european" 0>
  <L BobineSerie 1 190 540 -26 10 0 0 "8.43 nH" 1 "" 0>
  <GND * 1 510 660 0 0 0 0>
  <L Ll 1 540 660 11 16 0 0 "8.45 nH" 1 "" 0>
  <MLIN MS2 1 370 540 -26 -111 0 2 "Subst6" 1 "5.0387 mm" 1 "35.5 mm" 1 "Hammerstad" 0 "Kirschning" 0 "26.85" 0>
</Components>
<Wires>
  <630 540 630 600 "" 0 0 0 "">
  <400 540 630 540 "" 0 0 0 "">
  <60 540 160 540 "" 0 0 0 "">
  <60 540 60 610 "" 0 0 0 "">
  <570 660 630 660 "" 0 0 0 "">
  <220 540 340 540 "" 0 0 0 "">
</Wires>
<Diagrams>
  <Rect 790 460 240 160 3 #c0c0c0 1 00 1 0 0.2 1 1 -0.1 0.5 1.1 1 -0.1 0.5 1.1 315 0 225 "" "" "">
	<"dBS11" #0000ff 0 3 0 0 0>
	  <Mkr 9.61434e+08 118 -74 3 0 0>
  </Rect>
  <ySmith 820 760 200 200 3 #c0c0c0 1 00 1 0 1 1 1 0 4 1 1 0 1 1 315 0 225 "" "" "">
	<"S[1,1]" #0000ff 0 3 0 0 0>
	  <Mkr 9.65494e+08 161 -224 3 0 0>
  </ySmith>
</Diagrams>
<Paintings>
</Paintings>
