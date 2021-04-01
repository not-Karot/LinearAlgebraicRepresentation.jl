using LinearAlgebraicRepresentation
using ViewerGL
using LinearAlgebra
using SparseArrays
using DataStructures
Lar = LinearAlgebraicRepresentation
GL = ViewerGL

function testarrangement(V,CV,FV,EV)
		cop_EV = Lar.coboundary_0(EV::Lar.Cells);
		cop_FE = Lar.coboundary_1(V, FV::Lar.Cells, EV::Lar.Cells);
		W = convert(Lar.Points, V');

		V, copEV, copFE, copCF = Lar.space_arrangement(
				W::Lar.Points, cop_EV::Lar.ChainOp, cop_FE::Lar.ChainOp);
				
		V = convert(Lar.Points, V');
		V,CVs,FVs,EVs = Lar.pols2tria(V, copEV, copFE, copCF) # whole assembly
		GL.VIEW(GL.GLExplode(V,FVs,1.1,1.1,1.1,99,1));
		GL.VIEW(GL.GLExplode(V,EVs,1.5,1.5,1.5,99,1));
		GL.VIEW(GL.GLExplode(V,CVs,1,1,1,99,1));
end


V = [0.6540617999999998 0.2054992 0.2972308000000001; 0.7142364999999998 0.1455625 0.969203; 0.6872816200343089 0.1724107693563844 0.6681972618528844; 0.5941250999999997 0.8769965 0.36249240000000005; 0.6542998079614951 0.8170598007732168 1.0344646993560203; 0.6929229746417847 0.3843473621810608 0.9924101013070119; 0.6660927570227951 0.3906268097799347 0.66824889023436; 0.6924256885846046 0.3894687221287142 0.9924113129852241; 1.3260341 0.2707609000000001 0.2428771; 1.3862088 0.21082410000000004 0.9148494000000003; 1.2660973 0.9422582000000003 0.3081388; 1.3262719920385087 0.8823213992267827 0.9801110006439793; 0.7946185131077457 0.1533691699791747 0.9627011677876783; 0.795311803386693 0.18207414025178234 0.6679835359595829; 0.6978893364451173 0.3892254686183435 0.9924004714668809; 0.8049461769791598 0.3844586322271989 0.9823884300888783; -0.38740630000000004 0.49022260000000006 0.45363390000000015; 0.3249123 0.707347 0.5231232000000001; -0.17028190000000007 -0.08642419999999995 0.029717700000000125; 0.542036694733776 0.13070013212634024 0.09920695360173326; -0.317917 0.06630639999999999 1.0658723; 0.3944015999999999 0.28343080000000004 1.1353616; -0.10079260000000007 -0.5103404 0.6419561000000001; 0.6115259947337761 -0.2932160678736597 0.7114453536017331; 0.4729938678063347 0.07470259548304928 0.9819171231357612; 0.4673971777131105 0.08956648867512645 0.992844167328483; 0.4666328572520818 0.07498584149882567 0.9828352213039846; 0.4707836778272794 0.18222015069807973 0.6686268661789595; 0.4673140236772549 0.08983923498806379 0.9928443441979011; 0.5039882186318663 0.07330882745780876 0.6685562398308738; 0.7899025999999999 0.060579300000000016 0.6679888999999999; 0.46601 0.0749997 0.6686315999999999; 0.8043229999999999 0.38447249999999994 0.6679745999999999; 0.4804303999999999 0.3988929 0.6686172999999999; 0.7905452000000002 0.060564999999999994 0.9922023000000001; 0.46665270000000003 0.0749854 0.9928450000000001; 0.8049656 0.3844582 0.9921880000000001; 0.4810731000000001 0.3988786 0.9928307000000001]
copEV = SparseArrays.sparse([1, 4, 14, 2, 5, 15, 1, 2, 7, 17, 3, 4, 19, 3, 6, 20, 5, 6, 8, 21, 7, 9, 46, 47, 8, 9, 54, 55, 10, 12, 14, 10, 13, 16, 11, 12, 19, 11, 13, 20, 15, 16, 18, 23, 17, 18, 48, 49, 21, 22, 53, 54, 22, 23, 62, 63, 24, 26, 36, 24, 27, 37, 25, 26, 38, 25, 27, 39, 28, 30, 36, 28, 31, 37, 29, 30, 38, 29, 33, 39, 32, 33, 35, 41, 31, 32, 34, 43, 65, 66, 67, 34, 35, 60, 61, 40, 42, 50, 51, 67, 40, 43, 57, 58, 41, 42, 44, 45, 44, 48, 59, 45, 50, 60, 46, 49, 62, 47, 51, 64, 52, 56, 59, 52, 57, 61, 65, 53, 56, 63, 55, 58, 64, 66], [1, 1, 1, 2, 2, 2, 3, 3, 3, 3, 4, 4, 4, 5, 5, 5, 6, 6, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 10, 10, 10, 11, 11, 11, 12, 12, 12, 13, 13, 13, 13, 14, 14, 14, 14, 15, 15, 15, 15, 16, 16, 16, 16, 17, 17, 17, 18, 18, 18, 19, 19, 19, 20, 20, 20, 21, 21, 21, 22, 22, 22, 23, 23, 23, 24, 24, 24, 25, 25, 25, 25, 26, 26, 26, 26, 26, 26, 26, 27, 27, 27, 27, 28, 28, 28, 28, 28, 29, 29, 29, 29, 30, 30, 30, 30, 31, 31, 31, 32, 32, 32, 33, 33, 33, 34, 34, 34, 35, 35, 35, 36, 36, 36, 36, 37, 37, 37, 38, 38, 38, 38], Int8[-1, -1, -1, -1, -1, -1, 1, 1, -1, -1, -1, 1, -1, 1, -1, -1, 1, 1, -1, -1, 1, -1, -1, -1, 1, 1, -1, -1, -1, -1, 1, 1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, -1, -1, 1, 1, -1, -1, 1, -1, -1, 1, 1, 1, -1, -1, -1, -1, -1, 1, -1, -1, -1, 1, -1, 1, 1, -1, -1, -1, 1, 1, -1, 1, -1, 1, 1, 1, -1, 1, -1, 1, -1, -1, 1, 1, -1, -1, -1, -1, -1, 1, 1, -1, -1, -1, -1, -1, -1, 1, 1, 1, -1, -1, 1, 1, -1, -1, 1, 1, -1, 1, 1, 1, 1, 1, 1, 1, 1, -1, -1, -1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1, 1])
copFE = SparseArrays.sparse([1, 4, 2, 5, 1, 6, 1, 7, 2, 8, 1, 9, 1, 2, 18, 20, 1, 2, 21, 22, 1, 2, 25, 26, 3, 4, 3, 6, 3, 7, 3, 9, 4, 7, 5, 8, 4, 9, 4, 5, 18, 20, 4, 5, 28, 29, 6, 7, 6, 9, 8, 9, 21, 22, 8, 9, 25, 27, 8, 9, 28, 29, 10, 13, 10, 14, 10, 15, 10, 16, 11, 13, 11, 14, 11, 15, 11, 16, 12, 17, 11, 16, 11, 12, 30, 32, 11, 12, 23, 24, 13, 15, 13, 16, 14, 15, 14, 16, 16, 17, 16, 17, 23, 24, 16, 17, 18, 19, 16, 17, 18, 23, 19, 24, 20, 25, 18, 26, 18, 28, 20, 29, 19, 30, 18, 31, 21, 23, 21, 27, 22, 25, 21, 26, 21, 28, 21, 21, 23, 28, 24, 30, 23, 32, 25, 29, 27, 28, 26, 31, 32, 31, 30, 31], [1, 1, 2, 2, 3, 3, 4, 4, 5, 5, 6, 6, 7, 7, 7, 7, 8, 8, 8, 8, 9, 9, 9, 9, 10, 10, 11, 11, 12, 12, 13, 13, 14, 14, 15, 15, 16, 16, 17, 17, 17, 17, 18, 18, 18, 18, 19, 19, 20, 20, 21, 21, 21, 21, 22, 22, 22, 22, 23, 23, 23, 23, 24, 24, 25, 25, 26, 26, 27, 27, 28, 28, 29, 29, 30, 30, 31, 31, 32, 32, 33, 33, 34, 34, 34, 34, 35, 35, 35, 35, 36, 36, 37, 37, 38, 38, 39, 39, 40, 40, 41, 41, 41, 41, 42, 42, 42, 42, 43, 43, 44, 44, 45, 45, 46, 46, 47, 47, 48, 48, 49, 49, 50, 50, 51, 51, 52, 52, 53, 53, 54, 54, 55, 55, 56, 56, 57, 58, 59, 59, 60, 60, 61, 61, 62, 62, 63, 63, 64, 64, 65, 66, 67, 67], Int8[1, 1, -1, -1, -1, 1, -1, 1, 1, 1, -1, -1, 1, -1, -1, 1, -1, 1, -1, 1, 1, -1, 1, -1, 1, -1, -1, -1, -1, -1, 1, -1, -1, -1, 1, -1, -1, 1, 1, -1, 1, -1, -1, 1, -1, 1, -1, 1, 1, 1, 1, -1, 1, -1, 1, -1, 1, -1, -1, 1, 1, -1, 1, 1, -1, 1, -1, 1, 1, 1, 1, -1, -1, -1, -1, -1, 1, -1, -1, 1, -1, 1, 1, -1, 1, -1, -1, 1, 1, -1, -1, -1, 1, -1, -1, 1, 1, 1, 1, -1, 1, -1, -1, 1, -1, 1, -1, 1, -1, 1, -1, -1, 1, 1, 1, -1, -1, 1, 1, -1, -1, 1, -1, -1, 1, 1, 1, -1, 1, 1, 1, 1, -1, -1, -1, -1, -1, 1, -1, -1, -1, 1, 1, -1, 1, -1, -1, 1, 1, 1, 1, -1, -1, 1])
size(V), size(copEV), size(copFE)

copFV = copFE * copEV
FV = [copFV[f,:].nzind for f=1:size(copFV,1)]
EV = [copEV[e,:].nzind for e=1:size(copEV,1)]
FE = Lar.cop2lar(copFE) 
ff = copFV * copFV'
FF = [ff[f,:].nzind for f = 1:size(ff, 2)]
VV = [[v] for v=1:size(V,1)]
Model = (Lar.Points(V'), Lar.Cells[VV,EV,FV])

for k=1:length(FV)
	fVV = [[v] for v in Set(cat([FV[f] for f in FF[k]]))]
	fE = Int64[e for e in  Set(cat([FE[f] for f in FF[k]]))]
	fEV = sort!([EV[e] for e in fE])
	fFV = vcat([FV[f] for f in FF[k]])
	model = (Lar.Points(V'), Lar.Cells[fVV,fEV,fFV]);
	GL.VIEW(GL.numbering(.1)(model, GL.COLORS[1], 0.1));
end