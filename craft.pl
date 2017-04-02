/*********************CRAFT***********************/

/* CRAFT A 4 MATERIAUX */
/* CRAFT RAPIDE */

% Hache
% Pioche
% Casque
% Plastron
% Pantalon
% Bottes
% Epee
% Arc
% Fleche
% Defaut

/* ENCHANTER */


/* CRAFT A 4 MATERIAUX */
% Rien
crafter(rien, rien, rien, rien) :-
    ecrire_gras_couleur('Cela ne donne rien.', blue), nl, !.
% Hache
crafter(Materiau, Materiau, rien, bois) :-
    crafter(Materiau, Materiau, bois, rien), nl, !.
crafter(Materiau, Materiau, bois, rien) :-
    minerai(Materiau),
    verification(Materiau, 2, montrer_erreur),
    verification(bois, 1, montrer_erreur),
    equivalent(Hache, hache, Materiau),
    ajouter(Hache, 1, 1),
    retirer(Materiau, 2),
    retirer(bois, 1),
    conseil(Hache), !.
% Pioche
crafter(Materiau, bois, Materiau, rien) :-
    crafter(bois, Materiau, rien, Materiau), nl, !.
crafter(bois, Materiau, rien, Materiau) :-
    minerai(Materiau),
    verification(Materiau, 2, montrer_erreur),
    verification(bois, 1, montrer_erreur),
    equivalent(Pioche, pioche, Materiau),
    ajouter(Pioche, 1, 1),
    retirer(Materiau, 2),
    retirer(bois, 1),
    conseil(Pioche), !.
% Casque
crafter(rien, rien, Materiau, Materiau) :-
    crafter(Materiau, Materiau, rien, rien), nl, !.
crafter(Materiau, Materiau, rien, rien) :-
    ressource_vetement(Materiau),
    verification(Materiau, 2, montrer_erreur),
    equivalent(Casque, casque, Materiau),
    ajouter(Casque, 1, 1),
    retirer(Materiau, 2),
    conseil(Casque), !.
% Plastron
crafter(Materiau, Materiau, Materiau, Materiau) :-
    ressource_vetement(Materiau),
    verification(Materiau, 4, montrer_erreur),
    equivalent(Plastron, plastron, Materiau),
    ajouter(Plastron, 1, 1),
    retirer(Materiau, 4),
    conseil(Plastron), !.
% Pantalon
crafter(liane, liane, Materiau, Materiau) :-
    ressource_vetement(Materiau),
    verification(liane, 2, montrer_erreur),
    verification(Materiau, 2, montrer_erreur),
    equivalent(Pantalon, pantalon, Materiau),
    ajouter(Pantalon, 1, 1),
    retirer(liane, 2),
    retirer(Materiau, 2),
    conseil(Pantalon), !.
% Bottes
crafter(rien, liane, Materiau, Materiau) :-
    crafter(liane, rien, Materiau, Materiau), nl, !.
crafter(liane, rien, Materiau, Materiau) :-
    ressource_vetement(Materiau),
    verification(liane, 1, montrer_erreur),
    verification(Materiau, 2, montrer_erreur),
    equivalent(Bottes, bottes, Materiau),
    ajouter(Bottes, 1, 1),
    retirer(liane, 1),
    retirer(Materiau, 2),
    conseil(Bottes), !.
% Epee
crafter(rien, Materiau, rien, Materiau) :-
    crafter(Materiau, rien, Materiau, rien), nl, !.
crafter(Materiau, rien, Materiau, rien) :-
    minerai(Materiau),
    verification(Materiau, 2, montrer_erreur),
    equivalent(Epee, epee, Materiau),
    ajouter(Epee, 1, 1),
    retirer(Materiau, 2),
    conseil(Epee), !.
% Arc
crafter(bois, liane, liane, rien) :-
    crafter(liane, rien, bois, liane), nl, !.
crafter(liane, rien, bois, liane) :-
    verification(liane, 2, montrer_erreur),
    verification(bois, 1, montrer_erreur),
    ajouter(arc, 1, 1),
    assert(connait(arc)),
    retirer(liane, 2),
    retirer(bois, 1),
    ecrire_gras_couleur('Vous avez crafte un ', green), ecrire_gras_couleur('arc', blue), ecrire_gras_couleur(', pas la peine d''en creer un autre !', green), nl, !.
