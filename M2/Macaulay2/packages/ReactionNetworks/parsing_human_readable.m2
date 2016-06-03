restart
errorDepth = 0 
needs "ReactionNetworks.m2"
-- string in "human-readable format"
string = "A <--> 2B, A + C <--> D, B + E --> A + C, D --> B + E"

reactions = separateRegexp(",", string)
reactionNetwork reactions


help "new"

restart
needsPackage "Graphs"
ReactionNetwork = new Type from MutableHashTable

addReaction

methods digraph
reactionNetwork = method()
reactionNetwork := () -> new ReactionNetwork from {Species => {}, Complexes => {}, ReactionGraph => digraph {}}
reactionNetwork List := rs -> (
    Rn := reactionNetwork();
    scan(rs, r -> addReaction(r,Rn));
    Rn
    )

addSpecies = method()
addSpecies(String, ReactionNetwork) := (s,Rn) -> 
    if not member(s,Rn.Species) then (
	Rn.Species = Rn.Species | {s};
	Rn.Complexes = apply(Rn.Complexes, c -> c | matrix{{0}})
	)
    

addComplex = method()
addComplex(String, ReactionNetwork) := (c,Rn) -> (
    species := delete("", separateRegexp("[^A-Z]", c));
    for specie in species do addSpecies(specie, Rn);
    v := mutableMatrix(ZZ,1,#Rn.Species);	
    apply(separateRegexp("\\+", c), t -> (
	    s:=separateRegexp("[0-9]", t);
	    a:=value separateRegexp("[A-Z]", t);
	    i:=position(Rn.Species, s' -> s' == s);
	    v#i = v#i + a;
	    ));
    v = matrix v;
    if member(v,Rn.Complexes) then position(v,Rn.Complexes) 
    else (
	Rn.Complexes = Rn.Complexes | {v};
        #Rn.Complexes - 1
	)
    )

addReaction = method()
addReaction(String, ReactionNetwork) := (r,Rn) -> (
    r = removeWhitespace r;
    complexes := apply(separateRegexp("(-->)|(<--)|(<-->)|,", r), removeWhitespace);
    if #complexes != 2 then error "Expected two complexes.";
    i := addComplex(first complexes, Rn);
    j := addComplex(last complexes, Rn);
    delim = concatenate separateRegexp(///[A-Z]|[0-9]|,|\+| ///, r)
    if delim == "-->" then Rn.ReactionGraph = addEdges'(Rn.ReactionGraph, {{i,j}})
    else if delim == "<--" then Rn.ReactionGraph = addEdges'(Rn.ReactionGraph, {{j,i}})
    else if delim == "<-->" Rn.ReactionGraph = addEdges'(Rn.ReactionGraph, {{i,j},{j,i}})
    else error "String not in expected format";
    )
 
 
 
-- now build the hash table
CRN = new ReactionNetwork from {
    Species => {"A","B","C","D","E"}, 
    Complexes => {matrix {{1,0,0,0,0}}, matrix {{0,2,0,0,0}}, matrix {{1,0,1,0,0}}, 
	          matrix {{0,0,0,1,0}}, matrix {{0,1,0,0,1}}},
    ReactionGraph => digraph({{0,1}, {1,0}, {2,3}, {3,2}, {4,2}, {3,4}}, EntryMode => "edges")
    }


netComplex = (r,c) -> (
    C := flatten entries r.Complexes#c;
    l := apply(#r.Species, i -> if C#i == 0 then "" 
	else (if C#i ==1 then "" else toString C#i) | r.Species#i);
    l = delete("", l);
    l = between("+", l);
    concatenate l
    )
net ReactionNetwork := r -> stack apply(edges r.ReactionGraph, e -> netComplex(r, first e) | "-->" | 
    netComplex(r, last e))

help stack
CRN 
CRN.ReactionGraph


needsPackage "Graphs"
    help(digraph)

complexes

-- what I'd like to do: 
-- 1) initialize ReactionGraph as a mutable hash table whose keys comprise the list complexes,
-- 2) for each complex, scan the list reactions and append to its list of values 'edges' of the form 
-- (neighboring complex, fwd_rate, bkwd_rate)  where each rate is either a new parameter or zero, 
-- as determined by the corresponding delimiter (-->, <--, or <-->)

scan(complexes, complex -> ReactionGraph#complex = { })
keys reactionGraph

help MutableHashTable

-- not current correct, should move through heads one at at time and only select those tails which count
stripped = apply(reactions, reaction -> separateRegexp("[--]", reaction))
fwds = apply(stripped, reaction -> match(">", reaction#2))
revs = apply(stripped, reaction -> match("<", reaction#0))
heads = apply(stripped, reaction -> concatenate separateRegexp("[^A-Z..+]", reaction#0))
tails = apply(stripped, reaction -> concatenate separateRegexp("[^A-Z..+]", reaction#2))

for i from 0 to length(heads)-1 do( append(ReactionGraph#(heads#i), tails#i))
keys ReactionGraph#"A"
for i from 0 to length(heads)-1 do( append(ReactionGraph#(tails#i), {heads#i}))
heads
tails
heads#i in keys ReactionGraph
ReactionGraph#"A+C"
describe ReactionGraph

reactions
