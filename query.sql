USE world;
SELECT * FROM city AS ci, country AS co, countrylanguage AS cl WHERE ci.CountryCode=co.Code AND ci.CountryCode=cl.CountryCode;