-- Count of transactions amount 2 and less for each card holder
DROP VIEW IF EXISTS small_trans ;
CREATE VIEW small_trans AS (
	SELECT cc.cardholder_id, COUNT(*) AS trans_small_amount
	FROM transaction AS tr
	JOIN credit_card AS cc
	ON tr.card=cc.card
	WHERE tr.amount < MONEY('$2')
	GROUP BY cc.cardholder_id
	ORDER BY trans_small_amount DESC
	) ;

-- Top 100 transactions between 9 and 10 am
DROP VIEW IF EXISTS trans_btw_9_10 ;
CREATE VIEW trans_btw_9_10 AS (
	SELECT tr.* 
	FROM transaction AS tr 
	WHERE tr.date::time BETWEEN '9:00' AND '10:00'
	ORDER BY tr.amount DESC LIMIT 100
);
	
-- Top merchants getting small trans
DROP VIEW IF EXISTS merchants_small_trans ;
CREATE VIEW merchants_small_trans AS (
	SELECT tr.id_merchant, COUNT(*) AS small_trans
	FROM transaction AS tr
	WHERE tr.amount<MONEY('$2')
	GROUP BY tr.id_merchant
	ORDER BY small_trans DESC LIMIT 5
);
