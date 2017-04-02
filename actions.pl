/*********************ACTIONS***********************/

/* REGARDER */
/* FOUILLER */
/* DONNER */
/* SE DEPLACER */
/* SE PENCHER */
/* EQUIPER */
/* PERFORMANCES ACTIONS */
/* MINER */
/* RECOLTER */
/* GESTION OBJET ajouter, retirer, verifier presence, ramasser, vendre, manger */
/* CONSTRUIRE */
/* ATTAQUER */
/* AFFICHER STATS */


/* REGARDER */
regarder :-
    joueur_est(Endroit),
    decrire(Endroit), nl,
    astuces(Endroit), nl,
    possibilites_chemins(Endroit), nl,
    lister_objets(Endroit),
    nl, !.


/* FOUILLER */
fouiller :-
    joueur_est(creux),
    sac(cle, _),
    il_y_a(epee_du_hero, creux),
    retract(il_y_a(epee_du_hero, creux)),
    resultat_fouille(creux), !.
fouiller :-
    a_vu(entree_donjon),
    joueur_est(Ici),
    il_y_a(parchemin, Ici),
    retract(il_y_a(parchemin, Ici)),
    resultat_fouille(Ici),
    ajouter(parchemin, 1, _),
    ecrire_gras_couleur('Le ', green), ecrire_gras_couleur('parchemin', blue), ecrire_gras_couleur(' a ete ajoute a votre inventaire.', green), nl,
    nl,
    write('Vous : Ce doit etre un des parchemin que recherche le mage Uscule !.'), nl,
    reste_parchemin, nl, !.
fouiller :-
    joueur_est(Ici),
    il_y_a(parchemin, Ici),
    retract(il_y_a(parchemin, Ici)),
    resultat_fouille(Ici),
    ajouter(parchemin, 1, _),
    ecrire_gras_couleur('Le ', green), ecrire_gras_couleur('parchemin', blue), ecrire_gras_couleur(' a ete ajoute a votre inventaire.', green), nl,
    nl,
    write('Vous : Je fererai mieux de garder ce parchemin ...'), nl, !.
fouiller :-
    write('Vous ne trouvez rien.'), !.


resultat_fouille(tronc) :-
    write('Vous tirez le morceau de papier et faites sortir un vieux parchemin encore scelle.'), nl, !.
resultat_fouille(grotte) :-
    write('Vous soulevez le dessus du coffre poussiereux et trouvez un parchemin.'), nl, !.
resultat_fouille(creux) :-
    write('Vous tournez la cle dans la serrure du coffre et une foit ouvert, vous decouvrez une epee.'), nl,
    nl,    
    assert(sac(epee_du_hero, 1)),
    nl,
    ecrire_gras_couleur('Vous avez obtenu l''', green), ecrire_gras_couleur('epee du hero', blue), ecrire_gras_couleur(' !', green), nl,
    nl,
    write('Sur sa lame est ecrit : '), nl,
    ecrire_gras_couleur('INUTILE SANS MAGIE', red), nl, !.

reste_parchemin :-
    sac(parchemin, N),
    N < 2, write('Il n''en reste plus que '), X is 3-N, write(X), write(' !'), !.
reste_parchemin :-
    sac(parchemin, 2),
    write('C''est bon je les ai tous, retournons vite voir le mage !'), !.


/* DONNER */
donner(parchemins) :-
    joueur_est(entree_donjon),
    sac(parchemin, 2),
    write('Vous : Mage Uscule ! Voici les deux parchemins ! Pas faciles a trouver, mais c''est fait !'), nl,
    write('Mage : Tres bien voyageur, tu as prouve ta valeur, l''entree du donjon t''est ouverte !'), nl,
    assert(sac(cle_donjon, 1)),
    write('Mage : Sache aussi que tu peux enchanter des objets via enchanter(Objet) !'), nl, !.
donner(_) :-
    write('Action impossible.'), !.


/* SE DEPLACER */
% Directions
n :- aller(n).
s :- aller(s).
e :- aller(e).
o :- aller(o).
u :- aller(u).
d :- aller(d).

% Aller
%   Direction
aller(Direction) :-
    joueur_est(Ici),
    chemin(Ici, Direction, Labas),
    retract(joueur_est(_)),
    assert(joueur_est(Labas)),
    write('================================================================'), nl,
    regarder, !.
