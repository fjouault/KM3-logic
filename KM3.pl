/* KM3 metametamodel definition */

node(km3,package).
prop(km3,name,"KM3").
edge(km3,modelElement,contents).
edge(modelElement,km3,me_package).
edge(km3,package,contents).
edge(package,km3,me_package).
edge(km3,classifier,contents).
edge(classifier,km3,me_package).
edge(km3,dataType,contents).
edge(dataType,km3,me_package).
edge(km3,class,contents).
edge(class,km3,me_package).
edge(km3,structuralFeature,contents).
edge(structuralFeature,km3,me_package).
edge(km3,reference,contents).
edge(reference,km3,me_package).
edge(km3,attribute,contents).
edge(attribute,km3,me_package).
edge(km3,boolean,contents).
edge(boolean,km3,me_package).
edge(km3,integer,contents).
edge(integer,km3,me_package).
edge(km3,string,contents).
edge(string,km3,me_package).

	/* class KM3!ModelElement */
	node(modelElement,class).
	prop(modelElement,name,"ModelElement").
	prop(modelElement,isAbstract,true).

		/* attribute KM3!ModelElement.name : String */
		node(name,attribute).
		prop(name,name,"name").
		prop(name,lower,1).
		prop(name,upper,1).
		prop(name,isOrdered,false).
		prop(name,isUnique,false).
		edge(modelElement,name,features).
		edge(name,modelElement,owner).
		edge(name,string,type).

		/* reference KM3!ModelElement.package : KM3!Package oppositeOf contents */
		node(me_package,reference).
		prop(me_package,name,"package").
		prop(me_package,isContainer,false).
		prop(me_package,lower,0).
		prop(me_package,upper,1).
		prop(me_package,isOrdered,false).
		prop(me_package,isUnique,false).
		edge(modelElement,me_package,features).
		edge(me_package,modelElement,owner).
		edge(me_package,package,type).
		edge(me_package,contents,opposite).

	/* class KM3!Package extends KM3!ModelElement */
	node(package,class).
	prop(package,name,"Package").
	prop(package,isAbstract,false).
	edge(package,modelElement,supertypes).

		/* reference KM3!Package.contents[*] ordered container : KM3!ModelElement oppositeOf package */
		node(contents,reference).
		prop(contents,name,"contents").
		prop(contents,isContainer,true).
		prop(contents,lower,0).
		prop(contents,upper,-1).
		prop(contents,isOrdered,false).
		prop(contents,isUnique,false).
		edge(package,contents,features).
		edge(contents,package,owner).
		edge(contents,modelElement,type).
		edge(contents,me_package,opposite).

	/* class KM3!Classifier extends KM3!ModelElement */
	node(classifier,class).
	prop(classifier,name,"Classifier").
	prop(classifier,isAbstract,true).
	edge(classifier,modelElement,supertypes).

	/* class KM3!DataType extends KM3!Classifier */
	node(dataType,class).
	prop(dataType,name,"DataType").
	prop(dataType,isAbstract,false).
	edge(dataType,classifier,supertypes).

	/* class KM3!Class extends KM3!Classifier */
	node(class,class).
	prop(class,name,"Class").
	prop(class,isAbstract,false).
	edge(class,classifier,supertypes).

		/* attribute KM3!Class.isAbstract : Boolean */
		node(isAbstract,attribute).
		prop(isAbstract,name,"isAbstract").
		prop(isAbstract,lower,1).
		prop(isAbstract,upper,1).
		prop(isAbstract,isOrdered,false).
		prop(isAbstract,isUnique,false).
		edge(class,isAbstract,features).
		edge(isAbstract,class,owner).
		edge(isAbstract,boolean,type).

		/* reference KM3!Class.features[*] ordered container : KM3!StructuralFeature oppositeOf owner */
		node(features,reference).
		prop(features,name,"structuralFeatures").
		prop(features,isContainer,true).
		prop(features,lower,0).
		prop(features,upper,-1).
		prop(features,isOrdered,true).
		prop(features,isUnique,true).
		edge(class,features,features).
		edge(features,class,owner).
		edge(features,structuralFeature,type).
		edge(features,owner,opposite).

		/* reference KM3!Class.supertypes[*] : KM3!Class */
		node(supertypes,reference).
		prop(supertypes,name,"supertypes").
		prop(supertypes,isContainer,false).
		prop(supertypes,lower,0).
		prop(supertypes,upper,-1).
		prop(supertypes,isOrdered,false).
		prop(supertypes,isUnique,true).
		edge(class,supertypes,features).
		edge(supertypes,class,owner).
		edge(supertypes,class,type).

	/* abstract class KM3!StructuralFeature extends KM3!ModelElement */
	node(structuralFeature,class).
	prop(structuralFeature,name,"StructuralFeature").
	prop(structuralFeature,isAbstract,true).
	edge(structuralFeature,modelElement,supertypes).

		/* attribute KM3!StructuralFeature.lower : Integer */
		node(lower,attribute).
		prop(lower,name,"lower").
		prop(lower,lower,1).
		prop(lower,upper,1).
		prop(lower,isOrdered,false).
		prop(lower,isUnique,false).
		edge(structuralFeature,lower,features).
		edge(lower,structuralFeature,owner).
		edge(lower,integer,type).

		/* attribute KM3!StructuralFeature.upper : Integer */
		node(upper,attribute).
		prop(upper,name,"upper").
		prop(upper,lower,1).
		prop(upper,upper,1).
		prop(upper,isOrdered,false).
		prop(upper,isUnique,false).
		edge(structuralFeature,upper,features).
		edge(upper,structuralFeature,owner).
		edge(upper,integer,type).

		/* attribute KM3!StructuralFeature.isOrdered : Boolean */
		node(isOrdered,attribute).
		prop(isOrdered,name,"isOrdered").
		prop(isOrdered,lower,1).
		prop(isOrdered,upper,1).
		prop(isOrdered,isOrdered,false).
		prop(isOrdered,isUnique,false).
		edge(structuralFeature,isOrdered,features).
		edge(isOrdered,structuralFeature,owner).
		edge(isOrdered,boolean,type).

		/* attribute KM3!StructuralFeature.isUnique : Boolean */
		node(isUnique,attribute).
		prop(isUnique,name,"isUnique").
		prop(isUnique,lower,1).
		prop(isUnique,upper,1).
		prop(isUnique,isOrdered,false).
		prop(isUnique,isUnique,false).
		edge(structuralFeature,isUnique,features).
		edge(isUnique,structuralFeature,owner).
		edge(isUnique,boolean,type).

		/* reference KM3!StructuralFeature.owner : KM3!Class oppositeOf features */
		node(owner,reference).
		prop(owner,name,"owner").
		prop(owner,isContainer,false).
		prop(owner,lower,1).
		prop(owner,upper,1).
		prop(owner,isOrdered,false).
		prop(owner,isUnique,false).
		edge(structuralFeature,owner,features).
		edge(owner,structuralFeature,owner).
		edge(owner,class,type).
		edge(owner,features,opposite).

		/* reference KM3!StructuralFeature.type : KM3!Class */
		node(type,reference).
		prop(type,name,"type").
		prop(type,isContainer,false).
		prop(type,lower,1).
		prop(type,upper,1).
		prop(type,isOrdered,false).
		prop(type,isUnique,false).
		edge(structuralFeature,type,features).
		edge(type,structuralFeature,owner).
		edge(type,classifier,type).

	/* class KM3!Reference extends KM3!StructuralFeature */
	node(reference,class).
	prop(reference,name,"Reference").
	prop(reference,isAbstract,false).
	edge(reference,structuralFeature,supertypes).

		/* attribute KM3!Reference.isContainer : Boolean */
		node(isContainer,attribute).
		prop(isContainer,name,"isContainer").
		prop(isContainer,lower,1).
		prop(isContainer,upper,1).
		prop(isContainer,isOrdered,false).
		prop(isContainer,isUnique,false).
		edge(reference,isContainer,features).
		edge(isContainer,reference,owner).
		edge(isContainer,boolean,type).

		/* reference KM3!Reference.opposite : KM3!Reference */
		node(opposite,reference).
		prop(opposite,name,"opposite").
		prop(opposite,isContainer,false).
		prop(opposite,lower,0).
		prop(opposite,upper,1).
		prop(opposite,isOrdered,false).
		prop(opposite,isUnique,false).
		edge(reference,opposite,features).
		edge(opposite,reference,owner).
		edge(opposite,reference,type).

	/* class KM3!Attribute extends KM3!StructuralFeature */
	node(attribute,class).
	prop(attribute,name,"Attribute").
	prop(attribute,isAbstract,false).
	edge(attribute,structuralFeature,supertypes).

	/* datatype Boolean */
	node(boolean,dataType).
	prop(boolean,name,"Boolean").

	/* datatype Integer */
	node(integer,dataType).
	prop(integer,name,"Integer").

	/* datatype String */
	node(string,dataType).
	prop(string,name,"String").



