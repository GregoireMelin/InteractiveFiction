/************ELEMENTS GENERAUX DU JEU***************/

/* PREDICATS DYNAMIQUES */
/* POINT DEPART JOUEUR */
/* GESTION EQUIPEMENT */
/* DEMARRAGE DU JEU */
/* TUTORIEL */


/* PREDICATS DYNAMIQUES */
:- dynamic joueur_est/1, il_y_a/2, sac/2, equipement/2, joueur/5, vivant/1, a_vu/1, connait/1, poids/1.
:- dynamic poids_max/1.
:- retractall(joueur_est(_)), retractall(a_vu(_)), retractall(il_y_a(_,_)), retractall(sac(_,_)),  retractall(equipement(_,_)), retractall(joueur(_,_,_,_,_)), retractall(vivant(_)), retractall(connait(_)), retractall(poids(_)).
:- retractall(poids_max(_)).
/* AFFICHAGE */
ecrire_gras_couleur(Text, Color) :-
    ansi_format([bold, fg(Color)], Text, []),
    !.
ecrire_couleur(Text, Color) :-
    ansi_format([fg(Color)], Text, []),
    !.
ecrire_gras(Text) :-
    ansi_format([bold], Text, []),
    !.

/* POINT DEPART JOUEUR */
joueur_est(maison).
joueur(rien,rien,rien,rien,rien).
sac(or,0).
poids(0).
poids_max(200).

introduction :-
        write('Vous, chevalier legendaire, vous reveillez avec la pale lueur du soleil traversant la fenetre de votre chambre.'), nl,
        write('Une sensation glacante mais familiere vous envahit alors : Toujours le meme cauchemar.'), nl,
        write('Un monde detruit, ou chaos et monstres ont pris le dessus sur la nature et la paix.'), nl,
        write('Dans votre cauchemar apparait ce qui semble etre un sombre cachot dans lequel une forte lumiere emane d''un coffre vous ebloui.'), nl,
        write('Ce reve, tinte de realite, vous porte a croire que trouver ce coffre reglera vos problemes. Vous vous mettez donc en quete de ce dernier.'), nl,
        write('Preparez vous a rentrer dans Xaaxaroth!'), nl,
        nl.


/* DEMARRAGE DU JEU */
demarrer :-
        init, nl,
        mode_emploi, nl,
        introduction, nl,
        regarder.


/* TUTORIEL */
mode_emploi :-
        nl,
        write("_______________________________________TUTORIEL______________________________________"), nl,
        write('Entrez les commandes avec la syntaxe Prolog standard.'), nl,
        write('Les commandes disponibles sont :'), nl,
        write('demarrer.                        -- pour commencer une partie.'), nl,
        write('regarder.                        -- pour regarder de nouveau autour de vous.'), nl,
        write('n. s. e. o. u. d.                -- pour aller dans une direction.'), nl,
        write('aller(Lieu).                     -- pour aller dans un lieu deja decouvert.'), nl,
        write('sequiper.                        -- pour sequiper des meilleurs equipements que vous avez.'), nl,
        write('miner(Minerai ).                 -- pour miner un minerai (pierre, cuivre, diamant).'), nl,
        write('recolter(Ressource).             -- pour recolter une ressource (bois, liane).'), nl,
        write('crafter(HautGauche,HD,BG,BD).    -- pour crafter un objet.'), nl,
        write('crafter(Objet).                  -- pour crafter un objet que vous avez deja crafte.'), nl,
        write('construire(Objet).               -- pour construire un objet specifique.'), nl,
        write('attaquer.                        -- pour attaquer un ennemi.'), nl,
        write('manger(Objet).                   -- pour manger un objet.'), nl,
        write('mode_emploi.                     -- pour afficher le mode d''emploi de nouveau.'), nl,
        write('terminer.                        -- pour terminer la partie.'), nl,
        write('mort.                            -- pour se suicider'), nl,
        write("_____________________________________________________________________________________"), nl,
        nl.


/*****************GAMEPLAY****************************/

/* GESTION EQUIPEMENT */
% Initialisation
init :-
    joueur(Arme,Casque,Plastron,Pantalon,Bottes),
    assert(equipement(arme,Arme)),
    assert(equipement(casque,Casque)),
    assert(equipement(plastron,Plastron)),
    assert(equipement(pantalon,Pantalon)),
    assert(equipement(bottes,Bottes)).

% Update
update_equipement :-
    equipement(arme,Arme),
    equipement(casque,Casque),
    equipement(plastron,Plastron),
    equipement(pantalon,Pantalon),
    equipement(bottes,Bottes),
    !,
    retract(joueur(_,_,_,_,_)),
    assert(joueur(Arme,Casque,Plastron,Pantalon,Bottes)).

inventaire :-
    write('Appuyer sur la touche ";" pour faire defiler l''inventaire'), nl,
    ecrire_gras("___________INVENTAIRE ___________"), nl,
    sac(Item, Quantitee),
    Quantitee > 0,
    write('Item : '), write(Item), nl,
    write('Quantitee : '), write(Quantitee), nl,
    ecrire_gras("_________________________________").
inventaire :-
    nl,
    write('Rien.'), nl,
    ecrire_gras("_________________________________"), !.
i :- inventaire.



/* MORT DU PERSONNAGE */
mourir :-
        ecrire_gras_couleur('               GAME OVER',red), nl,
        retract(vivant(joueur)),
        terminer, !.
terminer :-
        ecrire_gras_couleur('La partie est terminee. Tapez la commande "halt."',red),
        nl, !.


/*CONSULTATION DES AUTRES FICHIERS*/
:- consult('environnement.pl').
:- consult('actions.pl').
:- consult('craft.pl').