%   Endroit
aller(Endroit) :-
    a_vu(Endroit),
    retract(joueur_est(_)),
    assert(joueur_est(Endroit)),
    write('================================================================'), nl,
    regarder, !.
%   Erreur
aller(_) :-
    vivant(joueur),
    write('================================================================'), nl,
    write('Vous : Quelque chose bloque mon passage'),nl,
    write('Fichtre je ne peux donc pas passer, il va falloir aller ailleurs').


/* SE PENCHER */
sepencher :-
    joueur_est(ravin),
    write('Vous essayez de vous pencher et la pierre en dessous de vous se derobe... Vous mourrez dans d''atroces souffrances !'), nl,
    !, mourir.
sepencher :-
    write('Rien ne se passe.'), nl, !.


/* EQUIPER */
% Equiper meilleurs objets
sequiper :-
    equiper(arme), nl,
    equiper(casque), nl,
    equiper(plastron), nl,
    equiper(pantalon), nl,
    equiper(bottes), !.
% Equiper meilleure armure
equiper(Artefact) :-
    Artefact \= arme,
    equivalent(NO, Artefact, MatiereNO),
    equipement(Artefact, AO),
    NO \= AO,
    verification(NO, 1, pas_derreur),
    % a partir de ce point, cela veut dire qu''on a un objet de type Artefact dans notre inventaire, different de celui equipe
    objet(Artefact, MatiereNO, ANO, DNO, _, _),
    TotalNO is ANO + DNO,    
    equivalent(AO, ArtefactAO, MatiereAO),
    objet(ArtefactAO, MatiereAO, AAO, DAO, _, _),
    TotalAO is AAO + DAO,    
    TotalNO > TotalAO,
    % meilleur Artefact trouve
    ajouter(AO, 1, 1),
    % ajouter l''objet dans l''inventaire est possible au niveau du poids
    retirer(NO, 1),
    retract(equipement(Artefact, AO)),
    assert(equipement(Artefact, NO)),
    % update de l'equipement,
    update_equipement, fail.
% Equiper meilleure arme
equiper(arme) :-
    equivalent(NO, ArtefactNO, MatiereNO),
    arme(ArtefactNO),
    verification(NO, 1, pas_derreur),
    equipement(arme, AO),
    NO \= AO,    
    % a partir de ce point, cela veut dire qu''on a une arme dans notre inventaire, different de celui equipe
    objet(ArtefactNO, MatiereNO, ANO, DNO, _, _),
    TotalNO is ANO + DNO,    
    equivalent(AO, ArtefactAO, MatiereAO),
    objet(ArtefactAO, MatiereAO, AAO, DAO, _, _),
    TotalAO is AAO + DAO,  
    TotalNO > TotalAO,
    % meilleur arme trouvee 
    ajouter(AO, 1, 1),
    % ajouter l''objet dans l''inventaire est possible au niveau du poids
    retirer(NO, 1),
    retract(equipement(arme, AO)),
    assert(equipement(arme, NO)),
    % update de l'equipement,
    update_equipement, fail.
% Equiper meilleur outil quand autre chose en main
equiper(Outil) :-
    Outil \= arme,
    outil(Outil),
    equivalent(NO, Outil, _),
    equipement(arme, AO),
    equivalent(AO, ArtefactAO, _),
    ArtefactAO \= Outil,
    verification(NO, 1, pas_derreur),
    % a partir de ce point, cela veut dire qu''on a un Outil dans notre inventaire, et pas de type Outil en main    
    ajouter(AO, 1, 1),
    % ajouter l''objet dans l''inventaire est possible au niveau du poids
    retirer(NO, 1),
    retract(equipement(arme, AO)),
    assert(equipement(arme, NO)),
    % update de l'equipement,
    update_equipement, fail.
