/* 1 Kaufinformationen Titel, Autor, Sprache, Preis */
CREATE VIEW vKaufinfos AS
    SELECT tInfo.titel AS Titel, tAuthor.authorName || ', ' || tAuthor.authorVorname AS Autor, tLanguage.sprache AS Sprache, tPrices.verkaufspreis AS Preis
    FROM tInfo, tAuthor, tLanguage, tPrices, tMappingBuchAuthor, tBuch
    WHERE tMappingBuchAuthor.authorId = tAuthor.authorId AND tMappingBuchAuthor.buchId = tBuch.buchId AND tBuch.infoId = tInfo.infoId AND tBuch.langId = tLanguage.langId AND tBuch.priceId = tPrices.priceId;

/* 2 Telefon Bestellinfos ISBN, Verfügbarkeit, Lieferfrist, Verlag, Ansprechpartner, Telefonnummer */
CREATE VIEW vTelefonBestellinfos AS
    SELECT tInfo.isbn, tAvailability.verfuegbarkeit, tShipmentTime.lieferfrist, tPublisher.verlagsBezeichnung, tPublisher.nameKontaktPers || ', ' || tPublisher.vornameKontaktPers AS KontaktPerson, tPublisher.telefonnummer
    FROM tInfo, tAvailability, tShipmentTime, tPublisher, tBuch
    WHERE tBuch.infoId = tInfo.infoId AND tBuch.availableId = tAvailability.availableId AND tBuch.shTimeId = tShipmentTime.shTimeId AND tBuch.publisherId = tPublisher.publisherId;

/* 3 E-Mail Bestellinfos ISBN, Verfügbarkeit, Lieferfrist, Verlag, Ansprechpartner, Mailadresse */
CREATE VIEW vMailBestellinfos AS
SELECT tInfo.isbn, tAvailability.verfuegbarkeit, tShipmentTime.lieferfrist, tPublisher.verlagsBezeichnung, tPublisher.nameKontaktPers || ', ' || tPublisher.vornameKontaktPers AS KontaktPerson, tPublisher.mailadresse
FROM tInfo, tAvailability, tShipmentTime, tPublisher, tBuch
WHERE tBuch.infoId = tInfo.infoId AND tBuch.availableId = tAvailability.availableId AND tBuch.shTimeId = tShipmentTime.shTimeId AND tBuch.publisherId = tPublisher.publisherId;

/* 4 Bestandeswert der Bücher */
CREATE VIEW vBestandeswert AS
    SELECT tInfo.titel AS Buchtitel, (tInventory.storeAnz + tInventory.storageAnz) AS Bestandesmenge, (tInventory.storeAnz + tInventory.storageAnz) * tPrices.bestandespreis AS Bestandeswert
    FROM tInfo, tInventory, tPrices, tBuch
    WHERE tBuch.infoId = tInfo.infoId AND tBuch.placeId = tInventory.placeId AND tBuch.priceId = tPrices.priceId;

/* 5 Bestellungen die über der Lieferfrist sind */


/* 6 Bestände unter 5 von Büchern die in den letzten 30 Tagen mehr als einmal nachbestellt wurden */


/* 7 Alle Bücher eines bestimmten Autoren, die nur er alleine geschrieben hat */


/* 8 Alle Bücher eines Verlags, der nur Bücher von mehreren Autoren hat */

