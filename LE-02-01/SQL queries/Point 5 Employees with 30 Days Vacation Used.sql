# By changing the number of days (the value for urlaubgenommen),
# you can display employees with different amounts of vacation days taken.
SELECT name, vorname, urlaubgenommen
FROM mitarbeiter
WHERE urlaubgenommen='30';