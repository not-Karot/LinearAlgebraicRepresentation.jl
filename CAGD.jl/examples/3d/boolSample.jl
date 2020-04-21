todisplay = VERSION <= VersionNumber("1.2") ? true : false

using LinearAlgebra
using QHull
using LinearAlgebraicRepresentation
Lar = LinearAlgebraicRepresentation
using CAGD
if todisplay
    using ViewerGL
    GL = ViewerGL
	include("../views.jl")
end

# Rod Generation

V,CV = Lar.rod()([3, 1])
ch = QHull.chull(convert(Lar.Points,V'))
FV = ch.simplices
EV = Lar.simplexFacets(FV)

if todisplay
    GL.VIEW([
        GL.GLAxis( GL.Point3d(0,0,0),GL.Point3d(1,1,1) )
        GL.GLGrid(V,EV,GL.COLORS[1],1)
    ]);
end

# Three Rods Generation

cyl = Lar.Struct([ 
    Lar.r(0,0,0),
    Lar.s(1.0, 1.0, 2.0),
    Lar.t(0,0,-1.5),
    (V,FV,EV)
])
cyl = Lar.struct2lar(cyl)
tris = Lar.Struct([
    cyl,
    Lar.Struct([Lar.r(pi/2,0,0), cyl ]) ,
    Lar.Struct([Lar.r(0,pi/2,0), cyl ])
])
cyls = Lar.struct2lar(tris)

# Cube Generation

V, (_, EV, FV, _) = Lar.cuboid([1,1,1],true,[-1,-1,-1])
cube = (V, FV, EV)

# Sphere Generation

# V, EV, FV = catmullclark(cube[1], cube[3], cube[2], 4)
# sphere = (V, FV, EV)

V, FV = Lar.sphere(1.0)([13,25])
FV = sort(sort.(FV))
function getFaceEdges(fV::Array{Int,1})
    return [fV[1], fV[2]], [fV[1], fV[3]], [fV[2], fV[3]]
end
EVs = unique([(map(f -> getFaceEdges(f), FV)...)...])
sphere = (V, FV, EVs)

# Object Creation

carry = Lar.Struct([
    cyls,
    Lar.s(1.3,1.3,1.3),
    cube,
    Lar.s(1.3,1.3,1.3),
    #Lar.s(1.5,1.5,1.5)
    sphere
])
V,FV,EV = Lar.struct2lar(carry)

if todisplay
    GL.VIEW([
        GL.GLAxis( GL.Point3d(0,0,0),GL.Point3d(1,1,1) )
        GL.GLGrid(V,EV,GL.COLORS[1],1)
    ]);
end

# Model Generation

model = CAGD.Model(V)
scs = convert(Lar.ChainOp, Lar.coboundary_1(model.G, FV, EV))
CAGD.addModelCells!(model, 1, EV, signed = true)
CAGD.addModelCells!(model, 2, scs)


atol = 1e-6;
if todisplay  displayModel(model)  end

split_model = CAGD.pairwise_decomposition(model, atol = atol)

if todisplay  displayModel(split_model)  end

congr_model = CAGD.mergeModelVertices(split_model, err=atol, signed_merge=true)

if todisplay  displayModel(congr_model)  end

gift_model, bicon_comps = CAGD.tgw(congr_model, 3, atol=atol)

if todisplay  viewExplode(gift_model)  end
