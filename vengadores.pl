personaje(thanos,60).
personaje(hulk,5).
personaje(ironman,100).
personaje(thor,40).
personaje(spiderman,1).
personaje(locki,8).

heroe(ironman).
heroe(spiderman).
heroe(thor).
heroe(hulk).

%poder(ironman, inteligencia).
poder(ironman, rayos).
poder(ironman, vision).

poder(thor, rayos).
poder(thor, inteligencia).
poder(thor, vision).
poder(thor, guantelete).

poder(thanos, guantelete).
poder(thanos, inteligencia).

poder(locki, vision).

poder(spiderman,vision).

esFuerte(Personaje):-
    personaje(Personaje,Fuerza),
    Fuerza > 50.

leGana(Personaje,Otro):-
    personaje(Personaje,Fuerza1),
    personaje(Otro,Fuerza2),
    Fuerza1>Fuerza2.

leGanaPorMucho(Personaje,Otro):-
    personaje(Personaje,Fuerza1),
    personaje(Otro,Fuerza2),
    Fuerza1>Fuerza2*10.

leGanaPor(Personaje,Otro,PorCuanto):-
    personaje(Personaje,Fuerza1),
    personaje(Otro,Fuerza2),
    PorCuanto is Fuerza1/Fuerza2,
    PorCuanto>1.
    
leGanaAlMenosPor(Personaje,Otro,PorCuanto):-
    personaje(Personaje,Fuerza1),
    personaje(Otro,Fuerza2),
    PorCuanto < Fuerza1/Fuerza2,
    PorCuanto>1. 



villano(Alguien):-
    personaje(Alguien,_),
    not(heroe(Alguien)).


esPoderoso(Personaje):- 
    personaje(Personaje,_),
    poder(Personaje,Poder),
    poder(Personaje,Otro),
    Otro \= Poder.

coincidePoder(P1,P2):-
    poder(P1,Poder),
    poder(P2,Poder),
    P1 \= P2.

/*
coincideCompletoPoder(P1,P2):-
    forall(poder(P1,Poder),
           (poder(P2,Poder),P2\=P1) ).

*/
noEsTanOriginalConSusPoderes(P1):-
     forall(poder(P1,Poder),
          (poder(P2,Poder),P2\=P1) ).

/*
coincideCompletoPoder(P1,P2):-
    personaje(P2,_),
    personaje(P1,_),
    P2\=P1,
    forall(poder(P1,Poder),
          poder(P2,Poder) ).
*/

coincideCompletoPoder(P1,P2):-
    personaje(P2,_),
    personaje(P1,_),
    P2\=P1,
    not( hayUnPoderQueTiene(P1, P2) ).



hayUnPoderQueTiene(P1, P2):-
    poder(P1,Poder),
    not(poder(P2,Poder)).


campeon(Campeon):-
    personaje(Campeon,_),
    forall((personaje(Otro,_),Otro\=Campeon), 
           leGana(Campeon, Otro)).

campeon2(Campeon):-
    personaje(Campeon,_),
    not(leGana(_,Campeon)).


ganaVillanoVision(Personaje):-
    personaje(Personaje,_),
    forall((villano(Otro),leGana(Personaje, Otro)),
        (poder(Otro,vision))).

queHace(Personaje):-
    personaje(_,_),
    forall(poder(Personaje,Poder), 
          (leGana(Personaje,Otro),poder(Otro,Poder))).
    