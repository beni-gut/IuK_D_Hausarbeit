ALTER TABLE tBuch ADD FOREIGN KEY (shTimeId) REFERENCES tShipmentTime(shTimeId);
ALTER TABLE tBuch ADD FOREIGN KEY (langId) REFERENCES tLanguage(langId);
ALTER TABLE tBuch ADD FOREIGN KEY (infoId) REFERENCES tInfo(infoId);
ALTER TABLE tBuch ADD FOREIGN KEY (availableId) REFERENCES tAvailability(availableId);
ALTER TABLE tBuch ADD FOREIGN KEY (publisherId) REFERENCES tPublisher(publisherId);
ALTER TABLE tBuch ADD FOREIGN KEY (priceId) REFERENCES tPrices(priceId);
ALTER TABLE tBuch ADD FOREIGN KEY (placeId) REFERENCES tInventory(placeId);


ALTER TABLE tShipmentTime ADD UNIQUE (lieferfrist);
ALTER TABLE tLanguage ADD UNIQUE (sprache);
ALTER TABLE tInfo ADD UNIQUE (titel);
ALTER TABLE tInfo ADD UNIQUE (isbn);
ALTER TABLE tAvailability ADD UNIQUE (verfuegbarkeit);

ALTER TABLE tPublisher ADD FOREIGN KEY (addrId) REFERENCES tAddress(addrId);
ALTER TABLE tPublisher ADD UNIQUE (verlagsBezeichnung);
ALTER TABLE tPublisher ADD UNIQUE (telefonnummer);
ALTER TABLE tPublisher ADD UNIQUE (mailadresse);
ALTER TABLE tPrices ADD UNIQUE (einkaufspreis, bestandespreis, verkaufspreis);

ALTER TABLE tAddress ADD UNIQUE (addrStrasse, addrNummer, addrPLZ, addrOrt, addrLand);

ALTER TABLE tPrices ADD CHECK ( einkaufspreis > 0 );
ALTER TABLE tPrices ADD CHECK ( bestandespreis > 0 );
ALTER TABLE tPrices ADD CHECK ( verkaufspreis > 0 );

ALTER TABLE tInventory ADD CHECK ( storeAnz >= 0 );
ALTER TABLE tInventory ADD CHECK ( storageAnz >= 0 );
ALTER TABLE tInventory ADD UNIQUE (storeAnz, storageAnz);

ALTER TABLE tAuthor ADD UNIQUE (authorName, authorVorname);

ALTER TABLE tMappingBuchAuthor ADD FOREIGN KEY (buchId) REFERENCES tBuch(buchId);
ALTER TABLE tMappingBuchAuthor ADD FOREIGN KEY (authorId) REFERENCES tAuthor(authorId);
ALTER TABLE tMappingBuchAuthor ADD UNIQUE (buchId, authorId);

ALTER TABLE tBestellungen ADD FOREIGN KEY (buchId) REFERENCES tBuch(buchId);
ALTER TABLE tBestellungen ADD CHECK ( bestellDatum < current_date );
