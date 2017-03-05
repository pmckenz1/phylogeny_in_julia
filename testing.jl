##################################################
function readtree(file, treenames = "")
  function unname(treetext)
    nc = length(treetext)
    tstart = 1
    while treetext[tstart] != '(' && tstart <= nc
      tstart = tstart + 1
    end
    if tstart > 1
      return [treetext[1:(tstart-1)], treetext[tstart:nc]]
    end
    return vcat("",treetext)
  end

  tree = readstring(file)
  tree = replace(tree,r"[ \t]", s"")
  y = matchall(r";",tree)

  #Function that gets the indices of matches.
  function getoffsets(arrayname)
    x = Array(Int64,0)
    for i in 1:length(arrayname)
      append!(x,(arrayname[i].offset+1))
    end
    return x
  end
  y = getoffsets(y)
  Ntree = length(y)
  x = 1
  if Ntree > 1
    x = vcat(Int64(1),(y[1:(end-1)]+1))
  end
  STRING = Array(String,0)
  for i in 1:Ntree
    tmp = tree[x[i]:y[i]]
    tmp = replace(tmp,r"\\[[^]]*\\]", s"")
    push!(STRING, tmp)
  end
  tmp = Array(String,0)
  for i in 1:length(STRING)
    tmp = vcat(tmp,unname(STRING[i]))
  end

  tmpnames = tmp[1:2:end]
  STRING = tmp[2:2:end]

  if length(treenames) == 0 && sum(map(length,tmpnames)) > 0
    treenames <- tmpnames
  end

  colons = map(STRING) do x
    typeof(match(r":",x)) == RegexMatch
  end

#  if sum(colons) == 0
#    map(cladobuild,STRING)
#  end
#  if sum(colons) > 0
#    map(treebuild,STRING)
#  end
  return(STRING)
end
###Still need to include rooting bit
