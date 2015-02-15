-- CS 5320
-- Homework 1

-- Alex Nagle, arn43
-- Chris (Zhou) Zeng, zz397

-- (1a) Find all stores that sell items in exactly three different colors 
-- and return their storeids.

SELECT L.storeid 
	FROM Item I, Sells L  
	WHERE I.iid = L.iid
	GROUP BY L.storeid
	HAVING COUNT(DISTINCT I.color) = 3;
	
-- (1b) Find all pairs of stores which sell NO items in common, but where each store in 
-- the pair sells at least one item. That is, the set of items sold at the first store 
-- and the set of items sold at the second store are nonempty but disjoint. For every 
-- such pair, output their storeids. Note that each pair of stores should appear only 
-- once in the result, so if (1, 3) is in the result (3, 1) should not be.

SELECT DISTINCT L2.storeid AS storeid1, L.storeid AS storeid2
FROM Sells L, Sells L2
WHERE L.storeid > L2.storeid
AND (L.storeid, L2.storeid) NOT IN(
	SELECT DISTINCT LL.storeid, LL2.storeid
	FROM Sells LL, Sells LL2
	WHERE LL.storeid <> LL2.storeid
	AND LL.iid = LL2.iid
	AND LL.storeid > LL2.storeid
	)
AND L.storeid IN(
	SELECT SI.storeid
	FROM(
	SELECT storeid, Count(iid) AS ItemCount
	FROM Sells
	GROUP BY storeid
	) AS SI
	WHERE SI.ItemCount >= 1
	)
AND L2.storeid IN(
	SELECT SI2.storeid
	FROM(
	SELECT storeid, Count(iid) AS ItemCount2
	FROM Sells
	GROUP BY storeid
	) AS SI2
	WHERE SI2.ItemCount2 >= 1
	);
	
-- (1c) For every item that is sold at at least one store, show the item id,
-- the store id of the store selling that item at the cheapest price, and the price for
-- that item at that store. If multiple stores sell the item at the same cheapest price,
-- return multiple tuples as appropriate.

SELECT *
FROM Sells L
WHERE (L.iid, L.price) IN(
	SELECT iid, min(price)
	FROM Sells
	GROUP BY iid)
AND L.storeid IN(	
	SELECT S.storeid
	FROM(
	SELECT storeid, COUNT(iid) AS ItemCount
	FROM Sells
	GROUP BY storeid) AS S
	WHERE S.ItemCount >= 1);

-- (1d) Find the store (or stores) that sell the second largest number of items and display
-- their storeids. For example, if no store sells more than 100 items,
-- stores 11, 12 and 13 sell 100 items each, and stores 17 and 19 each sell 98 items,
-- you should output 17 and 19. You may assume that the largest number of items sold by
-- a store and the second largest number are both nonzero.

SELECT StoreItemCount.storeid
FROM(
SELECT storeid, COUNT(iid) as ItemCount
FROM Sells
GROUP BY storeid) AS StoreItemCount
WHERE StoreItemCount.ItemCount = (
SELECT max(StoreItemCount.ItemCount)
FROM(
SELECT storeid, COUNT(iid) as ItemCount
FROM Sells
GROUP BY storeid) AS StoreItemCount
WHERE StoreItemCount.ItemCount < (SELECT max(StoreItemCount2.ItemCount2)
FROM(
SELECT storeid, COUNT(iid) as ItemCount2
FROM Sells
GROUP BY storeid) AS StoreItemCount2)
);

-- (2a) Express the no-overlap constraint using a CHECK clause. That is, give a new 
-- CREATE TABLE statement for BoatRes containing a CHECK clause that would enforce the 
-- no-overlap constraint. Note that you will not actually be able to run and test it, as 
-- neither MySQL nor PostgreSQL allows nested subqueries in the CHECK clause. However, 
-- your answer will still be legal SQL as per the SQL-92 standard.

CREATE TABLE BoatRes (resnum INTEGER PRIMARY KEY,
	sid INTEGER, 
	bid INTEGER, 
	startdate DATE NOT NULL, 
	enddate DATE NOT NULL,
	CHECK (
		NOT EXISTS (
			SELECT BR1.bid
			FROM BoatRes AS BR1
			WHERE (
				(bid=BR1.bid)
				AND (
					(startdate BETWEEN BR1.startdate AND BR1.enddate)
					OR (enddate BETWEEN BR1.startdate AND BR1.enddate)
					OR (enddate >= BR1.enddate AND startdate<=BR1.startdate)
				)
			)
		)
	);
	
-- (8 points) Given that your answer to part (a) cannot be used in practice, figure out 
-- an alternate way to enforce the no-overlap constraint in PostgreSQL, using triggers. 
-- Provide a list of statements that we can paste into the console. We will grade by 
-- 1) creating BoatRes using the CREATE statement above, 2) copying and pasting your 
-- provided code into the console, and then 3) attempting to make various changes to 
-- BoatRes. Changes that violate the overlap constraint should be rejected but all 
-- changes that do not should be accepted.

CREATE OR REPLACE FUNCTION checkoverlap() RETURNS TRIGGER AS $example_table$
    BEGIN
	IF EXISTS(
	SELECT BR1.bid
	FROM BoatRes AS BR1
	WHERE(
	(new.bid=BR1.bid) 
	AND(
	(new.startdate BETWEEN BR1.startdate AND BR1.enddate)
	OR (new.enddate BETWEEN BR1.startdate AND BR1.enddate)
	OR (new.enddate >= BR1.enddate AND new.startdate<=BR1.startdate))))
	THEN
	RAISE EXCEPTION 'New booking cannot have overlapping date'; END IF;
	RETURN NEW;
	END;
$example_table$ LANGUAGE plpgsql;

CREATE TRIGGER example_trigger BEFORE INSERT ON BoatRes
FOR EACH ROW EXECUTE PROCEDURE checkoverlap();