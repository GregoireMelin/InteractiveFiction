/*********************ENVIRONNEMENT***********************/

/* PERSONNAGE VIVANTS */
/* CHEMINS */
/* DESCRIPTIONS LIEUX */
/* ITEMS DISPONIBLES DANS L'ENVIRONNEMENT */
/* TYPES D'ITEMS */
/* PRIX */
/* STATS */
/* EQUIVALENCES */
/* NOM OBJET */

/* PERSONNAGE VIVANT */
vivant(joueur).
vivant(orc).
vivant(dragon).

/* CHEMINS */
% Atelier
chemin(atelier, s, mine).
chemin(atelier, e, maison).
% Mine
chemin(mine, n, atelier).
chemin(mine, s, entree_grotte).
chemin(mine, e, carrefour).
% Entree de la grotte
chemin(entree_grotte, n, mine).
chemin(entree_grotte, e, foret).
chemin(entree_grotte, s, grotte) :- vivant(orc), !, write('Cet orc est toujours la je ne peux pas rentrer !'), nl, fail.
chemin(entree_grotte, s, grotte) :- !.
% Interieur de la grotte
chemin(grotte, n, entree_grotte).
% Maison
chemin(maison, s, carrefour).
chemin(maison, e, riviere).
chemin(maison, o, atelier).
% Carrefour
chemin(carrefour, n, maison).
chemin(carrefour, s, foret).
chemin(carrefour, e, cascade).
chemin(carrefour, o, mine).
% Foret
chemin(foret, n, carrefour).
chemin(foret, o, entree_grotte).
% Riviere
chemin(riviere, s, cascade).
chemin(riviere, e, entree_donjon) :- il_y_a(bateau, riviere), !.
chemin(riviere, e, entree_donjon) :- mourir, fail.
chemin(riviere, o, maison).
% Cascade
chemin(cascade, n, riviere).
chemin(cascade, o, carrefour).
chemin(cascade, d, creux).
% Creux dans la cascade
chemin(creux, u, cascade).
% Grand arbre
chemin(grand_arbre, s, entree_donjon).
chemin(grand_arbre, u, tronc).
% Tronc
chemin(tronc, d, grand_arbre).
% Entree du donjon
chemin(entree_donjon, n, grand_arbre).
chemin(entree_donjon, s, ravin).
chemin(entree_donjon, e, donjon) :- sac(cle_donjon, 1), !.
chemin(entree_donjon, e, donjon) :-
        write('L entree du donjon semble scellee par la magie.'), nl,
        fail.
chemin(entree_donjon, o, riviere).
% Ravin
chemin(ravin, n, entree_donjon).


/* DESCRIPTIONS LIEUX */
% Atelier
decrire(atelier) :-
    a_vu(atelier),
    nl,
    ecrire_gras('ATELIER'), nl,
    nl,
    write('Vous etes a l''atelier.'), nl,
    nl, !.
decrire(atelier) :-
    nl,
    ecrire_gras('ATELIER'), nl,
    nl,
    write('Un atelier se dresse devant vous, c''est le votre.'),
    assert(a_vu(atelier)),
    nl,
    write('Vous : Mon atelier ... avant ces cauchemars j''y passais mes journees.'), nl,
    write('Vous : On dirait meme que mes premiers outils sont toujours fonctionnels, cela pourrait m''etre utile.'), nl,
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(atelier)'), nl, !.
% Mine
decrire(mine) :-
    a_vu(mine),
    nl,
    ecrire_gras('MINE'), nl,
    nl,
    write('Vous etes dans la mine.'), nl,
    nl, !.