% Equiper meilleur Outil quand Outil en main
equiper(Outil) :-
    Outil \= arme,
    outil(Outil),
    equivalent(NO, Outil, MatiereNO),
    equipement(arme, AO),
    equivalent(AO, Outil, MatiereAO),
    NO \= AO,
    verification(NO, 1, pas_derreur),
    % a partir de ce point, cela veut dire qu''on a un Outil dans notre inventaire, different de celui equipe
    objet(Outil, MatiereNO, ANO, _, _, _), 
    objet(Outil, MatiereAO, AAO, _, _, _),
    % son attaque est meilleur (cela veut dire que son rendement est forcement meilleur)
    ANO > AAO,
    ajouter(AO, 1, 1),
    % ajouter l''objet dans l''inventaire est possible au niveau du poids
    retirer(NO, 1),
    retract(equipement(arme, AO)),
    assert(equipement(arme, NO)),
    % update de l'equipement,
    update_equipement, fail.

% Quand objet equipe
equiper(Artefact) :-
    write('Vous avez equipe le/la/les meilleur(e)(s) '), write(Artefact), write(' : '),
    ((equipement(Artefact, Objet), nom_objet(Objet)) ; (equipement(arme, Objet2), nom_objet(Objet2))),
    !.

/* PERFORMANCES ACTIONS */
% Miner
%   pierre
performance(base,    pierre,  1).
performance(pierre,  pierre,  2).
performance(cuivre,  pierre,  5).
performance(diamant, pierre, 10).
%   cuivre
performance(pierre,  cuivre,  1).
performance(cuivre,  cuivre,  2).
performance(diamant, cuivre,  5).
%   diamant
performance(cuivre,  diamant, 1).
performance(diamant, diamant, 5).
% recolter
%   bois
performance(base,    bois,  1).
performance(pierre,  bois,  2).
performance(cuivre,  bois,  5).
performance(diamant, bois, 10).
%   liane
performance(base,    liane,  1).
performance(pierre,  liane,  2).
performance(cuivre,  liane,  5).
performance(diamant, liane, 10).


/* MINER */
miner(Materiau) :-
    minerai(Materiau),
    joueur_est(mine),
    equipement(arme, Pioche),
    equivalent(Pioche, pioche, Matiere),
    performance(Matiere, Materiau, NB),
    ajouter(Materiau, NB, NombrePossible),
    ecrire_gras_couleur('Vous avez mine ', green), ecrire_gras_couleur(NombrePossible, green), write(' '), ecrire_gras_couleur(Materiau, green), ecrire_gras_couleur('(s).', green), nl,
    !, nl.
miner(_) :-
    ecrire_gras_couleur('Action impossible !', blue), nl,
    ecrire_gras_couleur('Soit vous minez quelque chose d''autre qu''un minerai, soit votre pioche n''est pas assez puissante pour celui-ci !', blue), nl,
    ecrire_gras_couleur('Ou bien vous n''avez pas de pioche en main, ou bien vous n''etes tout simplement pas a la mine !', blue),
    !, nl.


/* RECOLTER */
recolter(Ressource) :-
    ressource(Ressource),
    joueur_est(foret),
    equipement(arme, Hache),
    equivalent(Hache, hache, Matiere),
    performance(Matiere, Ressource, NB),
    ajouter(Ressource, NB, NombrePossible),
    ecrire_gras_couleur('Vous avez recolte ', green), ecrire_gras_couleur(NombrePossible, green), write(' '), ecrire_gras_couleur(Ressource, green), ecrire_gras_couleur('(s).', green), nl,
    !, nl.
recolter(_) :-
    ecrire_gras_couleur('Action impossible !', blue), nl,
    ecrire_gras_couleur('Soit vous recoltez quelque chose d''autre que du bois ou des lianes, soit vous n''avez pas de hache en main !', blue), nl,
    ecrire_gras_couleur('Ou bien vous n''etes tout simplement pas en foret !', blue),
    !, nl.


/* GESTION OBJET */
% Ajouter
%   Or
ajouter(or, Gain) :-
    sac(or, NBO),
    NNBO is NBO + Gain,
    retract(sac(or, NBO)),
    assert(sac(or, NNBO)),
    !.
