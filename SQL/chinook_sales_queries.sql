##KPI Count Queries:
SELECT
    (SELECT SUM(Total) FROM Invoice) AS TotalRevenue,
    (SELECT COUNT(ArtistId) FROM Artist) AS TotalArtists,
    (SELECT COUNT(AlbumId) FROM Album) AS TotalAlbums,
    (SELECT COUNT(GenreId) FROM Genre) AS TotalGenres,
    (SELECT COUNT(TrackId) FROM Track) AS TotalTracks;

##sales trend by year:
SELECT
    YEAR(InvoiceDate) AS SalesYear,
    SUM(Total) AS AnnualRevenue
FROM
    Invoice
GROUP BY
    SalesYear
ORDER BY
    SalesYear;

##Highest Spending Countries
SELECT
    BillingCountry AS Country,
    SUM(Total) AS TotalRevenue
FROM
    Invoice
GROUP BY
    Country
ORDER BY
    TotalRevenue DESC;

##Top 5 Sales by Artists
SELECT
    ar.Name AS ArtistName,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM
    Artist ar
JOIN
    Album al ON ar.ArtistId = al.ArtistId
JOIN
    Track t ON al.AlbumId = t.AlbumId
JOIN
    InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY
    ar.ArtistId, ar.Name
ORDER BY
    TotalSales DESC
LIMIT 5;

##Top 5 Selling Genres:
SELECT
    g.Name AS GenreName,
    SUM(il.UnitPrice * il.Quantity) AS TotalSales
FROM
    Genre g
JOIN
    Track t ON g.GenreId = t.GenreId
JOIN
    InvoiceLine il ON t.TrackId = il.TrackId
GROUP BY
    g.GenreId, g.Name
ORDER BY
    TotalSales DESC
LIMIT 5;