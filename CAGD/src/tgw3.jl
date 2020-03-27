using SparseArrays

function tgw(model, dim)

    function select_sigma()
        for i = 1 : lo_num  if visited[i] == 1  return i  end  end
        for i = 1 : lo_num  if visited[i] == 0  return i  end  end
        return -1
    end

    function get_closer_petal(τ, stem, τ_sign)
        if !isdefined(ord_angles, Int(τ))
            ord_angles[τ] = CAGD.eval_ord_angle(model, dim - 1, τ)
        end
        stem_idx = findfirst(isequal(stem), ord_angles[τ])
        return ord_angles[τ][mod(stem_idx + τ_sign - 1, length(ord_angles[τ])) + 1]
    end

    # Prepearing tgw model
    tgw_model = CAGD.Model(model.G)
    for d = 1 : dim - 1  CAGD.addModelCells!(tgw_model, d, model.T[d])  end
    lo_cls = model.T[dim - 1]
    lo_num, llo_num = size(lo_cls)

    # Preprocessing angles between d-1 cells w.r.t. d-2 cells
    # ord_angles has for every d-2 cell the circular ordering between d-1 cells
    ord_angles = Array{Array{Int64, 1}, 1}(undef, llo_num)

    # Either 0 (not visited), 1 (once visited) or 2 (twice visited)
    visited = zeros(Int8, lo_num)
    # If visited[σ] == 1 then other_sign[σ] is the sign for the second visit
    other_sign = zeros(Int8, lo_num)

    # Components accumulator
    components = Array{Array{Int64, 1},1}();
    comp_idx = 0;

    # Until all dim-1 cells have been visited twice, continue
    while (σ = select_sigma()) > 0
        # Build new 3-cell
        c = SparseArrays.sparse(zeros(Int8, 1, lo_num))
        if visited[σ] == 0
            # Set sign in representation
            c[σ] = 1
            other_sign[σ] = -1
            # Set start to a new component
            push!(components, [])
            comp_idx += 1
        else
            c[σ] = other_sign[σ]
        end
        push!(components[comp_idx], σ)
        visited[σ] += 1

        # Build other faces via corolla method
        # boundary = d-2 exposed cells of currently analysed d cell
        while (boundary = (dropzeros(c * model.T[dim - 1])[1, :])).nzind != []
            # corolla are the next d-1 cells to be added
            corolla = zeros(Int8, lo_num)
            for τ in boundary.nzind
                # petals are incident d-1 cells over τ d-2 cell
                petals = model.T[dim - 1][:, τ]
                # stem is the cell generating the cell generating the petals
                #TODO it should be one only ?!?
                stem = intersect(c[1, :].nzind, petals.nzind)[1]
                petal = get_closer_petal(τ, stem, sign(boundary[τ]))          # -sign(...) ??
                # the new petal and the stem must travel τ in opposit direction
                if model.T[dim - 1][stem, τ] == - model.T[dim - 1][petal, τ]
                    petal_sign = c[stem]
                elseif model.T[dim - 1][stem, τ] == model.T[dim - 1][petal, τ]
                    petal_sign = -c[stem]
                else
                    throw(ArgumentError("Something Weird Happened"))
                end

                # If petal was visited earlyer (is in c) then it must be visited discordely 
                @assert visited[petal] == 0 || other_sign[petal]==petal_sign "Incoherent Petal sign"
                # If petal already is in the corolla, then it should be with the same sign
                # (otherwise it is visite twice)
                if (corolla[petal] != 0) && (corolla[petal] != petal_sign)
                    @show "Cell $petal is visited twice during $dim-d TGW."
                end

                # Update Corolla if petal not visited yet
                if corolla[petal] == 0                                                              #TODO Change for twice visiting
                    corolla[petal] += petal_sign
                end

            end

            # Add corolla to c and update visited, other_sign, components coherently
            c += corolla'
            other_sign -= corolla
            visited += abs.(corolla)
            push!(components[comp_idx], filter(i -> corolla[i] != 0, 1 : lo_num)...)
            #=
            for cocell in corolla.nzind
                visited[cocell] += 1
                other_sign[cocell] -= corolla[cocell]
                push!(components[comp_idx], cocell)
            end
            =#

        end

        CAGD.addModelCells!(tgw_model, 3, c)

    end

    return tgw_model, components
end