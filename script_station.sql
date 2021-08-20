CREATE TABLE credit_particulier(
   credit_particulier_id INT,
   date_credit VARCHAR(50),
   date_echeance VARCHAR(50),
   montant_credit VARCHAR(50),
   PRIMARY KEY(credit_particulier_id)
);

CREATE TABLE gerant(
   gerant_id INT,
   prenom_gerant VARCHAR(255),
   nom_gerant VARCHAR(255),
   adresse_gerant VARCHAR(255),
   telephone_gerant VARCHAR(255),
   mail_gerant VARCHAR(255),
   login VARCHAR(50),
   password VARCHAR(50),
   PRIMARY KEY(gerant_id)
);

CREATE TABLE direction(
   direction_id INT,
   nom_direction VARCHAR(50),
   PRIMARY KEY(direction_id)
);

CREATE TABLE client_entreprise(
   client_entreprise_id VARCHAR(50),
   nom_compagnie VARCHAR(50),
   nom_client_entreprise VARCHAR(50),
   souscription_compagnie VARCHAR(50),
   status_compagnie VARCHAR(50),
   PRIMARY KEY(client_entreprise_id)
);

CREATE TABLE remboursement_entreprise(
   remboursement_entreprise_id INT,
   montant_rembourser DOUBLE,
   date_remboursement DATE,
   client_entreprise_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(remboursement_entreprise_id),
   FOREIGN KEY(client_entreprise_id) REFERENCES client_entreprise(client_entreprise_id)
);

CREATE TABLE credit_entreprise(
   credit_entreprise_id INT,
   date_credit DATE,
   montant_depenser VARCHAR(50),
   solde_restant VARCHAR(50),
   client_entreprise_id VARCHAR(50) NOT NULL,
   PRIMARY KEY(credit_entreprise_id),
   FOREIGN KEY(client_entreprise_id) REFERENCES client_entreprise(client_entreprise_id)
);

CREATE TABLE station(
   station_id INT,
   nom_station VARCHAR(255),
   adresse_station VARCHAR(255),
   telephone_station VARCHAR(255),
   objectif INT,
   besoin INT,
   gerant_id INT NOT NULL,
   direction_id INT NOT NULL,
   PRIMARY KEY(station_id),
   FOREIGN KEY(gerant_id) REFERENCES gerant(gerant_id),
   FOREIGN KEY(direction_id) REFERENCES direction(direction_id)
);

CREATE TABLE vente(
   releve_de_vente_id INT,
   _date DATE,
   tpe_vente DOUBLE,
   espece_vente DOUBLE,
   gerant_id INT NOT NULL,
   PRIMARY KEY(releve_de_vente_id),
   FOREIGN KEY(gerant_id) REFERENCES gerant(gerant_id)
);

CREATE TABLE produit(
   produit_id INT,
   nom VARCHAR(255),
   prix DECIMAL(15,2),
   PRIMARY KEY(produit_id)
);

CREATE TABLE cuve(
   cuve_id INT,
   capacite DECIMAL(15,2),
   station_id INT NOT NULL,
   produit_id INT NOT NULL,
   PRIMARY KEY(cuve_id),
   FOREIGN KEY(station_id) REFERENCES station(station_id),
   FOREIGN KEY(produit_id) REFERENCES produit(produit_id)
);

CREATE TABLE pompe(
   pompe_id INT,
   libeller VARCHAR(255),
   status VARCHAR(255),
   index_depart DECIMAL(15,2),
   index_fin DECIMAL(15,2),
   produit_id INT NOT NULL,
   PRIMARY KEY(pompe_id),
   FOREIGN KEY(produit_id) REFERENCES produit(produit_id)
);

CREATE TABLE banque(
   banque_id INT,
   nom_banque VARCHAR(50),
   localisation_bank VARCHAR(50),
   PRIMARY KEY(banque_id)
);

CREATE TABLE commande(
   command_id INT,
   date_commande VARCHAR(50),
   quantite_commandee DECIMAL(15,2),
   type_produit VARCHAR(50),
   reference_produit VARCHAR(50),
   direction_id INT NOT NULL,
   gerant_id INT NOT NULL,
   PRIMARY KEY(command_id),
   FOREIGN KEY(direction_id) REFERENCES direction(direction_id),
   FOREIGN KEY(gerant_id) REFERENCES gerant(gerant_id)
);

CREATE TABLE camion(
   camion_id INT,
   nom_camion VARCHAR(50),
   prenom_camion VARCHAR(50) NOT NULL,
   quantite_camion DECIMAL(15,2),
   PRIMARY KEY(camion_id)
);

CREATE TABLE chauffeur(
   chauffeur_id INT,
   PRIMARY KEY(chauffeur_id)
);

