export {
    "createSeedPair",
    "computeMixedVolume",
    "monodromySolve",
    "staticMonodromySolve",
    "dynamicMonodromySolve",
    "completeGraphInit",
    "flowerGraphInit",
    "dynamicFlowerSolve",
--    "ExtraNodeCount",
    "RandomPointFunction",
    "NumberOfEdges",
    "NumberOfNodes",
    "NumberOfRepeats",
    "StoppingCriterion",
    "GraphInitFunction",
    "SelectEdgeAndDirection",
    "BatchSize",
    "AugmentGraphFunction",
    "AugmentationStoppingCriterion",
    "randomWeights"}

-- in: PF, a system of polynomials in a ring of the form CC[parameters][variables]
--     point0, (as above)
--     s0, (as above)

-- change the behavior of random CC (pick uniformly in a unit disk)
old'random'Type = lookup(random,Type)
random Type := o -> R -> (
    if class R === ComplexField then (
	exp(2 * pi * random RR * ii)
	-- old code for Box-Mueller transform
	--us := apply(2, i -> random RR);
	--us = {sqrt(-2* log first us), 2*pi* last us};
	--first us * cos last us + ii * first us * sin last us
	) 
    else (old'random'Type o) R
    ) 

-- random complex vector
randomWeights = n -> matrix(CC, {apply(n,i->random CC)})