%   Objet quand il existe deja dans le sac et que le nombre ne fait pas depasser le poids max, ajout possible quand meme de quelques objets
ajouter(Objet, Nombre, NombrePossible) :-
    Objet \= rien,
    sac(Objet, NBO),
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids_max(PoidsMax),
    poids(PoidsActuel),
    NPoids is PoidsActuel + (Nombre * Poids),
    NPoids > PoidsMax,
    NombrePossible is (PoidsMax - PoidsActuel)//Poids,
    NombrePossible > 0,
    ecrire_gras_couleur('Vous ne pouvez pas stocker tous ces objets le poids serait trop grand ! ', red), nl, 
    NNBO is NBO + NombrePossible,
    NPoidsFinal is PoidsActuel + (NombrePossible * Poids),
    retract(poids(_)),
    assert(poids(NPoidsFinal)),
    retract(sac(Objet, _)),
    assert(sac(Objet, NNBO)),
    !.
%   Objet quand il existe deja dans le sac et que le nombre fait depasser le poids max, ajout impossible
ajouter(Objet, Nombre, NombrePossible) :-
    Objet \= rien,
    sac(Objet, _),
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids_max(PoidsMax),
    poids(PoidsActuel),
    NPoids is PoidsActuel + (Nombre * Poids),
    NPoids > PoidsMax,
    NombrePossible is (PoidsMax - PoidsActuel)//Poids,
    NombrePossible =< 0,    
    ecrire_gras_couleur('Ajouter/De-sequiper l''objet ', red), nom_objet(Objet), ecrire_gras_couleur(' serait un poid trop lourd, allez d''abord vendre des objets !', red), nl, !.
%   Objet quand il existe deja dans le sac et que le nombre ne fait pas depasser le poids max, ajout possible
ajouter(Objet, Nombre, NombrePossible) :-
    Objet \= rien,
    sac(Objet, NBO),
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids_max(PoidsMax),
    poids(PoidsActuel),
    NPoids is PoidsActuel + (Nombre * Poids),
    NPoids =< PoidsMax,
    NombrePossible is Nombre,
    NNBO is NBO + NombrePossible,
    NPoidsFinal is PoidsActuel + (NombrePossible * Poids),
    retract(poids(_)),
    assert(poids(NPoidsFinal)),
    retract(sac(Objet, _)),
    assert(sac(Objet, NNBO)),
    !.
%   Objet quand il n'existe pas encore dans le sac et que le nombre ne fait pas depasser le poids max, ajout possible quand meme de quelques objets
ajouter(Objet, Nombre, NombrePossible) :-
    Objet \= rien,
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids_max(PoidsMax),
    poids(PoidsActuel),
    NPoids is PoidsActuel + (Nombre * Poids),
    NPoids > PoidsMax,
    NombrePossible is (PoidsMax - PoidsActuel)//Poids,
    NombrePossible > 0,
    ecrire_gras_couleur('Vous ne pouvez pas stocker tous ces objets le poids serait trop grand ! ', red), nl,
    NPoidsFinal is PoidsActuel + (NombrePossible * Poids),
    retract(poids(_)),
    assert(poids(NPoidsFinal)),
    assert(sac(Objet, NombrePossible)),
    !.
%   Objet quand il n'existe pas encore dans le sac et que le nombre fait pas depasser le poids max, ajout impossible
ajouter(Objet, Nombre, NombrePossible) :-
    Objet \= rien,
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids_max(PoidsMax),
    poids(PoidsActuel),
    NPoids is PoidsActuel + (Nombre * Poids),
    NPoids > PoidsMax,
    NombrePossible is (PoidsMax - PoidsActuel)//Poids,
    NombrePossible =< 0,    
    ecrire_gras_couleur('Ajouter/De-sequiper l''objet ', red), nom_objet(Objet), ecrire_gras_couleur(' serait un poid trop lourd, allez d''abord vendre des objets !', red), nl, !.
%   Objet quand il n'existe pas encore dans le sac et que le nombre ne fait pas depasser le poids max, ajout possible
ajouter(Objet, Nombre, NombrePossible) :-
    Objet \= rien,
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids_max(PoidsMax),
    poids(PoidsActuel),
    NPoids is PoidsActuel + (Nombre * Poids),
    NPoids =< PoidsMax,
    NombrePossible is Nombre,
    NNBO is NombrePossible,
    NPoidsFinal is PoidsActuel + (NombrePossible * Poids),
    retract(poids(_)),
    assert(poids(NPoidsFinal)),
    assert(sac(Objet, NNBO)),
    !.
