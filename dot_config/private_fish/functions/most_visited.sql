SELECT
    title,
    url
FROM
    moz_places
WHERE
    length(title) > 0
GROUP BY
    title
HAVING
    max(visit_count) >= 10
ORDER BY
    max(visit_count) DESC,
    max(last_visit_date) DESC
LIMIT
    100;