% Fleche
crafter(Materiau, bois, rien, liane) :-
    crafter(bois, Materiau, liane, rien), nl, !.
crafter(bois, Materiau, liane, rien) :-
    minerai(Materiau),
    verification(bois, 1, montrer_derreur),
    verification(Materiau, 1, montrer_erreur),
    verification(liane, 1, montrer_erreur),
    equivalent(Fleche, fleche, Materiau),
    ajouter(Fleche, 1, 1),
    retirer(bois, 1),
    retirer(Materiau, 1),
    retirer(liane, 1),
    conseil(Fleche), !.
% Defaut
crafter(_, _, _, _) :-
    ecrire_gras_couleur('Cela ne donne rien.', blue), nl, !.


/* RAPIDE */
% Hache
crafter(hache, Minerai) :-
    joueur_est(atelier),
    connait(hache),
    crafter(Minerai, Minerai, bois, rien), !.
% Pioche
crafter(pioche, Minerai) :-
    joueur_est(atelier),
    connait(pioche),
    crafter(bois, Minerai, rien, Minerai), !.
% Casque
crafter(casque, Ressource) :-
    joueur_est(atelier),
    connait(casque),
    crafter(Ressource, Ressource, rien, rien), !.
% Plastron
crafter(plastron, Ressource) :-
    joueur_est(atelier),
    connait(plastron),
    crafter(Ressource, Ressource, Ressource, Ressource), !.
% Pantalon
crafter(pantalon, Ressource) :-
    joueur_est(atelier),
    connait(pantalon),
    crafter(liane, liane, Ressource, Ressource), !.
% Bottes
crafter(bottes, Ressource) :-
    joueur_est(atelier),
    connait(bottes),
    crafter(liane, rien, Ressource, Ressource), !.
% Epee
crafter(epee, Minerai) :-
    joueur_est(atelier),
    connait(epee),
    crafter(Minerai, rien, Minerai, rien), !.
% Fleche
crafter(fleche, Minerai) :-
    joueur_est(atelier),
    connait(fleche),
    crafter(bois, Minerai, liane, rien), !.
% Defaut
crafter(_, _) :-
    ecrire_gras_couleur('Cela ne donne rien',blue),
    !, nl.
% Arc
crafter(arc) :-
    joueur_est(atelier),
    connait(arc),
    crafter(liane, rien, bois, liane), !.
% Defaut
crafter(_) :-
    ecrire_gras_couleur('Cela ne donne rien',blue),
    !, nl.

% Conseil
%   si deja connu
conseil(Objet) :-
    equivalent(Objet, Artefact, _),
    connait(Artefact),
    ecrire_gras_couleur('Vous avez crafte : ', green), nom_objet(Objet), ecrire_gras_couleur('!', green), nl, !.
%   si inconnu
conseil(Objet) :-
    equivalent(Objet, Artefact, _),
    assert(connait(Artefact)),
    ecrire_gras_couleur('Vous avez crafte : ', green), nom_objet(Objet), ecrire_gras_couleur('!', green), nl,
    nl,
    ecrire_gras_couleur('Vous avez acces au raccourci crafter(', green), ecrire_gras_couleur(Artefact, blue), ecrire_gras_couleur(', ', green), ecrire_gras_couleur('Minerai', blue), ecrire_gras_couleur(').', green), nl, 
    ecrire_gras_couleur('Remplacez Minerai par pierre, cuivre ou diamant suivant le craft.', green), nl, !.

/* ENCHANTER */
enchanter(epee_du_hero) :-
    sac(epee_du_hero, 1),
    sac(parchemin, N),
    N > 0,
    assert(sac(epee_enchantee, 1)),
    retract(sac(epee_du_hero,_)),
    write('Alors que vous marmonez les mots inscrit sur un parchemin, une flamme bleue jaillit de l''epee du heros.'), nl,
    nl,
    ecrire_gras_couleur('Vous avez obtenu l''', green), ecrire_gras_couleur('epee enchantee', blue), ecrire_gras_couleur(' !', green), nl,
    nl,
    write('Sur sa lame est ecrit : '), nl,
    ecrire_gras_couleur('LE CAUCHEMAR DES DRAGONS', red), nl, !.
enchanter(_) :-
    ecrire_gras_couleur('Rien ne se passe.', blue), nl, !.