ajouter(rien, _, _) :- !.
% Retirer or
retirer(or, Nombre) :-
    sac(or, NBO),
    NNBO is NBO - Nombre,
    NNBO >= 0,
    % Il y a assez d'or dans le sac
    retract(sac(or, NBO)),    
    assert(sac(or, NNBO)),
    !.
% Retirer objet
retirer(Objet, Nombre) :-
    Objet \= rien,
    sac(Objet, NBO),
    NNBO is NBO - Nombre,
    NNBO >= 0,
    % Il y a assez d'objets dans le sac
    retract(sac(Objet, NBO)),    
    assert(sac(Objet, NNBO)),
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, Poids, _),
    poids(PoidsActuel),
    NouveauPoids is PoidsActuel - (Poids * Nombre),
    retract(poids(_)),
    assert(poids(NouveauPoids)),
    !.
retirer(rien, _) :- !.
% Verifier presence suffisante objet dans sac, avant de retirer !!! verification(Objet, Nombre, AfficherErreur)
%   si rien
verification(rien, _, _) :- !.
%   si objet present en nombre suffisant
verification(Objet, Nombre, _) :-
    sac(Objet, NBO),
    NBO >= Nombre,
    !.
%   sinon pas assez d''objet et on veut connaitre erreur
verification(Objet, Nombre, montrer_erreur) :-
    erreur(Objet, Nombre), !, fail.
%   erreur type pas assez mais present
erreur(Objet, Nombre) :-
    sac(Objet, NBO),
    NBO < Nombre,
    ecrire_gras_couleur('Vous n''avez pas assez de : ', red), nom_objet(Objet), nl, !.
erreur(Objet, _) :-
    ecrire_gras_couleur('Vous n''avez pas de : ', red), nom_objet(Objet), nl, !.
% tout ramasser
ramasser(tout) :-
    joueur_est(Ici),
    il_y_a(Objet, Ici),
    ramasser(Objet), fail.
% ramasser bateau
ramasser(bateau):-
    joueur_est(riviere),
    il_y_a(bateau, riviere),
    write('Vous etes serieux ? ...'), nl, !.
ramasser(pierre):-
    joueur_est(carrefour),
    write('Un cobra surgit, vous sentez son venin penetrer votre corps'), nl,
    write('Vous vous effondrez et mourrez'), nl,
    mourir, !.
% cle deja decouverte
ramasser(cailloux):-
    joueur_est(carrefour),
    il_y_a(cle, carrefour),
    write('Il y a toujours la cle magique.'),nl,
    ecrire_gras_couleur('Astuce : Prendre la cle => ramasser(cle).', blue),
    nl, !.
% cle non decouverte
ramasser(cailloux):-
    joueur_est(carrefour),
    assert(il_y_a(cle, carrefour)),
    write('Sous la pierre se trouve une cle magique.'),nl,
    write('Vous : Elle pourrait m''etre utile pour ma quete'), nl,
    ecrire_gras_couleur('Astuce : Prendre la cle => ramasser(cle).', blue),
    nl, !.
ramasser(cle):-
    joueur_est(carrefour),
    retract(il_y_a(cle, carrefour)),
    assert(sac(cle, 1)),   
    ecrire_gras_couleur('Vous ramassez ', green), ecrire_gras_couleur('cle', blue), ecrire_gras_couleur('.', green), nl, !.
ramasser(Objet) :-
    joueur_est(Ici),
    il_y_a(Objet, Ici),
    Objet \= bateau,
    retract(il_y_a(Objet, Ici)),
    ajouter(Objet, 1, 1),
    ecrire_gras_couleur('Vous ramassez ', green), nom_objet(Objet), ecrire_gras_couleur('.', green), nl, !.
ramasser(_) :-
    joueur_est(Ici),
    il_y_a(_, Ici),
    ecrire_gras_couleur('Je ne vois rien de ce genre ici.', red),
    nl, !.
ramasser(_) :-
    ecrire_gras_couleur('Il n''y a plus rien ici.', red),
    nl, !.

