CREATE TABLE tShipmentTime (
    shTimeId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    lieferfrist INTERVAL DAY NOT NULL
);

CREATE TABLE tLanguage (
    langId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    sprache VARCHAR(20) NOT NULL
);

CREATE TABLE tInfo (
    infoId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    titel TEXT NOT NULL ,
    isbn CHAR(13) NOT NULL
);

CREATE TABLE tAvailability (
    availableId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    verfuegbarkeit BOOLEAN NOT NULL
);

CREATE TABLE tPublisher (
    publisherId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    addrId INTEGER NOT NULL ,
    verlagsBezeichnung VARCHAR(20) NOT NULL ,
    telefonnummer VARCHAR(20) NOT NULL ,
    mailadresse VARCHAR(20) NOT NULL ,
    nameKontaktPers VARCHAR(20) NOT NULL,
    vornameKontaktPers VARCHAR(20) NOT NULL
);

CREATE TABLE tAddress (
    addrId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    addrStrasse VARCHAR(20) NOT NULL ,
    addrNummer VARCHAR(5) NOT NULL ,
    addrPLZ VARCHAR(10) NOT NULL ,
    addrOrt VARCHAR(20) NOT NULL ,
    addrLand CHAR(2) NOT NULL
);


CREATE TABLE tPrices (
    priceId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    einkaufspreis NUMERIC(5,2) NOT NULL ,
    bestandespreis NUMERIC(5,2) GENERATED ALWAYS AS ( einkaufspreis * 0.95 ) STORED NOT NULL ,
    verkaufspreis NUMERIC(5,2) GENERATED ALWAYS AS ( einkaufspreis * 1.2 ) STORED NOT NULL
);

CREATE TABLE tInventory (
    placeId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    storeAnz INTEGER NOT NULL ,
    storageAnz INTEGER NOT NULL
);


CREATE TABLE tBuch (
    buchId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    shTimeId INTEGER NOT NULL ,
    langId INTEGER NOT NULL ,
    infoId INTEGER NOT NULL ,
    availableId INTEGER NOT NULL ,
    publisherId INTEGER NOT NULL ,
    priceId INTEGER NOT NULL ,
    placeId INTEGER NOT NULL
);

CREATE TABLE tAuthor (
    authorId INTEGER GENERATED BY DEFAULT AS IDENTITY PRIMARY KEY NOT NULL ,
    authorName VARCHAR(20) NOT NULL ,
    authorVorname VARCHAR(20) NOT NULL
);

CREATE TABLE tMappingBuchAuthor (
    buchId INTEGER NOT NULL ,
    authorId INTEGER NOT NULL
);




/* 1 Kaufinformationen Titel, Autor, Sprache, Preis */
CREATE VIEW vKaufinfos AS
    SELECT tInfo.titel, tAuthor.authorName, tAuthor.authorVorname, tLanguage.sprache, tPrices.verkaufspreis
    FROM tInfo, tAuthor, tLanguage, tPrices, tMappingBuchAuthor, tBuch
    WHERE tMappingBuchAuthor.authorId = tAuthor.authorId AND tMappingBuchAuthor.buchId = tBuch.buchId AND tBuch.infoId = tInfo.infoId AND tBuch.langId = tLanguage.langId AND tBuch.priceId = tPrices.priceId;

/* 2 Telefon Bestellinfos ISBN, Verfügbarkeit, Lieferfrist, Verlag, Ansprechpartner, Telefonnummer */
CREATE VIEW vTelefonBestellinfos AS
    SELECT tInfo.isbn, tAvailability.verfuegbarkeit, tShipmentTime.lieferfrist, tPublisher.verlagsBezeichnung, tPublisher.nameKontaktPers, tPublisher.vornameKontaktPers, tPublisher.telefonnummer
    FROM tInfo, tAvailability, tShipmentTime, tPublisher, tBuch
    WHERE tBuch.infoId = tInfo.infoId AND tBuch.availableId = tAvailability.availableId AND tBuch.shTimeId = tShipmentTime.shTimeId AND tBuch.publisherId = tPublisher.publisherId;

/* 3 E-Mail Bestellinfos ISBN, Verfügbarkeit, Lieferfrist, Verlag, Ansprechpartner, Mailadresse */
CREATE VIEW vMailBestellinfos AS
SELECT tInfo.isbn, tAvailability.verfuegbarkeit, tShipmentTime.lieferfrist, tPublisher.verlagsBezeichnung, tPublisher.nameKontaktPers, tPublisher.vornameKontaktPers, tPublisher.mailadresse
FROM tInfo, tAvailability, tShipmentTime, tPublisher, tBuch
WHERE tBuch.infoId = tInfo.infoId AND tBuch.availableId = tAvailability.availableId AND tBuch.shTimeId = tShipmentTime.shTimeId AND tBuch.publisherId = tPublisher.publisherId;

/* 4 Bestandeswert der Bücher */
CREATE VIEW vBestandeswert AS
    SELECT count(tPrices.bestandespreis)
    FROM tPrices;

/* 5 Bestellungen die über der Lieferfrist sind */


/* 6 Bestände unter 5 von Büchern die in den letzten 30 Tagen mehr als einmal nachbestellt wurden */


/* 7 Alle Bücher eines bestimmten Autoren, die nur er alleine geschrieben hat */


/* 8 Alle Bücher eines Verlags, der nur Bücher von mehreren Autoren hat */

