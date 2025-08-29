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
)
select * from spotify


select count(*) from spotify --20594

--How many artists does we have

select count(distinct(Artist)) from spotify --2074

-- How many albumswe have --11854
select count(distinct(Album)) from spotify

--different typesof album_types ( we have album, compilation and single)
select distinct(album_type) from spotify

--max and min duration of songs (77.9343,0)
select max(Duration_min),
min(Duration_min)
from spotify

-- any songs cannot have 0 min as suration so
select * from spotify
where Duration_min =0;
-- we get 2 records where album "Unwritten","Soothing Rain for Background Sounds and Natural White Noise",
--we have recorde like comments ,likes for "Unwritten" but no records for "Soothing Rain for Background Sounds and Natural White Noise"
-- so we delete records of these two

delete from spotify 
where Duration_min =0
-- this deletes those 2 records
-- then the total count will be reduced to 20592 from 20594

-- how many channels do we have --(6673 different channels we have)
select distinct(channel) from spotify

-- different most played on platforms (youtube and spotify)
select distinct(most_played_on) from spotify
```
## Project Steps
**Data Exploration**
Before diving into SQL, it’s important to understand the dataset thoroughly. The dataset contains attributes such as:
Artist: The performer of the track.
Track: The name of the song.
Album: The album to which the track belongs.
Album_type: The type of album (e.g., single or album).
Various metrics such as danceability, energy, loudness, tempo, and more.
After the data is inserted, various SQL queries can be written to explore and analyze the data.