% Vendre
%   Objet
vendre(Objet, Quantitee) :-
    joueur_est(carrefour),
    verification(Objet, Quantitee, montrer_erreur),
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, _, Prix),
    Prix \= 0,
    retirer(Objet, Quantitee),
    Gain is Quantitee * Prix,
    ajouter(or, Gain),
    ecrire_gras_couleur('Vous avez vendu ', green), ecrire_gras_couleur(Quantitee, blue), write(' '), nom_objet(Objet), ecrire_gras_couleur('(s)', blue),
    ecrire_gras_couleur(' pour ', green), ecrire_gras_couleur(Gain, blue), ecrire_gras_couleur(' pieces d''or', blue), ecrire_gras_couleur('.', green),
    !.
vendre(_, _) :-
    ecrire_gras_couleur('Action impossible !', red), nl,
    (joueur_est(carrefour), nl ; ecrire_gras_couleur('Vous n''etes pas au carrefour.', red), nl),
    !.
% Manger
manger(champignon) :-        
        joueur_est(grand_arbre),
        write('Vous mangez le champignon. Vous vous sentez alors revigore'), nl,
        write('Votre coeur se met alors a battre de plus en plus vite.'),nl,
        write('Vous appelez alors a l''aide mais dans la foret, personne ne vous entend crier.'), nl,
        write('Vous vous effondrez sur le sol, empoisonne.'), nl,
        mourir, !.

manger(pierre) :-        
        joueur_est(carrefour),
        write('Vous mangez la pierre et mourrez etouffe.'), nl,
        write('Drole d''idee que de vouloir manger une pierre...'), nl,
        !, mourir.

manger(cailloux) :-        
        joueur_est(carrefour),
        write('Vous mangez la pierre et mourrez etouffe.'), nl,
        write('Drole d''idee que de vouloir manger une pierre...'), nl,
        !, mourir.

manger(Objet) :-
        sac(Objet, NB),
        NB > 0,
        write('Drole d''idee que de vouloir manger ca... arretez votrez folie !'), nl, !.


/* CONSTRUIRE */
construire(bateau) :-
    joueur_est(riviere),
    il_y_a(bateau, riviere),    
    ecrire_gras_couleur('Il y a deja un bateau ici, pas la peine d''en reconstruire un !', red), nl, !.
construire(bateau) :-
    joueur_est(riviere),
    equipement(arme, Objet),
    equivalent(Objet, marteau, _),
    verification(bois,  100, montrer_erreur),
    verification(cuivre, 20, montrer_erreur),
    verification(cuir,   20, montrer_erreur),
    verification(or,   2000, montrer_erreur),
    assert(il_y_a(bateau, riviere)),
    retirer(bois,  100),
    retirer(cuivre, 20),
    retirer(cuir,   20),
    retirer(or,   2000),
    ecrire_gras_couleur('Vous avez construit un bateau !', blue), nl,
    !.
construire(bateau) :-
    (joueur_est(riviere) ; ecrire_gras_couleur('Vous n''etes pas a la riviere !', red), nl),
    ecrire_gras_couleur('Il vous faut 100 bois, 20 cuivres, 20 cuirs, et 2000 or pour une telle construction.', red), nl,
    !.


/* ATTAQUER */ 
% PNJ
attaquer(mage) :-
        joueur_est(entree_donjon),
        write('Vous : Laisse moi passer ou meurs par ma lame, sorcier !'), nl,
        write('Mage Uscul : Fus Roh dah !!'), nl,
        write('*Vous etes projete sur un arbre, votre colonne vertebrale se brise et vous vous empallez sur une branche*'), nl,
        write('Vous : Arh...quelle puissance...je...je meurs...'), nl,
        !, mourir.
attaquer(marchand) :-
        joueur_est(carrefour),
        write('Vous : Meurs marchand !'), nl,
        write('Vous sentez une onde de choc vous repousser. Le mage se transforme alors.'), nl,
        write('Marchand : Ahah tu vas mourir maintenant.'), nl,
        write('Vous prenez alors que le marchand etait en fait un Djinn. Vous etes condamne..'), nl,
        !, mourir.    
% Ennemis
attaquer(Boss):-
    vivant(Boss),
    boss(Boss, _, _),
    joueur_est(Ici),
    il_y_a(Boss, Ici),
    statistiquesCombat(Boss, PtsEnnemi, PtsJoueur),
    PtsJoueur >= PtsEnnemi,
    ecrire_gras_couleur('Vous decider d''attaquer ', blue), ecrire_gras_couleur(Boss, red), nl,
    ecrire_gras_couleur('Il est vaincu. Gloire au hero !', green), nl,
    retract(vivant(Boss)),
    retract(il_y_a(Boss, _)), !.
