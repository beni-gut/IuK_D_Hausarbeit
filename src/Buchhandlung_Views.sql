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