is_boolean(true).
is_boolean(false).
% tests if X is a string (not a swi-prolog string but a list of integers [n1,n2,...], equivalent to "\n1\n2...")
is_string(X) :- is_list(X), member(C,X), integer(C).

/*
	Navigation helpers
*/
structuralFeatures(Class,X) :- edge(Class,X,features).
allStructuralFeatures(Class,X) :- structuralFeatures(Class,X).
allStructuralFeatures(Class,X) :- supertypes(Class,SuperClass), allStructuralFeatures(SuperClass,X).

conformsTo(Class1,Class2) :- supertypes(Class1,Class2).
conformsTo(Class1,Class2) :- supertypes(Class1,SuperClass), conformsTo(SuperClass,Class2).

isTypeOf(X,Type) :- node(X,Type).

isKindOf(X,Type) :- isTypeOf(X,Type).
isKindOf(X,Type) :- isTypeOf(X,SomeType), conformsTo(SomeType,Type).

supertypes(Class,X) :- edge(Class,X,supertypes).
allSupertypes(Class,X) :- supertypes(Class,X).
allSupertypes(Class,X) :- supertypes(Class,SuperClass), supertypes(SuperClass,X).

subtypes(Class,X) :- supertypes(X,Class).
allSubtypes(Class,X) :- subtypes(Class,X).
allSubtypes(Class,X) :- subtypes(Class,SubClass), allSubtypes(SubClass,X).

