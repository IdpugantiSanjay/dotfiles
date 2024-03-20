SELECT
    p.title,
    p.url
FROM
    moz_bookmarks b
    INNER JOIN moz_places p ON b.fk = p.id
WHERE
    b.parent = 149 -- terminal bookmarks folder