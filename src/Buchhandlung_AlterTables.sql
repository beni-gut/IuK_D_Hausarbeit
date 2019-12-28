ALTER TABLE tBuch ADD FOREIGN KEY (infoId) REFERENCES tInfo(infoId);
ALTER TABLE tBuch ADD FOREIGN KEY (langId) REFERENCES tLanguage(langId);
ALTER TABLE tBuch ADD FOREIGN KEY (priceId) REFERENCES tPrices(priceId);
ALTER TABLE tBuch ADD FOREIGN KEY (publisherId) REFERENCES tPublisher(publisherId);
ALTER TABLE tBuch ADD FOREIGN KEY (availableId) REFERENCES tAvailability(availableId);
ALTER TABLE tBuch ADD FOREIGN KEY (placeId) REFERENCES tInventory(placeId);


ALTER TABLE tLanguage ADD UNIQUE (sprache);
ALTER TABLE tInfo ADD UNIQUE (titel);
ALTER TABLE tInfo ADD UNIQUE (isbn);
ALTER TABLE tAvailability ADD UNIQUE (verfuegbarkeit);

ALTER TABLE tPublisher ADD UNIQUE (verlagsBezeichnung);
ALTER TABLE tPublisher ADD UNIQUE (telefonnumer);
ALTER TABLE tPublisher ADD UNIQUE (mailadresse);
ALTER TABLE tPrices ADD UNIQUE (einkaufspreis);


ALTER TABLE tPrices ADD CHECK ( einkaufspreis > 0 );
ALTER TABLE tPrices ADD CHECK ( bestandespreis > 0 );
ALTER TABLE tPrices ADD CHECK ( verkaufspreis > 0 );

ALTER TABLE tInventory ADD FOREIGN KEY (storeId) REFERENCES tStore(storeId);
ALTER TABLE tInventory ADD FOREIGN KEY (storageId) REFERENCES tStorage(storageId);

ALTER TABLE tStore ADD CHECK ( anzahl >= 0 );
ALTER TABLE tStorage ADD CHECK ( anzahl >= 0 );

ALTER TABLE tAuthor ADD UNIQUE (autorName, authorVorname);


ALTER TABLE tMappingBuchAuthor ADD FOREIGN KEY (buchId) REFERENCES tBuch(buchId);
ALTER TABLE tMappingBuchAuthor ADD FOREIGN KEY (authorId) REFERENCES tAuthor(authorId);
ALTER TABLE tMappingBuchAuthor ADD UNIQUE (buchId, authorId);