oppositeOf(X,Y) :- node(X,reference), node(Y,reference), edge(X,Y,opposite).

lookupElement(Class,ElementName,Element) :- structuralFeatures(Class,Element), prop(Element,name,ElementName).
lookupElementExtended(Class,ElementName,Element) :- allStructuralFeatures(Class,Element), prop(Element,name,ElementName).




className(Class,Name) :- isTypeOf(Class,class), prop(Class,name,Name).
packageName(Package,Name) :- node(Package,package), prop(Package,name,NameAsList), string_to_list(Name,NameAsList).


/* WFRs */
% gives one error per call... should be improved
hasErrors :- wfr(M,X,Y,Z), writef(M,[X,Y,Z]).
hasErrors :- wfr(M,X,Y), writef(M,[X,Y]).
hasErrors :- wfr(M,X), writef(M,[X]).

wfr('The type of node %w should be a class.',X) :-
	node(X,Y), not(node(Y,class)).
wfr('Node %w is defined twice with different types %w and %w.',X,Y,Z) :-
	node(X,Y), node(X,Z), \=(Y,Z).
wfr('The type of edge %w->%w should be a reference.',X,Y) :-
	edge(X,Y,Z), not(node(Z, reference)).
wfr('The opposite of reference %w is reference %w, but the reverse is not true.',X,Y) :-
	node(X,reference), edge(X,Y,opposite), not(edge(Y,X,opposite)).
wfr('The opposite of reference %w is reference %w, but the type of the second is not the owner of the first.',X,Y) :-
	node(X,reference), edge(X,XOwner,owner), edge(X,Y,opposite), not(edge(Y,XOwner,type)).
wfr('The target of edge %w->%w is not a valid node.',X,Y) :-
	edge(X,Y,_), not(node(Y,_)).
wfr('The source of edge %w->%w is not a valid node.',X,Y) :-
	edge(X,Y,_), not(node(X,_)).
wfr('The source of edge %w->%w does not have a correct type.',X,Y) :-
	edge(X,Y,Reference), edge(Reference,SourceType,owner), not(isKindOf(X,SourceType)).
wfr('The target of edge %w->%w does not have a correct type.',X,Y) :-
	edge(X,Y,Reference), edge(Reference,TargetType,type), not(isKindOf(Y,TargetType)).
wfr('Edge %w->%w does not have an opposite with appropriate type.',X,Y) :-
	edge(X,Y,Z), oppositeOf(Z,O), not(edge(Y,X,O)).
wfr('%w is an instance of abstract type %w, which is forbidden.',X,Y) :-
	node(X,Y), prop(Y,isAbstract,true).
wfr('Attribute %w is not valid for %w.',X,Y) :-
	prop(Y,X,_), isTypeOf(Y,YType), not(allStructuralFeatures(YType,X)).
wfr('Property %w of %w should be of type Integer.',X,Y) :-
	prop(Y,X,V), edge(X,T,type), node(T,dataType), prop(T,name,"Integer"), not(integer(V)).