decrire(mine) :-
    nl,
    ecrire_gras('MINE'), nl,
    nl,
    write('Vous vous dirigez vers la mine. Une lueur etrange eclaire l''endroit. Vous vous engoufrez alors dans le tunnel le plus proche.'), nl,
    write('Vous arrivez face a un gisement.'), nl,
    assert(a_vu(mine)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(mine)'), nl, !.
% Entree de la grotte
decrire(entree_grotte) :-
    a_vu(entree_grotte),
    vivant(orc),
    nl,
    ecrire_gras('ENTREE DE LA GROTTE'), nl,
    nl,
    write('Vous etes a l''entree de la grotte, l''orc est toujours la.'), nl,
    nl, !.
decrire(entree_grotte) :-
    a_vu(entree_grotte),    
    nl,
    ecrire_gras('ENTREE DE LA GROTTE'), nl,
    nl,
    write('Vous etes a l''entree de la grotte.'), nl,
    nl,
    write('Vous : Ce cadavre est infecte. Enfin bref, continuons'), nl,
    write('Vous : L''entree de sa grotte n''est plus gardee, je peux enfin entrer dedans.'), nl,
    nl, !.
decrire(entree_grotte) :-
    nl,
    ecrire_gras('ENTREE DE LA GROTTE'), nl,
    nl,
    write('Vous arrivez face a la grotte. Devant l''entree un orc fume tranquillement de l''herbe a pipe.'), nl,
    write('Outre son odeur, vous remarquez que la bete est bigrement bien arme mais qu''elle est completement ivre'), nl,
    assert(a_vu(entree_grotte)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(entree_grotte)'), nl, !.
% Interieur de la grotte
decrire(grotte) :-
    a_vu(grotte),
    nl,
    ecrire_gras('INTERIEUR DE LA GROTTE'), nl,
    nl,
    write('Vous etes dans la grotte.'), nl,
    nl, !.
decrire(grotte) :-
    nl,
    ecrire_gras('INTERIEUR DE LA GROTTE'), nl,
    nl,
    write('Vous entrez dans l''antre de l''orc. Vous vous trouvez alors face a une piece. Un repas est en train de bouillir, sans doute le dernier voyageur.'), nl,
    write('Rien d''interressant pour vous ne se trouve dans cette grotte hormis un coffre qui degage une aura etrange. Quelle chance, il n''est pas ferme a cle.'), nl,
    assert(a_vu(grotte)),
    nl,    
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(grotte)'), nl, !.
% Maison
decrire(maison) :-
    a_vu(maison),
    nl,
    ecrire_gras('MAISON'), nl,
    nl,
    write('Vous etes devant votre maison.'), nl,
    nl, !.
decrire(maison) :-
    nl,
    ecrire_gras('MAISON'), nl,
    nl,
    write('Vous arrivez chez vous.'), nl,
    write('Vous : Ma bonne vieille maison, mais bon je me reposerai plus tard !'), nl,
    assert(a_vu(maison)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(maison)'), nl, !.
% Carrefour
decrire(carrefour) :-
    a_vu(carrefour),
    nl,
    ecrire_gras('CARREFOUR'), nl,
    nl,
    write('Vous etes au carrefour. Le marchand est tout content de vous voir.'), nl,
    nl, !.
decrire(carrefour) :-
    nl,
    ecrire_gras('CARREFOUR'), nl,
    nl,
    write('Outre le paysage magnifique, rien a signaler. Un panneau avec a son pied deux cailloux indique differentes directions, et un marchand avec sa roulotte'), nl,
    nl,
    write('Marchand : Bonjour voyageur ! Aurais-tu quelque chose a me vendre ?'), nl,
    assert(a_vu(carrefour)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(carrefour)'), nl, !.
% Foret
decrire(foret) :-
    a_vu(foret),
    nl,
    ecrire_gras('FORET'), nl,
    nl,
    write('Vous etes dans la foret.'), nl,
    nl, !.
decrire(foret) :-
    nl,
    ecrire_gras('FORET'), nl,
    nl,
    write('Vous arrivez face a une foret. Devant vous se dresse de robustes chenes.'), nl,
    assert(a_vu(foret)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(foret)'), nl, !.
% Riviere
decrire(riviere) :-
    a_vu(riviere),
    il_y_a(bateau,riviere),
    nl,
    ecrire_gras('RIVIERE'), nl,
    nl,
    write('Vous etes a la riviere.'), nl,
    nl,
    write('Vous : Avec mon bateau, traverser ces berges sera sans dangers !'), nl,
    nl, !.
decrire(riviere) :-
    a_vu(riviere),
    nl,
    ecrire_gras('RIVIERE'), nl,
    nl,
    write('Vous etes a la riviere.'), nl,
    nl, !.
decrire(riviere) :-
    nl,
    ecrire_gras('RIVIERE'), nl,
    nl,
    write('Vous arrivez devant une riviere dont le debit est extrement important.'), nl,
    assert(a_vu(riviere)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(riviere)'), nl, !.
% Cascade
decrire(cascade) :-
    a_vu(cascade),
    nl,
    ecrire_gras('CREUX DE LA CASCADE'), nl,
    nl,
    write('Vous etes devant la cascade.'), nl,
    nl, !.
decrire(cascade) :-
    nl,
    ecrire_gras('CASCADE'), nl,
    nl,
    write('Vous : Une cascade, un coin de verdure, un beau soleil ! Parfait pour une apres midi baignade et sieste !'), nl,
    assert(a_vu(cascade)),
    nl,    
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(cascade)'), nl, !.
% Creux dans la cascade
decrire(creux) :-
    a_vu(creux),
    nl,
    ecrire_gras('CREUX DE LA CASCADE'), nl,
    nl,
    write('Vous etes au creux de la cascade.'), nl,
    nl, !.
decrire(creux) :-
    nl,
    ecrire_gras('CREUX DE LA CASCADE'), nl,
    nl,
    write('Vous : Quelle bonne idee d''etre passe sous la cascade !'), nl,
    assert(a_vu(creux)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(creux)'), nl, !.
% Grand Arbre
decrire(grand_arbre) :-
    a_vu(grand_arbre),
    nl,
    ecrire_gras('GRAND ARBRE'), nl,
    nl,
    write('Vous etes devant le grand arbre.'), nl,
    nl, !.
decrire(grand_arbre) :-
    nl,
    ecrire_gras('GRAND ARBRE'), nl,
    nl,
    write('Vous : Quelle magnificence cet arbre ! Il donne envie d''y installer un hamac en grimpant au tronc.'), nl,        
    assert(a_vu(grand_arbre)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(grand_arbre)'), nl, !.
% Tronc
decrire(tronc) :-
    a_vu(tronc),    
    nl,
    ecrire_gras('TRONC DU GRAND ARBRE'), nl,
    nl,
    write('Vous etes dans le tronc de l''arbre.'), nl,
    nl, !.
decrire(tronc) :-
    nl,
    ecrire_gras('TRONC DU GRAND ARBRE'), nl,
    nl,
    write('Vous : Installer un hamac ici sera peut etre difficile.'), nl,        
    assert(a_vu(tronc)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(tronc)'), nl, !.
% Entree du donjon
decrire(entree_donjon) :-
    a_vu(entree_donjon),
    nl,
    ecrire_gras('ENTREE DU DONJON'), nl,
    nl,
    write('Vous etes a l''entree du donjon, le mage Uscule est toujours la...'), nl,
    nl, !.
decrire(entree_donjon) :-
    nl,
    ecrire_gras('ENTREE DU DONJON'), nl,
    nl,
    write('Mage : Salutations etranger, je suis Mage Uscule, le gardien de ce donjon !"'), nl,
    write('Vous : Salut a toi mage, je souhaiterais entrer la dedans pour finir cette quete pourrie !"'), nl,
    write('Mage Uscule : Pour passer, il va falloir que tu me ramene les 2 parchemins sacres de notre beau pays, ahahah"'), nl,              
    write('Vous : Les PNJ ca ose tout, c''est a ca qu''on les reconnait' ), nl,   
    assert(a_vu(entree_donjon)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(entree_donjon)'), nl, !.
% Ravin
decrire(ravin) :-
    a_vu(ravin),
    nl,
    ecrire_gras('RAVIN'), nl,
    nl,
    write('Vous etes au ravin'), nl,
    nl, !.
decrire(ravin) :-
    nl,
    ecrire_gras('RAVIN'), nl,
    nl,
    assert(a_vu(ravin)),
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(ravin)'), nl, !.
% Donjon
decrire(donjon) :-
    a_vu(donjon),
    vivant(dragon),
    nl,
    ecrire_gras('INTERIEUR DU DONJON'), nl,
    nl,
    write('Vous etes dans le donjon, le dragon est toujours enroule autour du tresor !'), nl,
    nl,
    write('Vous : Ce dragon ne me laissera pas acceder au tresor comme ca, il faut que je le tue !'), nl, !.
decrire(donjon) :-
    a_vu(donjon),
    nl,
    ecrire_gras('INTERIEUR DU DONJON'), nl,
    nl,
    write('Vous etes dans le donjon, le dragon est mort a terre, vous avez pille le tresor, votre quete est terminee !'), nl,
    nl,
    write('Vous : Le tresor, enfin ! Ce reve etait donc vrai... Mais alors... cet autre reve avec un poulpe...  ...TO BE CONTINUED'), nl, !.
decrire(donjon) :-
    nl,
    ecrire_gras('INTERIEUR DU DONJON'), nl,
    nl,
    assert(a_vu(donjon)),
    nl,
    write('Un dragon vous fait face, il protege jalousement son tresor, il ne tient qu''a vous de lui faire face. Serez vous assez fort ?'), nl,
    nl,
    write('Vous pouvez desormais utiliser le voyage rapide pour ce lieu grace a la commande aller(donjon)'), nl, !.

% Possibilites de chemins
%   - atelier
possibilites_chemins(atelier) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a la mine      : Sud (s.)'), nl,
    write('Aller a votre maison : Est (e.)'), nl, !.
%   - mine
possibilites_chemins(mine) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,  
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a votre atelier : Nord (n.)'), nl,
    write('Aller a la grotte     : Sud (s.)'), nl,
    write('Aller au carrefour    : Est (e.)'), nl, !.
%   - entree de la grotte orc vivant
possibilites_chemins(entree_grotte) :-
    vivant(orc),
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a la mine     : Nord (n.)'), nl,
    write('Aller dans la foret : Est (e.)'), nl, !.
%   - entree de la grotte orc vivant
possibilites_chemins(entree_grotte) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a la mine       : Nord (n.)'), nl,
    write('Entrer dans la grotte : Sud (s.)'), nl,
    write('Aller dans la foret   : Est (e.)'), nl, !.
%   - interieur de la grotte
possibilites_chemins(grotte) :-
    write('Vous : Ou bien je peux sortir...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Sortir de la grotte : Nord (n.)'), nl, !.
%   - maison
possibilites_chemins(maison) :-
    write('Vous : Ou vais-je continuer mon chemin ?'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller au carrefour    : Sud (s.)'), nl,
    write('Aller a la riviere    : Est (e.)'), nl,
    write('Aller a votre atelier : Ouest (o.)'), nl, !.
%   - carrefour
possibilites_chemins(carrefour) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a votre maison : Nord (n.)'), nl,
    write('Aller dans la foret  : Sud (s.)'), nl,
    write('Aller a la cascade   : Est (e.)'), nl,
    write('Aller a la mine      : Ouest (o.)'), nl, !.
%   - foret
possibilites_chemins(foret) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,
    write('Aller au carrefour : Nord (n.)'), nl,
    write('Aller a la grotte  : Ouest (o.)'), nl, !.
%   - riviere
possibilites_chemins(riviere) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a la cascade   : Sud (s.)'), nl,
    write('Traverser la riviere : Est (e.)'), nl,
    write('Aller a votre maison : Ouest (o.)'), nl, !.
%   - cascade
possibilites_chemins(cascade) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Aller a la riviere : Nord (n.)'), nl,
    write('Aller au carrefour : Ouest (o.)'), nl, !.
%   - creux
possibilites_chemins(creux) :-
    write('Vous : Ou bien je peux sortir...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,   
    write('Sortir de la cascade : Haut (u.)'), nl, !.
%   - grand arbre
possibilites_chemins(grand_arbre) :-
    write('Vous : Ou bien je retourne au donjon...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,   
    write('Aller au donjon : Sud (s.)'), nl, !.
%   - tronc
possibilites_chemins(tronc) :-
    write('Vous : Ou bien je redescends...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,   
    write('Redescendre de l''arbre : Bas (d.)'), nl, !.
%   - entree du donjon
possibilites_chemins(entree_donjon) :-
    sac(cle_donjon, 1),
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,   
    write('Aller au grand arbre  : Nord (n.)'), nl,
    write('Aller au ravin        : Sud (s.)'), nl,
    write('Entrer dans le donjon : Est (e.)'), nl, !.
%   - entree du donjon sans cle
possibilites_chemins(entree_donjon) :-
    write('Vous : Ou bien je continue mon chemin...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,   
    write('Aller au grand arbre : Nord (n.)'), nl,
    write('Aller au ravin       : Sud (s.)'), nl, !.
%   - ravin
possibilites_chemins(ravin) :-
    write('Vous : Ou bien je retourne au donjon...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl,   
    write('Aller au donjon : Nord (n.)'), nl, !.
%   - donjon
possibilites_chemins(donjon) :-
    write('Vous : Ou bien je peux sortir...'), nl,
    nl,  
    ecrire_gras("DIRECTIONS POSSIBLES "), nl,
    nl, 
    write('Sortir du donjon : Ouest (o.)'), nl, !.

% Astuces
%   - atelier avec objets a terre
astuces(atelier) :-
    il_y_a(_,atelier),
    write('Vous : Je pourrais crafter des objets. '), nl,
    write('Astuce : - crafter(HautGauche,HD,BG,BD) => remplacez chaque emplacement HG/HD/BG/BD par pierre/cuivre/diamant/cuir/bois/liane/rien'), nl,
    write('         - crafter(Objet) si vous en avez deja fait Objet (peut importe le minerai).'), nl,
    write('         - ramasser(Objet) (ex: ramasser epee de base => ramasser(epee_base)).'), nl,
    nl, !.
%   - atelier sans objet a terre
astuces(atelier) :-
    write('Vous : Je pourrais crafter des objets. '), nl,
    write('Astuce : - crafter(HautGauche,HD,BG,BD) => remplacez chaque emplacement HG/HD/BG/BD par pierre/cuivre/diamant/cuir/bois/liane/rien'), nl,
    write('         - crafter(Objet) si vous en avez deja fait un.'), nl,
    nl, !.
%   - mine avec pioche
astuces(mine) :-
    equipement(arme, Arme),
    equivalent(Arme, pioche, _),
    write('Vous : On dirait que ces gisements sont encore exploitables. Je devrais peut etre en prendre pour crafter des objets.'), nl,
    fail.
%   - mine sans pioche
astuces(mine) :-
    equipement(arme, Arme),
    equivalent(Arme, Artefact, _),
    Artefact \= pioche,
    write('Vous : On dirait que ces gisements sont encore exploitables. Ou est ma pioche ?'), nl,
    write('Astuce : - il y a une pioche de base a l''atelier.'), nl,
    fail.
%   - mine de toute maniere
astuces(mine) :-
    write('Astuce : - equiper(pioche) pour equiper votre meilleure pioche.'), nl,
    write('         - miner(Minerai) => remplacez Minerai par pierre/cuivre/diamant'), nl,
    write('         - suivant la rarete de votre pioche, vous minerez plus facilement les minerais.'), nl,
    nl, !.
%   - entree de la grotte
astuces(entree_grotte) :-
    vivant(orc),
    write('Vous : Je pourrais l''attaquer ... mais suis-je assez puissant ?'), nl,
    write('Astuce : - sequiper pour equiper vos meilleurs equipements.'), nl,
    write('         - stats pour connaitre vos stats.'), nl,
    write('         - stats(Ennemi) pour connaitre les stats d''un ennemi.'), nl,
    write('         - attaquer(Ennemi) pour attaquer.'), nl,
    nl, !.
astuces(entree_grotte) :- !.
%   - interieur de la grotte
astuces(grotte) :-
    il_y_a(parchemin, grotte),
    write('Vous : Y a-t-il quelque chose d''interessant a recuperer ici ?'), nl,
    write('Astuce : - fouiller pour fouiller'), nl,
    nl, !.
astuces(grotte) :- !.
%   - maison
astuces(maison) :- !.
%   - carrefour
astuces(carrefour) :-
    write('Vous : Je pourrais le tuer puis prendre tout ce qu''il a... ou juste lui vendre des objets...'), nl,
    write('Astuce : - vendre(Objet, Quantitee) (ex: vendre 5 casques en cuir => vendre(casque_cuir, 5)).'), nl,
    write('         - prix(Objet) (ex: connaitre le prix de casque en cuir => prix(casque_cuir))'), nl,
    write('         - ramasser(Objet) (ex: ramasser epee de base => ramasser(epee_base)).'), nl,
    nl, !.
%   - foret avec hache
astuces(foret) :-
    equipement(arme, Arme),
    equivalent(Arme, hache, _),
    write('Vous : Quels beaux chenes, ils devraient etre parfaits pour du bois ou des lianes.'), nl,
    fail.
%   - foret sans hache
astuces(foret) :-
    equipement(arme, Arme),
    equivalent(Arme, Artefact, _),
    Artefact \= hache,
    write('Vous : Quels beaux chenes, ils devraient etre parfaits pour du bois ou des lianes. Ou est ma hache ?'), nl,
    write('Astuce : - il y a une hache de base a l''atelier.'), nl,
    fail.
%   - foret de toutes maniere
astuces(foret) :-
    write('Astuce : - equiper(hache) pour equiper votre meilleure hache.'), nl,
    write('         - recolter(Ressource) => remplacez Ressource par bois/liane'), nl,
    write('         - suivant la rarete de votre hache, vous recolterez plus facilement les ressources.'), nl,
    nl, fail.
astuces(foret) :-
    write('Vous : J''entends des animaux, je pourrais tenter de les chasser pour obtenir du cuir.'), nl,
    write('Astuce : - sequiper pour equiper vos meilleurs equipements.'), nl,
    write('         - stats pour connaitre vos stats.'), nl,
    write('         - stats(Ennemi) pour connaitre les stats d''un ennemi.'), nl,
    write('         - attaquer(Animal) => remplacez Animal par cocatrix/nekker/centaure/sanglier/troll.'), nl,
    nl, !.
%   - riviere avec bateau
astuces(riviere) :- il_y_a(bateau, riviere), !.
%   - riviere sans bateau avec marteau
astuces(riviere) :-
    equipement(arme, Arme),
    equivalent(Arme, marteau, _),
    write('Vous : Le courant est bien trop important, je devrais construire un bateau.'), nl,
    write('Astuce : - construire(bateau).'), nl,
    nl, !.
%   - riviere sans bateau sans marteau
astuces(riviere) :-
    write('Vous : Le courant est bien trop important, je devrais construire un bateau. Ou est mon marteau ?'), nl,
    write('Astuce : - construire(bateau).'), nl,
    write('         - equiper(marteau) pour equiper votre marteau.'), nl,
    write('         - il y a un marteau de base a l''atelier.'), nl,
    nl, !.
%   - cascade
astuces(cascade) :- a_vu(creux), !.
%   - cascade creux non decouvert
astuces(cascade) :-
    write('Astuce : - regardez bien de partout...'), nl,
    nl, !.
%   - creux avec cle
astuces(creux) :-
    il_y_a(epee_du_hero, creux),
    sac(cle, 1),
    write('Vous : Belle cachette pour ce coffre ! Et en plus j''ai une cle !'), nl,
    write('Astuce : - fouiller pour fouiller...'), nl, !.
%   - creux sans cle
astuces(creux) :-
    il_y_a(epee_du_hero, creux),
    write('Vous : Belle cachette pour ce coffre ! Dommage que je n''ai pas de cle !'), nl,
    write('Astuce : - cherchez au carrefour...'), nl,
    nl, !.
%   - creux coffre ouvert
astuces(creux) :- !.
%   - grand arbre
astuces(grand_arbre) :-
    a_vu(tronc),
    write('Vous : Quels beaux champignons ! '), nl,
    write('Astuce : - ramasser(Objet) (ex: epee de base => ramasser(epee_base)).'), nl,
    write('         - manger(Objet) (ex: laitue verte => manger(laitue_verte)).'), nl,
    nl, !.
%   - grand arbre tronc non decouvert
astuces(grand_arbre) :-
    write('Vous : Quels beaux champignons ! '), nl,
    write('Astuce : - ramasser(Objet) (ex: epee de base => ramasser(epee_base)).'), nl,
    write('         - manger(Objet) (ex: laitue verte => manger(laitue_verte)).'), nl,
    write('         - regardez bien de partout...'), nl,
    nl, !.
%   - tronc
astuces(tronc) :-
    il_y_a(parchemin, tronc),
    write('Vous : J''apercois un morceau de feuille, qu''est ce que c''est ? '), nl,
    write('Astuce : - fouiller pour fouiller.'), nl,
    nl, !.
%   - tronc sans parchemin
astuces(tronc) :- !.
%   - entree du donjon avec 3 parchemin
astuces(entree_donjon) :-
    sac(parchemin, 2),
    write('Vous : Je devrais montrer au Mage Uscule que j''ai ces 2 parchemins... '), nl,
    write('Astuce : - donner(Objet) (ex: epee de base => donner(epee_base)).'), nl,
    nl, !.
%   - entree du donjon 3 sans parchemin
astuces(entree_donjon) :-
    write('Vous : Je devrais chercher ces parchemins... '), nl,
    write('Astuce : - regardez bien de partout sur votre chemin...'), nl,
    nl, !.
%   - ravin
astuces(ravin) :-
    write('Vous : Ca a l''air haut ici... j''entends un bruit venant du bas, je pourrais aller y jeter un coup d''oeil... '), nl,
    write('Astuce : - sepencher pour se pencher.'), nl,
    nl, !.
%   - donjon
astuces(donjon) :-
    vivant(dragon),
    write('Vous : Suis-je vraiment pret pour ce combat ? '), nl,
    write('Astuce : - sequiper pour equiper vos meilleurs equipements.'), nl,
    write('         - stats pour connaitre vos stats.'), nl,
    write('         - stats(Ennemi) pour connaitre les stats d''un ennemi.'), nl,
    write('         - attaquer(Ennemi) pour attaquer.'), nl,
    nl, !.
%   - donjon sans dragon
astuces(donjon) :-
    write('Vous : Bon bah j''ai fini... '), nl,
    write('Astuce : - halt pour quitter.'), nl,
    nl, !.

% Objets autour
lister_objets(Endroit) :-
    il_y_a(X, Endroit),
    X \= parchemin,
    X \= epee_du_hero,
    write('Il y a un(e) '), nom_objet(X), write(' ici.'), nl, fail.


lister_objets(_) :- !.

/* ITEMS DISPONIBLES DANS L'ENVIRONNEMENT */
% Atelier
il_y_a(pioche_base,  atelier).
il_y_a(hache_base,   atelier).
il_y_a(marteau_base, atelier).
% Entree de la grotte
il_y_a(orc, entree_grotte).
% Interieur de la grotte
il_y_a(parchemin, grotte).
% Carrefour
il_y_a(pierre,   carrefour).
il_y_a(cailloux, carrefour).
il_y_a(panneaux, carrefour).
% Creux
il_y_a(epee_du_hero, creux).
% Arabre geant
il_y_a(champignon, grand_arbre).
% Tronc
il_y_a(parchemin, tronc).
% Interieur du donjon
il_y_a(dragon, donjon).


/* TYPES D'ITEMS */
% Minerai
minerai(pierre).
minerai(cuivre).
minerai(diamant).
% Ressource
ressource(bois).
ressource(liane).
% Ressource vetement
ressource_vetement(cuir).
ressource_vetement(cuivre).
ressource_vetement(diamant).
% Arme
arme(epee).
arme(arc).
arme(hache).
arme(pioche).
arme(marteau).
% Outil
outil(hache).
outil(pioche).
outil(marteau).


/* PRIX */
% Prix Objet
prix(Objet) :-
    equivalent(Objet, Artefact, Materiau),
    objet(Artefact, Materiau, _, _, _, Prix),
    nom_objet(Objet), ecrire_gras_couleur(' vaut ', green), ecrire_gras_couleur(Prix, blue), ecrire_gras_couleur(' pieces d''or.', green), nl, !.
% Prix defaut
prix(_) :-
    write('Ceci ne se vend pas !'),
    nl, !.


/* STATS */
% Etres
%   animal(nom, attaque, defense, nb cuir)
animal(cocatrix,  5,  5,  1).
animal(nekker,   15, 10,  2).
animal(centaure, 20, 30,  3).
animal(sanglier, 30, 50, 10).
animal(troll,    60, 60, 20).
%   boss(nom, attaque, defense)
boss(orc,    100,  50).
boss(dragon, 300, 100).
%   pnj(nom)
pnj(marchand).
pnj(mage).

    

%   joueur
%   - attaque
pts_attaque(AJ) :-
    joueur(Arme, Casque, Plastron, Pantalon, Bottes), !,

    equivalent(Arme, A, MA),
    objet(A, MA, AA, _, _, _),
    equivalent(Casque, C, MC),
    objet(C, MC, AC, _, _, _),
    equivalent(Plastron, PL, MPL),
    objet(PL, MPL, APL, _, _, _),
    equivalent(Pantalon, PA, MPA),
    objet(PA, MPA, APA, _, _, _),
    equivalent(Bottes, B, MB),
    objet(B, MB, AB, _, _, _),

    AJ is AA + AC + APL + APA + AB.
%   - defense
pts_defense(DJ) :-    
    joueur(Arme, Casque, Plastron, Pantalon, Bottes), !,

    equivalent(Arme, A, MA),
    objet(A, MA, _, DA, _, _),
    equivalent(Casque, C, MC),
    objet(C, MC, _, DC, _, _),
    equivalent(Plastron, PL, MPL),
    objet(PL, MPL, _, DPL, _, _),
    equivalent(Pantalon, PA, MPA),
    objet(PA, MPA, _, DPA, _, _),
    equivalent(Bottes, B, MB),
    objet(B, MB, _, DB, _, _),
    
    DJ is DA + DC + DPL + DPA + DB.

    

% Objets
% objet(Artefact, Materiau, Attaque, Defense, Poids, Prix)
%   rien
objet(rien, rien,        0,  0,  0,  0).
%   minerai
objet(minerai, pierre,   0,  0,  1,  1).
objet(minerai, cuivre,   0,  0,  2,  5).
objet(minerai, diamant,  0,  0,  5, 10).
%   minerai
objet(ressource, liane,  0,  0,  1,  1).
objet(ressource, bois,   0,  0,  1,  1).
objet(ressource, cuir,   0,  0,  1, 80).
%   marteau
objet(marteau, base,     1,  0,  1,  0).
%   pioche
objet(pioche, base,      1,  0,  1,  1).
objet(pioche, pierre,    5,  0,  2,  2).
objet(pioche, cuivre,   10,  0,  5,  5).
objet(pioche, diamant,  20,  0, 10, 10).
%   hache
objet(hache, base,       1,  0,  1,  1).
objet(hache, pierre,     5,  0,  2,  2).
objet(hache, cuivre,    10,  0,  5,  5).
objet(hache, diamant,   20,  0, 10, 10).
%   epee
objet(epee, hero,        1,  0,  1,  0).
objet(epee, pierre,      6,  0,  1,  8).
objet(epee, cuivre,     15,  0,  4, 12).
objet(epee, diamant,    30,  0, 10, 42).
objet(epee, enchantee, 500,  0, 10,  0).
%   arc
objet(arc, normal,       3,  0,  1,  9).
%   fleche
objet(fleche, pierre,    5,  0,  1,  8).
objet(fleche, cuivre,   12,  0,  2, 12).
objet(fleche, diamant,  20,  0,  5, 27).
%   casque
objet(casque, cuir,      0,  2,  2,  4).
objet(casque, cuivre,    0, 14,  5, 12).
objet(casque, diamant,   0, 30, 10, 42).
%   plastron
objet(plastron, cuir,    0,  4,  4,  8).
objet(plastron, cuivre,  0, 28, 10, 24).
objet(plastron, diamant, 0, 60, 20, 84).
%   pantalon
objet(pantalon, cuir,    0,  4,  2, 10).
objet(pantalon, cuivre,  0, 16,  5, 18).
objet(pantalon, diamant, 0, 32, 10, 48).
%   bottes
objet(bottes, cuir,      0,  3,  2,  7).
objet(bottes, cuivre,    0, 15,  5, 15).
objet(bottes, diamant,   0, 31, 10, 45).


/* EQUIVALENCES */
% Objets
%   rien
equivalent(rien, rien, rien).
%   minerai
equivalent(pierre,  minerai, pierre).
equivalent(cuivre,  minerai, cuivre).
equivalent(diamant, minerai, diamant).
%   ressource
equivalent(liane, ressource, liane).
equivalent(bois,  ressource, bois).
equivalent(cuir,  ressource, cuir).
%   marteau
equivalent(marteau_base, marteau, base).
%   pioche
equivalent(pioche_base,    pioche, base).
equivalent(pioche_pierre,  pioche, pierre).
equivalent(pioche_cuivre,  pioche, cuivre).
equivalent(pioche_diamant, pioche, diamant).
%   hache
equivalent(hache_base,    hache, base).
equivalent(hache_pierre,  hache, pierre).
equivalent(hache_cuivre,  hache, cuivre).
equivalent(hache_diamant, hache, diamant).
%   epee
equivalent(epee_du_hero,   epee, hero).
equivalent(epee_pierre,    epee, pierre).
equivalent(epee_cuivre,    epee, cuivre).
equivalent(epee_diamant,   epee, diamant).
equivalent(epee_enchantee, epee, enchantee).
%   arc
equivalent(arc, arc, normal).
%   fleche
equivalent(fleche_pierre,  fleche, pierre).
equivalent(fleche_cuivre,  fleche, cuivre).
equivalent(fleche_diamant, fleche, diamant).
%   casque
equivalent(casque_cuir,    casque, cuir).
equivalent(casque_cuivre,  casque, cuivre).
equivalent(casque_diamant, casque, diamant).
%   plastron
equivalent(plastron_cuir,    plastron, cuir).
equivalent(plastron_cuivre,  plastron, cuivre).
equivalent(plastron_diamant, plastron, diamant).
%   pantalon
equivalent(pantalon_cuir,    pantalon, cuir).
equivalent(pantalon_cuivre,  pantalon, cuivre).
equivalent(pantalon_diamant, pantalon, diamant).
%   bottes
equivalent(bottes_cuir,    bottes, cuir).
equivalent(bottes_cuivre,  bottes, cuivre).
equivalent(bottes_diamant, bottes, diamant).

/* NOM OBJET */
nom_objet(rien) :-
    ecrire_gras_couleur('Aucun objet equipe', red), !.
nom_objet(cuir) :-
    ecrire_gras_couleur('cuir', blue), !.
nom_objet(epee_du_hero) :-
    ecrire_gras_couleur('epee du hero', blue), !.
nom_objet(epee_enchantee) :-
    ecrire_gras_couleur('epee enchantee', blue), !.
nom_objet(cle_donjon) :-
    ecrire_gras_couleur('cle du donjon', blue), !.
nom_objet(Minerai) :-
    minerai(Minerai),
    ecrire_gras_couleur(Minerai, blue), !.
nom_objet(Ressource) :-
    ressource(Ressource),
    ecrire_gras_couleur(Ressource, blue), !.
nom_objet(Objet) :-
    equivalent(Objet, Artefact, Matiere),
    Matiere \= base,
    ecrire_gras_couleur(Artefact, blue), ecrire_gras_couleur(' en ', blue), ecrire_gras_couleur(Matiere, blue), !.
nom_objet(Objet) :-
    equivalent(Objet, Artefact, base),
    ecrire_gras_couleur(Artefact, blue), ecrire_gras_couleur(' de base', blue), !.
nom_objet(Objet) :-
    ecrire_gras_couleur(Objet, blue), !.