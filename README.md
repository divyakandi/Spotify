# Spotify
![Spotify_Logo](https://github.com/divyakandi/Spotify/blob/main/spotify_logo.jpg)
## Overview
This project involves analyzing a Spotify dataset with various attributes about tracks, albums, and artists using SQL. It covers an end-to-end process of normalizing a denormalized dataset, performing SQL queries of varying complexity (easy, medium, and advanced), and optimizing query performance. The primary goals of the project are to practice advanced SQL skills and generate valuable insights from the dataset.
```sql
create table spotify(
Artist varchar(255),
Track varchar(255),
Album varchar(255),
Album_type varchar(50),
Danceability float,
Energy float,
Loudness float,
Speechiness float,
Acousticness float,
Instrumentalness float,
Liveness float,
Valence float,
Tempo float,
Duration_min float,
Title varchar(255),
Channel varchar(255),
Views float,
Likes bigint,
Comments bigint,
Licensed boolean,
official_video	boolean,
Stream	bigint,
Energy_Liveness float,
most_played_on varchar(50)
);
```

## Data Exploration
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
- Artist: The performer of the track.
- Track: The name of the song.
- Album: The album to which the track belongs.
- Album_type: The type of album (e.g., single or album).
- Various metrics such as danceability, energy, loudness, tempo, and more.

After the data is inserted, various SQL queries can be written to explore and analyze the data.

## Query Optimization
- Indexing: Adding indexes on frequently queried columns.
- Query Execution Plan: Using EXPLAIN ANALYZE to review and refine query performance.
## Query Optimization Technique
To improve query performance, we carried out the following optimization process:
- Initial Query Performance Analysis Using EXPLAIN
- We began by analyzing the performance of a query using the EXPLAIN function.
- The query retrieved tracks based on the artist column, and the performance metrics were as follows:
- Execution time (E.T.): 6.421 ms
- Planning time (P.T.): 0.110 ms
![EXPLAIN Before Index](https://github.com/divyakandi/Spotify/blob/main/spotify_explain_before_index.png)

## Index Creation on the artist Column
- To optimize the query performance, we created an index on the artist column. This ensures faster retrieval of rows where the artist is queried.
- SQL command for creating the index:

```sql
CREATE INDEX idx_artist ON spotify_tracks(artist);
```
![EXPLAIN After Index](https://github.com/divyakandi/Spotify/blob/main/spotify_explain_after_index.png)

## Performance Analysis After Index Creation
- After creating the index, we ran the same query again and observed significant improvements in performance:
- Execution time (E.T.): **0.153 ms**
- Planning time (P.T.): **0.152 ms**
## Graphical Performance Comparison
- A graph illustrating the comparison between the initial query execution time and the optimized query execution time after index creation.
- Graph view shows the significant drop in both execution and planning times:
  ![Performance Graph](https://github.com/divyakandi/Spotify/blob/main/spotify_graphical%20view%201.png)
  ![Performance Graph](https://github.com/divyakandi/Spotify/blob/main/spotify_graphical%20view%202.png)
  ![Performance Graph](https://github.com/divyakandi/Spotify/blob/main/spotify_graphical%20view%203.png)
This optimization shows how indexing can drastically reduce query time, improving the overall performance of our database operations in the Spotify project.

## Bussiness Questions
### 1. Retrieve the names of all tracks that have more than 1 billion streams.
```sql
select album, stream from spotify
where stream > 1000000000;
```
-- we get 385 records
### 2.