CREATE TABLE client_particulier(
   client_particulier_id INT,
   nom_client VARCHAR(50),
   prenom_client VARCHAR(50),
   telephone_client VARCHAR(50),
   status_client LOGICAL,
   credit_particulier_id INT NOT NULL,
   gerant_id INT NOT NULL,
   PRIMARY KEY(client_particulier_id),
   FOREIGN KEY(credit_particulier_id) REFERENCES credit_particulier(credit_particulier_id),
   FOREIGN KEY(gerant_id) REFERENCES gerant(gerant_id)
);

CREATE TABLE pompiste(
   pompiste__id INT,
   prenom_pompiste VARCHAR(255),
   nom_pompiste VARCHAR(255),
   adresse_pompiste VARCHAR(255),
   telephone_pompiste VARCHAR(25),
   id_user INT,
   releve_de_vente_id INT NOT NULL,
   pompe_id INT NOT NULL,
   PRIMARY KEY(pompiste__id),
   FOREIGN KEY(releve_de_vente_id) REFERENCES vente(releve_de_vente_id),
   FOREIGN KEY(pompe_id) REFERENCES pompe(pompe_id)
);

CREATE TABLE livraison(
   produit_id INT,
   borderaux_livraison VARCHAR(50),
   date_livraison DATE,
   reference_produit_livrer VARCHAR(50),
   chauffeur_id INT NOT NULL,
   command_id INT NOT NULL,
   station_id INT NOT NULL,
   direction_id INT NOT NULL,
   PRIMARY KEY(produit_id),
   FOREIGN KEY(chauffeur_id) REFERENCES chauffeur(chauffeur_id),
   FOREIGN KEY(command_id) REFERENCES commande(command_id),
   FOREIGN KEY(station_id) REFERENCES station(station_id),
   FOREIGN KEY(direction_id) REFERENCES direction(direction_id)
);

CREATE TABLE remboursement_particulier(
   remboursement_particulier_id INT,
   montant_pris VARCHAR(50),
   montant_rembourser VARCHAR(50),
   date_rembousement DATE,
   credit_particulier_id INT NOT NULL,
   client_particulier_id INT NOT NULL,
   PRIMARY KEY(remboursement_particulier_id),
   FOREIGN KEY(credit_particulier_id) REFERENCES credit_particulier(credit_particulier_id),
   FOREIGN KEY(client_particulier_id) REFERENCES client_particulier(client_particulier_id)
);

CREATE TABLE concerner_stock(
   releve_de_vente_id INT,
   cuve_id INT,
   stock_super DECIMAL(15,2),
   stock_gazoil DECIMAL(15,2),
   PRIMARY KEY(releve_de_vente_id, cuve_id),
   FOREIGN KEY(releve_de_vente_id) REFERENCES vente(releve_de_vente_id),
   FOREIGN KEY(cuve_id) REFERENCES cuve(cuve_id)
);

CREATE TABLE gerer3(
   direction_id INT,
   client_entreprise_id VARCHAR(50),
   PRIMARY KEY(direction_id, client_entreprise_id),
   FOREIGN KEY(direction_id) REFERENCES direction(direction_id),
   FOREIGN KEY(client_entreprise_id) REFERENCES client_entreprise(client_entreprise_id)
);

CREATE TABLE occasionner(
   remboursement_entreprise_id INT,
   credit_entreprise_id INT,
   PRIMARY KEY(remboursement_entreprise_id, credit_entreprise_id),
   FOREIGN KEY(remboursement_entreprise_id) REFERENCES remboursement_entreprise(remboursement_entreprise_id),
   FOREIGN KEY(credit_entreprise_id) REFERENCES credit_entreprise(credit_entreprise_id)
);

CREATE TABLE versement1(
   gerant_id INT,
   station_id INT,
   banque_id INT,
   date_versement DATE,
   montant_versement VARCHAR(50),
   PRIMARY KEY(gerant_id, station_id, banque_id),
   FOREIGN KEY(gerant_id) REFERENCES gerant(gerant_id),
   FOREIGN KEY(station_id) REFERENCES station(station_id),
   FOREIGN KEY(banque_id) REFERENCES banque(banque_id)
);

CREATE TABLE avoir_servir(
   produit_id INT,
   camion_id INT,
   quantite_livree DECIMAL(15,2),
   PRIMARY KEY(produit_id, camion_id),
   FOREIGN KEY(produit_id) REFERENCES livraison(produit_id),
   FOREIGN KEY(camion_id) REFERENCES camion(camion_id)
);

CREATE TABLE concerner5(
   produit_id INT,
   produit_id_1 INT,
   PRIMARY KEY(produit_id, produit_id_1),
   FOREIGN KEY(produit_id) REFERENCES produit(produit_id),
   FOREIGN KEY(produit_id_1) REFERENCES livraison(produit_id)
);

