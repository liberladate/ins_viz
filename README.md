Liber la date
=======

[Institutul National de Statistica](http://www.insse.ro) a facut public accesibile datele pe care le poseda. Aceste date pot fi gasite [aici](http://statistici.insse.ro/shop/). Considerand ca pana de curand aceste date puteau fi vizualizate doar contracost, efortul INS trebuie admirat si folosit ca exemplu. 

Vizualizarea acestor date folosind [siteul INS](http://statistici.insse.ro/shop/) este greoaie si, nu tocmai, intuitiva. Plecand de la intuitia ca vizualizarea datelor poate fi imbunatatita, [ins_viz](http://liberladate.ro/) a fost dezvoltat. Proiectul nu face altceva decat sa foloseasca structura tabelelor asa cum este ea prezentata pe siteul INS si sa interogheze direct un serverele INS pentru datele efective ce apar in grafice

Moduri de vizualizare
===
In momentul de fata proiectul este inca in faza de concept. Feedback cu privire la intregul proiect este mai mult decat binevenit! In particular, idei noi cu privire la modul de vizualizare al datelor ar fi fantastice. Pentru feedback folositi sistemul de "issues" al Github sau trimiteti email la [liberladate@gmail.com](mailto:liberladate@gmail.com)

Tehnologii
==========

Siteul este scris in Ruby folosind Sinatra ca framework si HAML pentru template rendering. Redis este folosit pentru a face caching datelor obtinute de la serverele INS.

Contributii
===
Contributiile sunt incurajate. Proiectul se bazeaza pe ideea ca o comunitate poate dezvolta software mai bine decat o poate face un individ. Pentru a lucra la proiect pe calculatorul dumneavoastra aveti nevoie de: Ruby, Bundler si Redis. Pentru a vedea siteul local, porniti serverul redis local folosind comanda `redis-server` si apoi porniti serverul de ruby cu comanda `rake run`. Apoi daca vizitati pagina localhost:9292 o sa gasiti siteul pornit local.
