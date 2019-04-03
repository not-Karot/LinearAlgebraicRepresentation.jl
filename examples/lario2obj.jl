using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using Plasm, SparseArrays

V = [0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0; 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0 0.0 0.0 0.0 0.0 0.0 0.0 0.0 1.0 1.0 1.0 1.0 1.0 1.0 1.0 2.0 2.0 2.0 2.0 2.0 2.0 2.0 3.0 3.0 3.0 3.0 3.0 3.0 3.0 4.0 4.0 4.0 4.0 4.0 4.0 4.0 5.0 5.0 5.0 5.0 5.0 5.0 5.0 6.0 6.0 6.0 6.0 6.0 6.0 6.0 7.0 7.0 7.0 7.0 7.0 7.0 7.0; 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0 0.0 1.0 2.0 3.0 4.0 5.0 6.0]

FV = Array{Int64,1}[[66, 67, 73, 74], [67, 68, 74, 75], [68, 69, 75, 76], [74, 75, 81, 82], [75, 76, 82, 83], [81, 82, 88, 89], [82, 83, 89, 90], [83, 84, 90, 91], [88, 89, 95, 96], [89, 90, 96, 97], [118, 119, 125, 126], [125, 126, 132, 133], [129, 130, 136, 137], [132, 133, 139, 140], [146, 147, 153, 154], [173, 174, 180, 181], [202, 203, 209, 210], [228, 229, 235, 236], [258, 259, 265, 266], [263, 264, 270 , 271], [264, 265, 271, 272], [284, 285, 291, 292], [285, 286, 292, 293], [290, 291, 297, 298], [291, 292, 298, 299], [297, 298, 304, 305], [298, 299, 305, 306], [305, 306, 312, 313], [312, 313, 319, 320], [319, 320, 326, 327], [320, 321, 327, 328], [342, 343, 349, 350], [348, 349, 355, 356], [355, 356, 362, 363], [362, 363, 369, 370], [363, 364, 370, 371], [369, 370, 376, 377], [370, 371, 377, 378], [405, 406, 412, 413] , [412, 413, 419, 420], [66, 67, 122, 123], [67, 68, 123, 124], [68, 69, 124, 125], [73, 74, 129, 130], [83, 84, 139, 140], [90, 91, 146, 147], [95, 96, 151, 152], [96, 97, 152, 153], [118, 119, 174, 175], [122, 123, 178, 179], [123, 124, 179, 180], [124, 125, 180, 181], [136, 137, 192, 193], [151, 152, 207, 208], [152, 153, 208, 209], [153, 154, 209, 210], [173, 174, 229, 230], [174, 175, 230, 231], [178, 179, 234, 235] , [179, 180, 235, 236], [192, 193, 248, 249], [202, 203, 258, 259], [207, 208, 263, 264], [208, 209, 264, 265], [228, 229, 284, 285], [229, 230, 285, 286], [230, 231, 286, 287], [234, 235, 290, 291], [248, 249, 304, 305], [265, 266, 321, 322], [270, 271, 326, 327], [271, 272, 327, 328], [286, 287, 342, 343], [292, 293, 348, 349], [320, 321, 376, 377], [321, 322, 377, 378], [349, 350, 405, 406], [363, 364, 419, 420], [66, 73, 122, 129], [69, 76, 125, 132], [74, 81, 130, 137], [76, 83, 132, 139], [81, 88, 137, 144], [84, 91, 140, 147], [88, 95, 144, 151], [90, 97, 146, 153], [118, 125, 174, 181], [119, 126, 175, 182], [122, 129, 178, 185], [126, 133, 182, 189], [129, 136, 185, 192], [133, 140, 189, 196], [137, 144, 193, 200], [140, 147, 196, 203], [144, 151, 200, 207], [147, 154, 203, 210], [173, 180, 229, 236], [175, 182, 231, 238], [178 , 185, 234, 241], [182, 189, 238, 245], [185, 192, 241, 248], [189, 196, 245, 252], [193, 200, 249, 256], [196, 203, 252, 259], [200, 207, 256, 263], [202, 209, 258, 265], [228, 235, 284, 291], [231, 238, 287, 294], [234, 241, 290, 297], [238, 245, 294, 301], [241, 248, 297, 304], [245, 252, 301, 308], [249, 256, 305 , 312], [252, 259, 308, 315], [256, 263, 312, 319], [259, 266, 315, 322], [263, 270, 319, 326], [265, 272, 321, 328], [286, 293, 342, 349], [287, 294, 343, 350], [292, 299, 348, 355], [294, 301, 350, 357], [299, 306, 355, 362], [301, 308, 357, 364], [306, 313, 362, 369], [308, 315, 364, 371], [313, 320, 369, 376], [315, 322, 371, 378], [349, 356, 405, 412], [350, 357, 406, 413], [356, 363, 412, 419], [357, 364, 413, 420]] 

Plasm.view(V,FV)

# First method for computation of EV
EV = []
for f in FV
	push!(EV, [[f[1],f[2]],[f[3],f[4]],  [f[1],f[3]],[f[2],f[4]]])
end
doubleedges = sort(cat(EV))
doubleedges = convert(Lar.Cells, doubleedges)
EV = [doubleedges[k] for k=1:2:length(doubleedges)]

# Second method for computation of EV
kFV = Lar.characteristicMatrix(FV);
kFF = kFV * kFV'
I,J,Value = SparseArrays.findnz(kFF)
triples = hcat([[i,j,1] for (i,j,v) in zip(I,J,Value) if v == 2 ]...)
I = triples[1,:]; J = triples[2,:];  Value = triples[3,:]; 
copFF = SparseArrays.sparse(I,J,Value)
FF = [findnz(copFF[k,:])[1] for k=1:length(FV)]
doubleedges = sort(cat([[intersect(FV[k],FV[f]) for f in ff] 
	for (k,ff) in enumerate(FF)]))
EV2 = [doubleedges[k] for k=1:2:length(doubleedges)]

Plasm.view(V,EV)

# Computing copFE
kEV = Lar.characteristicMatrix(EV);
kFE = kFV * kEV'
I,J,Value = SparseArrays.findnz(kFE)
triples = hcat([[i,j,1] for (i,j,v) in zip(I,J,Value) if v == 2 ]...)
I,J,Value = [triples[k,:] for k=1:size(triples,1)]
copFE = SparseArrays.sparse(I,J,Value)
copFE = convert(SparseMatrixCSC{Int8,Int64},copFE)
FE = [findnz(copFE[k,:])[1] for k=1:length(FV)]


V = convert(Lar.Points,V')
copCE = SparseArrays.ones(Int8,1,size(kEV,1))
copCE = convert(Lar.ChainOp, copCE)
cc = [kEV, copFE, copCE]::Lar.ChainComplex

Lar.triangulate(V::Lar.Points, cc[1:2])
Lar.lar2obj(V::Lar.Points, cc)


######################################################  Bugged !!!  LOOPS !!!

function buildFV(copEV::ChainOp, face::Cell)
    startv = -1
    nextv = 0
    edge = 0

    vs = Array{Int64, 1}()

    while startv != nextv
        if startv < 0
            edge = face.nzind[1]
            startv = copEV[edge,:].nzind[face[edge] < 0 ? 2 : 1]
            push!(vs, startv)
        else
            edge = setdiff(intersect(face.nzind, copEV[:, nextv].nzind), edge)[1]
        end
        nextv = copEV[edge,:].nzind[face[edge] < 0 ? 1 : 2]
        push!(vs, nextv)

    end

    return vs[1:end-1]
end