completeGraphInit = (G, p, node1, nnodes, nedges) -> (
    nextP := ((p0)->point {apply(#coordinates p0, i->exp(2*pi*ii*random RR))});
    for i from 1 to nnodes-1 do (
        addNode(G,nextP(p), pointArray {});
    );
    for i from 0 to nnodes-1 do (
        for j from i+1 to nnodes-1 do (
            apply(nedges, k -> addEdge(G, G.Vertices#i, G.Vertices#j));
        );
    );
    )

dynamicFlowerSolve = method(Options=>{TargetSolutionCount=>null,RandomPointFunction=>null,StoppingCriterion=>((n,L)->n>3)})
dynamicFlowerSolve (Matrix, Point, List) := o -> (PF,point0,s0) -> (
	if #s0 < 1 then error "at least one solution expected";  
	p0 := matrix point0; -- points are row matrices
	stoppingCriterion := o.StoppingCriterion;
	if o.TargetSolutionCount =!= null then (
		stoppingCriterion = (n,L) -> (length L >= o.TargetSolutionCount);
	);
	nParameters := numgens coefficientRing ring PF;
	assert(nParameters == numcols p0);
	(PR,toPR) := flattenRing ring PF; -- ring PF = C[a][x]
	-- toPR: ring PF -> PR
	X := drop(gens PR, -nParameters); 
	PF = toPR PF;
	C := coefficientRing PR;
	R := C[X];
	X = vars R;
	nextP := if o.RandomPointFunction =!= null then o.RandomPointFunction else (
		K := ring p0;
		()->point {apply(numcols p0, i->exp(2*pi*ii*random RR))}
	); 
	sols0 := s0;
	nSols := #sols0; 
	same := 0;
	dir := temporaryFileName(); -- build a directory to store temporary data 
	makeDirectory dir;
	nPathsTracked := 0;
	<< "--backup directory created: "<< toString dir << endl;
	while not stoppingCriterion(same,sols0) do (
		p1 := matrix nextP(); -- row matrix
		F0 := flatten entries (map(R,PR,X|p0)) PF;
		F1 := flatten entries (map(R,PR,X|p1)) PF;
		elapsedTime sols1 := track(F0,F1,sols0);
		nPathsTracked = nPathsTracked + #sols0;
		sols1 = select(sols1, s->status s === Regular);
		<< "  H01: " << #sols1 << endl;
		elapsedTime sols0' := track(F1,F0,gamma=>exp(2*pi*ii*random RR),sols1);
		nPathsTracked = nPathsTracked + #sols1;
		sols0' = select(sols0', s->status s === Regular);
		<< "  H10: " << #sols0' << endl;
		elapsedTime sols0 = clusterSolutions(sols0 | sols0'); -- take the union	
		<< "number of paths tracked: " << nPathsTracked << endl;
		if #sols0 == nSols then same = same + 1 else (
			nSols = #sols0; 
			same = 0;
			ff := openOut (dir|"/backup-"|toString nSols|"-solutions"); 
			ff << toExternalString sols0;
			close ff;
		);
		<< "found " << #sols0 << " points in the fiber so far" << endl;
	); -- else print "something went wrong"

	(sols0,nPathsTracked)
)

computeMixedVolume = method()
computeMixedVolume List := polys -> mixedVolume(toRingXphc polys,StartSystem => false)

-- static flower
flowerGraphInit = (G, p, node1, nnodes, nedges) -> (
	nextP := ((p0)->point {apply(#coordinates p0, i->exp(2*pi*ii*random RR))});
	for i from 1 to nnodes do (
		newNode := addNode(G,nextP(p), pointArray {});
		apply(nedges, k -> addEdge(G, node1, newNode));
	);
)

-- find the "seed" for the parametric system
createSeedPair = method(Options=>{"initial parameters" => "random unit"})
createSeedPair PolySystem := o -> G -> (
	R := ring G;   
	C := coefficientRing coefficientRing R; 
	init := o#"initial parameters";
	createSeedPair(G,
		if init == "random unit" then apply(numgens R, i->(x:=random C; x/abs x))
		else if init == "random" then apply(numgens R, i->random C)
		else if init == "one" then toList(numgens R:1_C)
		else error "unknown option"
	)
)
createSeedPair(PolySystem, List) := o -> (G, L) -> (
    SubList := apply(toList(0..numgens ring G-1), i -> (gens ring G)#i => L#i);
    subZeros := apply(gens coefficientRing ring G, g -> g => 0);
    C := coefficientRing ring G;
    M := sub(sub(G.PolyMap, SubList), C);
    M = flatten entries generators ideal M; 
    b := sub(matrix {apply(M, m-> sub(m, subZeros))}, coefficientRing coefficientRing ring G);
    l := apply(M, g -> (coefficients(g, Monomials => gens C))#1);
    A := l#0;
    for i from 1 to length l - 1 do A = A | l#i;
    A = sub(A, coefficientRing coefficientRing ring G);
    K := numericalKernel(transpose A, 1e-6);
    offset := solve(transpose A,transpose b,ClosestFit=>true);
    -- K's columns are a basis for the kernel i indexes the 'most likely true positive'
    --v := K * transpose matrix {toList ((numcols K):1_CC)};  
    w := transpose randomWeights(numcols K);
    v := K * w + offset;
    c0 := point matrix v;
    -- N := numericalIrreducibleDecomposition ideal M; -- REPLACE this with linear algebra (using numericalKernel)
    --c0 := first (first components N).Points; 
    pre0 := point{apply(SubList, i -> i#1)};
    G0 := specializeSystem(c0,G);
    pre0' := first refine(G0,{pre0});
    (c0,pre0')
    )

staticMonodromySolve = method(Options=>{
	TargetSolutionCount => null,
	StoppingCriterion => null,
	SelectEdgeAndDirection => null,
	GraphInitFunction => null,
	BatchSize => null,
	Potential => null,
	NumberOfNodes => null,
	NumberOfEdges => null,
	NumberOfRepeats => null,
	"new tracking routine" => true, -- uses old "track" if false
	Verbose => false})
staticMonodromySolve (PolySystem, Point, List) := o -> (PS,point0,s0) -> (
	USEtrackHomotopy = (getDefault Software === M2engine and o#"new tracking routine");
	mutableOptions := new MutableHashTable from o;
	if mutableOptions.TargetSolutionCount =!= null then
		mutableOptions.StoppingCriterion = (n,L) -> (length L >= mutableOptions.TargetSolutionCount or n >= mutableOptions.NumberOfRepeats);

	if mutableOptions.StoppingCriterion === null then 
		mutableOptions.StoppingCriterion = (n,L) -> n >= mutableOptions.NumberOfRepeats;
		
	HG := homotopyGraph(PS, Potential=>o.Potential);
	if o.TargetSolutionCount =!= null then (
		HG.TargetSolutionCount = o.TargetSolutionCount;
	);
	PA := pointArray s0;
	node1 := addNode(HG, point0, PA);
	setTrackTime(HG,0);

	if #s0 < 1 then error "at least one solution expected";

	o.GraphInitFunction(HG, point0, node1, o.NumberOfNodes, o.NumberOfEdges);
	--Needs to return HG for use by dynamicMonodromySolve
	(coreMonodromySolve(HG,node1, new OptionTable from (new HashTable from mutableOptions)), HG)
)

TEST /// 
restart
needsPackage "MonodromySolver"
R = CC[a,b,c,d][A,B]
polys = polySystem {A*a+B*b,A*B*c+d}
(p0,x0) := createSeedPair polys
monodromySolve(polys,p0,{x0},SelectEdgeAndDirection=>selectRandomEdgeAndDirection)
///

monodromySolve = method(Options=>{
	TargetSolutionCount => null,
	SelectEdgeAndDirection => selectRandomEdgeAndDirection,
	GraphInitFunction => completeGraphInit,
	AugmentGraphFunction => null,
	AugmentationStoppingCriterion => null,
	BatchSize => infinity,
	Potential => null,
	NumberOfNodes => 2,
	NumberOfEdges => 3,
	NumberOfRepeats => 10,
	"new tracking routine" => true, -- uses old "track" if false
	Verbose => false})
monodromySolve (Matrix, Point, List) := o -> (PF,point0,s0) -> monodromySolve(polySystem transpose PF, point0, s0, o)
monodromySolve (PolySystem, Point, List) := o -> (PS,point0,s0) -> (
	if o.AugmentGraphFunction =!= null then
		result := dynamicMonodromySolve(PS,point0,s0)
	else if o.AugmentationStoppingCriterion =!= null then 
		error "AugmentationStoppingCriterion does not work if AugmentGraphFunction is undefined"
	else (
		(result,HG) := staticMonodromySolve(PS, point0, s0, trimDynamicOptions(o));
	);
	result
);

trimDynamicOptions = method()
trimDynamicOptions OptionTable := opt -> (
	mutableOptions := new MutableHashTable from opt;
	
	--if we ever add more dynamic-only options, add them into dynamicOptions.
	dynamicOptions := (AugmentGraphFunction, AugmentationStoppingCriterion); 
	for opt in dynamicOptions do (remove(mutableOptions,opt));
	
	new OptionTable from (new HashTable from mutableOptions)
)

dynamicMonodromySolve = method(Options=>{
	TargetSolutionCount => null,
	SelectEdgeAndDirection => null,
	StoppingCriterion => null,
	GraphInitFunction => null,
	AugmentGraphFunction => null, --NEED SOME DEFAULT HERE. Add edge(s)? Add node?
	AugmentationStoppingCriterion => null,
	BatchSize => null,
	Potential => null,
	NumberOfNodes => null,
	NumberOfEdges => null,
	NumberOfRepeats => null,
	"new tracking routine" => true, -- uses old "track" if false
	Verbose => false})
dynamicMonodromySolve (PolySystem, Point, List) := o -> (PS,point0,s0) -> (
	staticOptions := trimDynamicOptions(o);

	{*
	(staticMSReturn,HG) = staticMonodromySolve(PS,point0,s0,staticOptions);
	(node1,npaths) = staticMSReturn;
	success := npaths != "failed";
	while not success and not o.AugmentationStoppingCriterion do (
		o.AugmentGraphFunction(HG);
		(node1,npaths) = coreMonodromySolve(HG, node1, staticOptions);
		success = npaths != "failed";
	)
	(node1,npaths)
	*}
)

-- main function
coreMonodromySolve = method(Options=>{
	TargetSolutionCount => null,
	StoppingCriterion => null,
	SelectEdgeAndDirection => null,
	GraphInitFunction => null,
	BatchSize => null,
	Potential => null,
	NumberOfNodes => null,
	NumberOfEdges => null,
	NumberOfRepeats => 10,
	"new tracking routine" => true, -- uses old "track" if false
	Verbose => false})
coreMonodromySolve (HomotopyGraph, HomotopyNode) := o -> (HG,node1) -> (
	selectEdgeAndDirection := o.SelectEdgeAndDirection;
	same := 0;
	npaths := 0;    
	lastNode := node1;
	while not o.StoppingCriterion(same,lastNode.PartialSols) do (
		(e, from1to2) := selectEdgeAndDirection(HG);
		if o.Verbose then (
			-- << "Correspondences are " << keys e.Correspondence12;
			if e.?Potential12 then << " (potential12 = " << e.Potential12 << ")";
			-- << " and " << keys e.Correspondence21;
			if e.?Potential21 then << " (potential21 = " << e.Potential21 << ")";
			<< endl << "Direction is " << from1to2 << endl;
			<< "-------------------------------------------------" << endl;
		);
		lastNode = if from1to2 then e.Node2 else e.Node1;
		nKnownPoints := length lastNode.PartialSols;
		trackedPaths := trackEdge(e, from1to2, o.BatchSize);
		npaths = npaths + trackedPaths;
		if o.Verbose then (
			<< "  node1: " << length e.Node1.PartialSols << endl;
			<< "  node2: " << length e.Node2.PartialSols << endl;    	
			<< "trackedPaths " << trackedPaths << endl; 
		);
		if length lastNode.PartialSols == nKnownPoints 
		then same = same + 1 else same = 0;
	);
	if o.TargetSolutionCount =!= null and o.TargetSolutionCount != length lastNode.PartialSols 
	then npaths = "failed";
	(lastNode, npaths)
)

end

------------------------------------------
------------------------------------------
-- Documentation
------------------------------------------
------------------------------------------

beginDocumentation()

doc ///
  Key
      monodromySolve
      (monodromySolve, Matrix, Point, List)
      (monodromySolve, PolySystem, Point, List)
  Headline
      Finds solutions for a given polynomial system (generic relative to a given family) given some seed solution.
  Usage
      (N,m) = monodromySolve(SP, c0, {pre0})
      (N,m) = monodromySolve(polys, c0, {pre0})
  Inputs
      SP:Matrix
      polys:PolySystem
      c0:Point
      p0:Point
  Outputs
      N:HomotopyNode
      m:ZZ
  Description
      Text      
          There are a lot of options. Where should we describe these?
///