wfr('Property %w of %w should be of type String.',X,Y) :-
	prop(Y,X,V), edge(X,T,type), node(T,dataType), prop(T,name,"String"), not(is_string(V)).
wfr('Property %w of %w should be of type Boolean.',X,Y) :-
	prop(Y,X,V), edge(X,T,type), node(T,dataType), prop(T,name,"Boolean"), not(is_boolean(V)).
wfr('Classifier %w should be in a package.',X) :-
	isKindOf(X,classifier), not(edge(X,_,me_package)).
wfr('Element %w should have a value for attribute %w.',X,Y) :-
	isTypeOf(X,XType), allStructuralFeatures(XType,Y), node(Y,attribute), not(prop(Y,lower,0)), not(prop(X,Y,_)).
wfr('Element %w should have a value for reference %w.',X,Y) :-
	isTypeOf(X,XType), allStructuralFeatures(XType,Y), node(Y,reference), not(prop(Y,lower,0)), not(edge(X,_,Y)).
wfr('Element %w is contained in both %w and %w.',X,Y,Z) :-
  	edge(X,Y,F1), edge(X,Z,F2), oppositeOf(F1,OF1), oppositeOf(F2,OF2), prop(OF1,isContainer,true), prop(OF2,isContainer,true), \=(F1,F2).
/* Metamodel: PN */

