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
<img width="803" height="337" alt="image" src="https://github.com/user-attachments/assets/909f08ac-551a-42e3-97ee-be5e46d76b4a" />

## Index Creation on the artist Column
- To optimize the query performance, we created an index on the artist column. This ensures faster retrieval of rows where the artist is queried.
- SQL command for creating the index:
  ```sql
CREATE INDEX idx_artist ON spotify_tracks(artist);
```

## Performance Analysis After Index Creation
- After creating the index, we ran the same query again and observed significant improvements in performance:
- Execution time (E.T.): **0.153 ms**
- Planning time (P.T.): **0.152 ms**
- Below is the **screenshot** of the `EXPLAIN` result after index creation:
<img width="877" height="479" alt="image" src="https://github.com/user-attachments/assets/c1e0b64d-3f42-4e29-b94f-89c57aa23512" />


