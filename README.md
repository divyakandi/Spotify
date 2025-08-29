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
### 2.List all albums along with their respective artists.
```sql
select distinct
album,artist from spotify
order by 1;
```
--we get 14178 record
### 3. Get the total number of comments for tracks where licensed = TRUE.
```sql
select sum(comments) as total_comments
from spotify
where licensed = 'True';
```
### 4. Find all tracks that belong to the album type single.
```sql
select * from spotify 
where album_type ='single';
```
### 5.Count the total number of tracks by each artist.
```sql
select artist,
count(*) as total_number_of_tracks
from spotify
group by 1
order by count(*)
```
### 6. Calculate the average danceability of tracks in each album.
```sql
select album,
avg(danceability) as avg_danceability
from spotify
group by 1
order by 2 desc;
```
### 7. Find the top 5 tracks with the highest energy values.
```sql
select track,
max(energy)
from spotify
group by 1
order by 2 desc
limit 5;
```
### 8. List all tracks along with their views and likes where official_video = TRUE.
```sql
select track,
sum(views) as total_views,
sum(likes) as total_likes
from spotify
where official_video = 'true'
group by 1
order by 2 desc;
```
### 9. For each album, calculate the total views of all associated tracks.
```sql
select 
album,
track,
sum(views) as total_views
from spotify
group by 1,2
order by 3 desc;
```
### 10. Retrieve the track names that have been streamed on Spotify more than YouTube.
```sql
select * from 
(select
track,
coalesce(sum(case when most_played_on = 'Youtube' then stream  end),0) as streamed_on_youtube,
coalesce(sum(case when most_played_on = 'Spotify' then stream  end),0) as streamed_on_spotify
from spotify
group by 1)
as t1 
where
streamed_on_spotify > streamed_on_youtube and 
streamed_on_youtube !=0;
```
### 11. Find the top 3 most-viewed tracks for each artist using window functions.
```sql
with ranking_artist as
(
select 
artist,
track,
sum(views) as total_views,
dense_rank() over(partition by artist order by sum(views) ) as rank
from spotify
group by 1,2
order by 1, 3 desc
) 
select * from ranking_artist
where rank <= 3;
```
### 12. Write a query to find tracks where the liveness score is above the average.
```sql
select track,
liveness
from spotify
where 
liveness > (select avg(liveness)
from spotify
);
```
### 13. Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
```sql
with cte_1 as(
select album,
max(energy) as highest_energy_value,
min(energy) as lowest_energy_value
from spotify
group by 1)
select album,
highest_energy_value - lowest_energy_value as energy_diff
from
cte_1
order by 2 desc;
```
### 14.Find tracks where the energy-to-liveness ratio is greater than 1.2
```sql
with cte_1 as
(
select
track,
energy,
liveness,
(energy/liveness) as enery_to_liveness_ratio
from spotify)
select * from cte_1
where 
enery_to_liveness_ratio >1.2
;
```