node(pn,package).
prop(pn,name,"PN").
edge(pn,pnElement,contents).
edge(pnElement,pn,me_package).
edge(pn,place,contents).
edge(place,pn,me_package).
edge(pn,transition,contents).
edge(transition,pn,me_package).
edge(pn,arcpt,contents).
edge(arcpt,pn,me_package).
edge(pn,arctp,contents).
edge(arctp,pn,me_package).

	/* class PN!PNElement */
	node(pnElement,class).
	prop(pnElement,name,"PNElement").
	prop(pnElement,isAbstract,true).

		/* attribute PN!PNElement.name : String */
		node(pn_name,attribute).
		prop(pn_name,name,"name").
		prop(pn_name,lower,1).
		prop(pn_name,upper,1).
		prop(pn_name,isOrdered,false).
		prop(pn_name,isUnique,false).
		edge(pnElement,pn_name,features).
		edge(pn_name,pnElement,owner).
		edge(pn_name,string,type).

	/* class PN!Place */
	node(place,class).
	prop(place,name,"Place").
	prop(place,isAbstract,false).
	edge(place,pnElement,supertypes).

		/* reference PN!Place.incomingArcs[*] : PN!ArcTP oppositeOf target */
		node(place_incomingArcs,reference).
		prop(place_incomingArcs,name,"incomingArcs").
		prop(place_incomingArcs,isContainer,false).
		prop(place_incomingArcs,lower,0).
		prop(place_incomingArcs,upper,-1).
		prop(place_incomingArcs,isOrdered,false).
		prop(place_incomingArcs,isUnique,true).
		edge(place,place_incomingArcs,features).
		edge(place_incomingArcs,place,owner).
		edge(place_incomingArcs,arctp,type).
		edge(place_incomingArcs,arctp_target,opposite).

		/* reference PN!Place.outgoingArcs[*] : PN!ArcPT oppositeOf source */
		node(place_outgoingArcs,reference).
		prop(place_outgoingArcs,name,"outgoingArcs").
		prop(place_outgoingArcs,isContainer,false).
		prop(place_outgoingArcs,lower,0).
		prop(place_outgoingArcs,upper,-1).
		prop(place_outgoingArcs,isOrdered,false).
		prop(place_outgoingArcs,isUnique,true).
		edge(place,place_outgoingArcs,features).
		edge(place_outgoingArcs,place,owner).
		edge(place_outgoingArcs,arcpt,type).
		edge(place_outgoingArcs,arcpt_source,opposite).

	/* class PN!Transition */
	node(transition,class).
	prop(transition,name,"Transition").
	prop(transition,isAbstract,false).
	edge(transition,pnElement,supertypes).

		/* reference PN!Transition.incomingArcs[*] : PN!ArcPT oppositeOf target */
		node(transition_incomingArcs,reference).
		prop(transition_incomingArcs,name,"incomingArcs").
		prop(transition_incomingArcs,isContainer,false).
		prop(transition_incomingArcs,lower,0).
		prop(transition_incomingArcs,upper,-1).
		prop(transition_incomingArcs,isOrdered,false).
		prop(transition_incomingArcs,isUnique,true).
		edge(transition,transition_incomingArcs,features).
		edge(transition_incomingArcs,transition,owner).
		edge(transition_incomingArcs,arcpt,type).
		edge(transition_incomingArcs,arcpt_target,opposite).

		/* reference PN!Transition.outgoingArcs[*] : PN!ArcTP oppositeOf source */
		node(transition_outgoingArcs,reference).
		prop(transition_outgoingArcs,name,"outgoingArcs").
		prop(transition_outgoingArcs,isContainer,false).
		prop(transition_outgoingArcs,lower,0).
		prop(transition_outgoingArcs,upper,0).
		prop(transition_outgoingArcs,isOrdered,false).
		prop(transition_outgoingArcs,isUnique,false).
		edge(transition,transition_outgoingArcs,features).
		edge(transition_outgoingArcs,transition,owner).
		edge(transition_outgoingArcs,arctp,type).
		edge(transition_outgoingArcs,arctp_source,opposite).

	/* class PN!ArcPT */
	node(arcpt,class).
	prop(arcpt,name,"ArcPT").
	prop(arcpt,isAbstract,false).
	edge(arcpt,pnElement,supertypes).

		/* reference PN!ArcPT.source : PN!Place oppositeOf outgoingArcs */
		node(arcpt_source,reference).
		prop(arcpt_source,name,"source").
		prop(arcpt_source,isContainer,false).
		prop(arcpt_source,lower,1).
		prop(arcpt_source,upper,1).
		prop(arcpt_source,isOrdered,false).
		prop(arcpt_source,isUnique,false).
		edge(arcpt,arcpt_source,features).
		edge(arcpt_source,arcpt,owner).
		edge(arcpt_source,place,type).
		edge(arcpt_source,place_outgoingArcs,opposite).

		/* reference PN!ArcPT.target : PN!Transition oppositeOf incomingArcs */
		node(arcpt_target,reference).
		prop(arcpt_target,name,"target").
		prop(arcpt_target,isContainer,false).
		prop(arcpt_target,lower,1).
		prop(arcpt_target,upper,1).
		prop(arcpt_target,isOrdered,false).
		prop(arcpt_target,isUnique,false).
		edge(arcpt,arcpt_target,features).
		edge(arcpt_target,arcpt,owner).
		edge(arcpt_target,transition,type).
		edge(arcpt_target,transition_incomingArcs,opposite).

	/* class PN!ArcTP */
	node(arctp,class).
	prop(arctp,name,"ArcTP").
	prop(arctp,isAbstract,false).
	edge(arctp,pnElement,supertypes).

		/* reference PN!ArcTP.source : PN!Transition oppositeOf outgoingArcs */
		node(arctp_source,reference).
		prop(arctp_source,name,"source").
		prop(arctp_source,isContainer,false).
		prop(arctp_source,lower,1).
		prop(arctp_source,upper,1).
		prop(arctp_source,isOrdered,false).
		prop(arctp_source,isUnique,false).
		edge(arctp,arctp_source,features).
		edge(arctp_source,arctp,owner).
		edge(arctp_source,transition,type).
		edge(arctp_source,transition_outgoingArcs,opposite).

		/* reference PN!ArcTP.target : PN!Place oppositeOf incomingArcs */
		node(arctp_target,reference).
		prop(arctp_target,name,"target").
		prop(arctp_target,isContainer,false).
		prop(arctp_target,lower,1).
		prop(arctp_target,upper,1).
		prop(arctp_target,isOrdered,false).
		prop(arctp_target,isUnique,false).
		edge(arctp,arctp_target,features).
		edge(arctp_target,arctp,owner).
		edge(arctp_target,place,type).
		edge(arctp_target,place_incomingArcs,opposite).

/* Model: MyPetriNet */

	/* place P1 */
	node(p1,place).
	prop(p1,pn_name,"P1").
	edge(p1,a1,place_outgoingArcs).

	/* place P2 */
	node(p2,place).
	prop(p2,pn_name,"P2").
	edge(p2,a2,place_incomingArcs).

	/* transition T1 */
	node(t1,transition).
	prop(t1,pn_name,"T1").
	edge(t1,a1,transition_incomingArcs).
	edge(t1,a2,transition_outgoingArcs).

	/* arcpt a1 */
	node(a1,arcpt).
	prop(a1,pn_name,"A1").
	edge(a1,p1,arcpt_source).
	edge(a1,t1,arcpt_target).

	/* arctp a2 */
	node(a2,arctp).
	prop(a2,pn_name,"A2").
	edge(a2,t1,arctp_source).
	edge(a2,p2,arctp_target).
