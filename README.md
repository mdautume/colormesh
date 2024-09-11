# colormesh

Utilitaire pour créer des meshs texturés à partir d'un dsm et d'images satellites

Pour compiler refine : 
g++ src/refine.cc -lgmp -I/usr/local/include/ -L /usr/local/Cellar/cgal/5.6.1/lib/ -o bin/refine -std=c++14

Exemple d'utilisation de colorisation à partir d'une seule image dans test.fish
Tout est censé fonctionner. Il faut juste récupérer les données du dataset iarpa

L'identifiant 37 correspond aux images 18DEC15WV031000015DEC18140522-P1BS-500515572020_01_P001_________AAE_0AAAAABPABJ0.
Le script fonctionne avec n'importe quelle image mais les offsets sont différents à chaque fois.
Ce n'est pas l'image la plus intéressante (on ne voit pas les façades). 
À tester sur un pc qui a le dataset entier.

À venir : colorisation à l'aide de plusieurs images

