datatype lambdaexp = V of int
                     | App of lambdaexp * lambdaexp
					 | Abs of int * lambdaexp;
local
					 
fun member([],y) = false
     | member(b::x,y) =  if y=b then true
                                 else member(x,y);
								 																
fun union([],[]) =nil
     | union([],y) = y
	 | union(x,[]) = x
     | union(x,a::y) = if member(x,a) then union(x,y)      
                           else union(x@[a],y);

fun bv(V w)            = nil
    | bv(App(x,y))     = union(bv(x),bv(y))
    | bv(Abs(u,v))     = union([u],bv(v));
						   
						   
fun getbvindex(x,bvlist,i) = if null(bvlist) then x
                                      else if(hd(bvlist)=x) then i
                                      else getbvindex(x,tl(bvlist),i+1);

fun getvarnum(V a) =    [a]
    | getvarnum(App(V a, lamexp)) = [a]@getvarnum(lamexp)
	| getvarnum(Abs(a, lamexp)) = [a]@getvarnum(lamexp)
	| getvarnum(App(V a, lamexp)) = [a]@getvarnum(lamexp);
	
fun max([],maxval:int) = maxval
	 | max(a::x,maxval:int) = if(a > maxval) then max(x,a) else max(x,maxval);
									  
fun mequal([],[]) =true
    |  mequal(x,[]) =false
    |  mequal([],y) =false	
    |  mequal(a::x,b::y) = if(a=b) then  mequal(x,y) else false;
																	

fun alpcon(V x,bvlist, bit,k)               =           if bit=1 then [x]
                                                             else [getbvindex(x,bvlist,k)]
	| alpcon(App(V a, V b),bvlist,bit,k)    =           if bit=1 then [a]@[b]
                                                             else[getbvindex(a,bvlist,k)]@[getbvindex(b,bvlist,k)]	
	| alpcon(Abs(p,lamexp),bvlist,bit,k)    =           [getbvindex(p,bvlist,k)]@alpcon(lamexp,bvlist,0,k) 
	| alpcon(App(V m,lamexp),bvlist,bit,k)  =           if bit=1 then [m]@alpcon(lamexp,bvlist,1,k)   
                                                             else [getbvindex(m,bvlist,k)]@alpcon(lamexp,bvlist,1,k);	
	 
in
fun alpha(x:lambdaexp,y:lambdaexp) = mequal(alpcon(x,bv(x),1,max([max(getvarnum(x),0)]@[max(getvarnum(y),0)],0)+1),alpcon(y,bv(y),1,max([max(getvarnum(x),0)]@[max(getvarnum(y),0)],0)+1))
end;
