
CREATE TABLE direction (
                id BIGINT AUTO_INCREMENT NOT NULL,
                nom_direction VARCHAR NOT NULL,
                disrict_direction VARCHAR NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE banque (
                id BIGINT AUTO_INCREMENT NOT NULL,
                nom_banque VARCHAR NOT NULL,
                montant_depot BIGINT NOT NULL,
                date_depot DATE NOT NULL,
                localisation_banque VARCHAR NOT NULL,
                disponibilite VARCHAR NOT NULL,
                borderaux_depot VARCHAR NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE gerant (
                id BIGINT AUTO_INCREMENT NOT NULL,
                prenom_gerant VARCHAR NOT NULL,
                nom_gerant VARCHAR NOT NULL,
                adresse_gerant VARCHAR NOT NULL,
                telephone_gerant VARCHAR,
                mail_gerant VARCHAR,
                banque_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE client (
                id BIGINT AUTO_INCREMENT NOT NULL,
                status_client VARCHAR NOT NULL,
                credit_max_accorde INT NOT NULL,
                credit_emprunte INT NOT NULL,
                credit_rembourse INT NOT NULL,
                direction_id BIGINT NOT NULL,
                gerant_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE station (
                rid VARCHAR AUTO_INCREMENT NOT NULL,
                adresse_station VARCHAR NOT NULL,
                nom_station VARCHAR NOT NULL,
                objectif INT NOT NULL,
                besoin INT NOT NULL,
                type_payement VARCHAR NOT NULL,
                status VARCHAR NOT NULL,
                telephone_station VARCHAR NOT NULL,
                gerant_id BIGINT NOT NULL,
                PRIMARY KEY (rid)
);


CREATE TABLE pompiste (
                id BIGINT AUTO_INCREMENT NOT NULL,
                prenom_pompiste VARCHAR NOT NULL,
                nom_pompiste VARCHAR NOT NULL,
                adresse_pompiste VARCHAR NOT NULL,
                telephone_pompiste VARCHAR,
                station_id VARCHAR NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE cuve (
                id BIGINT AUTO_INCREMENT NOT NULL,
                capacite INT NOT NULL,
                station_id VARCHAR NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE pompe (
                id BIGINT AUTO_INCREMENT NOT NULL,
                libelle VARCHAR NOT NULL,
                status VARCHAR NOT NULL,
                cuve_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE vente (
                id BIGINT AUTO_INCREMENT NOT NULL,
                vente_tpe DOUBLE PRECISION NOT NULL,
                vente_comptant DOUBLE PRECISION NOT NULL,
                vente_date DATE NOT NULL,
                pompiste_id BIGINT NOT NULL,
                pompe_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE fournisseur (
                id BIGINT AUTO_INCREMENT NOT NULL,
                nom_fournisseur VARCHAR NOT NULL,
                produit_commandee VARCHAR NOT NULL,
                quantite_commandee DOUBLE PRECISION NOT NULL,
                direction_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE Chauffeur (
                id BIGINT AUTO_INCREMENT NOT NULL,
                nom_chauffeur VARCHAR NOT NULL,
                prenom_chauffeur VARCHAR NOT NULL,
                camion_chauffeur VARCHAR NOT NULL,
                quantite_prise VARCHAR NOT NULL,
                borderaux_livraison VARCHAR NOT NULL,
                fournisseur_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


CREATE TABLE produit (
                id BIGINT AUTO_INCREMENT NOT NULL,
                nom VARCHAR NOT NULL,
                reference VARCHAR NOT NULL,
                prix DOUBLE PRECISION NOT NULL,
                chauffeur_id BIGINT NOT NULL,
                cuve_id BIGINT NOT NULL,
                PRIMARY KEY (id)
);


ALTER TABLE fournisseur ADD CONSTRAINT direction_fournisseur_fk
FOREIGN KEY (direction_id)
REFERENCES direction (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE client ADD CONSTRAINT direction_client_fk
FOREIGN KEY (direction_id)
REFERENCES direction (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE gerant ADD CONSTRAINT banque_gerant_fk
FOREIGN KEY (banque_id)
REFERENCES banque (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE client ADD CONSTRAINT gerant_client_fk
FOREIGN KEY (gerant_id)
REFERENCES gerant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE station ADD CONSTRAINT gerant_station_fk
FOREIGN KEY (gerant_id)
REFERENCES gerant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pompiste ADD CONSTRAINT gerant_pompiste_fk
FOREIGN KEY (id)
REFERENCES gerant (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE cuve ADD CONSTRAINT station_cuve_fk
FOREIGN KEY (station_id)
REFERENCES station (rid)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pompiste ADD CONSTRAINT station_pompiste_fk
FOREIGN KEY (station_id)
REFERENCES station (rid)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE vente ADD CONSTRAINT pompiste_vente_fk
FOREIGN KEY (pompiste_id)
REFERENCES pompiste (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE pompe ADD CONSTRAINT cuve_pompe_fk
FOREIGN KEY (cuve_id)
REFERENCES cuve (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE produit ADD CONSTRAINT cuve_produit_fk
FOREIGN KEY (cuve_id)
REFERENCES cuve (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE vente ADD CONSTRAINT pompe_vente_fk
FOREIGN KEY (pompe_id)
REFERENCES pompe (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE Chauffeur ADD CONSTRAINT fournisseur_chauffeur_fk
FOREIGN KEY (fournisseur_id)
REFERENCES fournisseur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;

ALTER TABLE produit ADD CONSTRAINT chauffeur_produit_fk
FOREIGN KEY (chauffeur_id)
REFERENCES Chauffeur (id)
ON DELETE NO ACTION
ON UPDATE NO ACTION;