attaquer(Boss):-
    vivant(Boss),
    boss(Boss, _, _),
    joueur_est(Ici),
    il_y_a(Boss, Ici),
    statistiquesCombat(Boss, PtsEnnemi, PtsJoueur),
    PtsJoueur < PtsEnnemi,
    ecrire_gras_couleur('Vous decider d''attaquer ', blue), ecrire_gras_couleur(Boss, red), nl,
    ecrire_gras_couleur('Il vous a vaincu. ', red), nl,
    mourir, !.
% Animaux
attaquer(Animal):-
    animal(Animal, _, _, _),
    joueur_est(foret),
    statistiquesChasse(Animal, PtsEnnemi, PtsJoueur),
    PtsJoueur < PtsEnnemi,
    ecrire_gras_couleur('Vous decider d''attaquer ', blue), ecrire_gras_couleur(Animal, red), nl,
    ecrire_gras_couleur('L''animal vous domine et vous tue.', blue), nl,
    mourir,!.
attaquer(Animal):-
    animal(Animal, _, _, NbCuir),
    joueur_est(foret),
    statistiquesChasse(Animal, PtsEnnemi, PtsJoueur),
    PtsJoueur >= PtsEnnemi,
    ecrire_gras_couleur('Vous decider d''attaquer ', blue), ecrire_gras_couleur(Animal, red), nl,
    ecrire_gras_couleur('L''animal meurt face a vos attaques', green), nl,
    ajouter(cuir, NbCuir, NbAjoute),
    (NbAjoute > 0, ecrire_gras_couleur('Vous avez recupere ', green), ecrire_gras_couleur(NbAjoute, blue), ecrire_gras_couleur(' cuir(s)', blue), nl; NbAjoute =< 0), !.
% Autre.
attaquer(_):-
    ecrire_gras_couleur('Vous ne pouvez pas attaquer ca !', red), !.
    

/* AFFICHER STATS */
% Stats joueur
stats :-
    pts_attaque(AJ),
    pts_defense(DJ),
    ecrire_gras_couleur('Mes caracteristiques', green),
    ecrire_gras_couleur(' : Attaque = ', green), ecrire_gras_couleur(AJ, blue),
    ecrire_gras_couleur(' | Defense = ', green), ecrire_gras_couleur(DJ, blue),
    nl, !.
% Stats entite
stats(Animal) :-
    animal(Animal, A, D, _), !,
    ecrire_gras_couleur(Animal, green),
    ecrire_gras_couleur(' : Attaque = ', green), ecrire_gras_couleur(A, blue),
    ecrire_gras_couleur(' | Defense = ', green), ecrire_gras_couleur(D, blue),
    nl, !.
stats(Boss) :-
    boss(Boss, A, D), !,
    ecrire_gras_couleur(Boss, green),
    ecrire_gras_couleur(' : Attaque = ', green), ecrire_gras_couleur(A, blue),
    ecrire_gras_couleur(' | Defense = ', green), ecrire_gras_couleur(D, blue),
    nl, !.
stats(Objet) :-
    equivalent(Objet, Artefact, Matiere), !,
    objet(Artefact, Matiere, A, D, _, _), 
    nom_objet(Objet),
    ecrire_gras_couleur(' : Attaque = ', green), ecrire_gras_couleur(A, blue),
    ecrire_gras_couleur(' | Defense = ', green), ecrire_gras_couleur(D, blue),
    !, nl.
stats(_) :-
    ecrire_gras_couleur('Il n''y a pas de stats disponible pour cela.', blue),
    nl, !.

% Statisitiques attaques
statistiquesChasse(Animal, PtsAnimal, PtsJoueur):-
    animal(Animal, AA, DA,_),
    PtsAnimal is AA + DA,
    pts_attaque(A),
    pts_defense(D),
    PtsJoueur is A + D.
statistiquesCombat(Boss, PtsBoss, PtsJoueur):-
    boss(Boss, AB, DB),
    PtsBoss is AB + DB,
    pts_attaque(A),
    pts_defense(D),
    PtsJoueur is A + D.