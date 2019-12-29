/* 1 Kaufinformationen Titel, Autor, Sprache, Preis */
CREATE VIEW vKaufinfos AS
    SELECT tInfo.titel, tAuthor.authorName || ', ' || tAuthor.authorVorname AS Autor, tLanguage.sprache, tPrices.verkaufspreis AS Preis
    FROM tInfo, tAuthor, tLanguage, tPrices, tMappingBuchAuthor, tBuch
    WHERE tMappingBuchAuthor.authorId = tAuthor.authorId
      AND tMappingBuchAuthor.buchId = tBuch.buchId
      AND tBuch.infoId = tInfo.infoId AND tBuch.langId = tLanguage.langId
      AND tBuch.priceId = tPrices.priceId;

/* 2 Telefon Bestellinfos ISBN, Verfügbarkeit, Lieferfrist, Verlag, Ansprechpartner, Telefonnummer */
CREATE VIEW vTelefonBestellinfos AS
    SELECT tInfo.isbn, tAvailability.verfuegbarkeit, tShipmentTime.lieferfrist, tPublisher.verlagsBezeichnung, tPublisher.nameKontaktPers || ', ' || tPublisher.vornameKontaktPers AS KontaktPerson, tPublisher.telefonnummer
    FROM tInfo, tAvailability, tShipmentTime, tPublisher, tBuch
    WHERE tBuch.infoId = tInfo.infoId
      AND tBuch.availableId = tAvailability.availableId
      AND tBuch.shTimeId = tShipmentTime.shTimeId
      AND tBuch.publisherId = tPublisher.publisherId;

/* 3 E-Mail Bestellinfos ISBN, Verfügbarkeit, Lieferfrist, Verlag, Ansprechpartner, Mailadresse */
CREATE VIEW vMailBestellinfos AS
    SELECT tInfo.isbn, tAvailability.verfuegbarkeit, tShipmentTime.lieferfrist, tPublisher.verlagsBezeichnung, tPublisher.nameKontaktPers || ', ' || tPublisher.vornameKontaktPers AS KontaktPerson, tPublisher.mailadresse
    FROM tInfo, tAvailability, tShipmentTime, tPublisher, tBuch
    WHERE tBuch.infoId = tInfo.infoId
      AND tBuch.availableId = tAvailability.availableId
      AND tBuch.shTimeId = tShipmentTime.shTimeId
      AND tBuch.publisherId = tPublisher.publisherId;

/* 4 Bestandeswert der Bücher */
CREATE VIEW vBestandeswert AS
    SELECT tInfo.titel AS Buchtitel, (tInventory.storeAnz + tInventory.storageAnz) AS Bestandesmenge, (tInventory.storeAnz + tInventory.storageAnz) * tPrices.bestandespreis AS Bestandeswert
    FROM tInfo, tInventory, tPrices, tBuch
    WHERE tBuch.infoId = tInfo.infoId
      AND tBuch.placeId = tInventory.placeId
      AND tBuch.priceId = tPrices.priceId;

/* 5 Bestellungen die über der Lieferfrist sind */
CREATE VIEW vLieferfristUeberschritten AS
    SELECT tInfo.titel, tBestellungen.bestellMenge, tBestellungen.bestellDatum, tShipmentTime.lieferfrist, current_date - (tBestellungen.bestellDatum + tShipmentTime.lieferfrist) AS anzahlUeberschritteneTage
    FROM tInfo, tBestellungen, tShipmentTime, tBuch
    WHERE tBuch.infoId = tInfo.infoId
      AND tBestellungen.buchId = tBuch.buchId
      AND tBuch.shTimeId = tShipmentTime.shTimeId
      AND tBestellungen.bestellDatum + tShipmentTime.lieferfrist < current_date;

/* 6 Bestände unter 5 von Büchern die in den letzten 30 Tagen mehr als einmal nachbestellt wurden */
CREATE VIEW vWenigBestandOftBestellt AS
    SELECT tInfo.titel, tBestellungen.bestellMenge, tBestellungen.bestellDatum, (tInventory.storeAnz + tInventory.storageAnz) AS Bestandesmenge
    FROM tInfo, tBestellungen, tInventory, tBuch
    WHERE tBuch.infoId = tInfo.infoId
      AND tBestellungen.buchId = tBuch.buchId
      AND tBuch.placeId = tInventory.placeId
      AND tBestellungen.bestellDatum + INTERVAL '30' DAY > current_date 
      AND tBestellungen.bestellDatum < current_date
      AND (tInventory.storeAnz + tInventory.storageAnz) < 5;

/* 7 Alle Bücher eines bestimmten Autoren, die nur er alleine geschrieben hat */
CREATE VIEW vZwischenschrittEA1 AS
	SELECT buchId, count(buchId) 
	FROM tMappingBuchAuthor
	GROUP BY buchId;

CREATE VIEW vZwischenschrittEA2 AS
	SELECT buchId
	FROM vZwischenschrittEA1
	WHERE (vZwischenschrittEA1.count = 1);

CREATE VIEW vEinzelAutor AS 
	SELECT tInfo.titel, tLanguage.sprache, tAuthor.authorName || ', ' || tAuthor.authorVorname AS Autor 
	FROM tInfo, tBuch, vZwischenschrittEA2, tAuthor, tMappingBuchAuthor, tLanguage
	WHERE tBuch.infoId = tInfo.infoId
	  AND tBuch.langId = tLanguage.langId
	  AND tBuch.buchId = vZwischenschrittEA2.buchId
	  AND tMappingBuchAuthor.buchId = tBuch.buchId
	  AND tMappingBuchAuthor.authorId = tAuthor.authorId;

/* 8 Alle Bücher eines Verlags, der nur Bücher von mehreren Autoren hat */

