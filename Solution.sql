---Bussiness questions
--Retrieve the names of all tracks that have more than 1 billion streams.
select album, stream from spotify
where stream > 1000000000
-- we get 385 records

--List all albums along with their respective artists.
select distinct
album,artist from spotify
order by 1
-- we get 14178 record

--Get the total number of comments for tracks where licensed = TRUE.
--497015695
select sum(comments) as total_comments
from spotify
where licensed = 'True'

--Find all tracks that belong to the album type single.
--4973 records
select * from spotify 
where album_type ='single'

--Count the total number of tracks by each artist.
--2074 records
select artist,
count(*) as total_number_of_tracks
from spotify
group by 1
order by count(*)

--Calculate the average danceability of tracks in each album.
--"FOR CERTAIN (Deluxe)","Funky Friday" these 2 albums have avg_danceability of 0.975 as top
select album,
avg(danceability) as avg_danceability
from spotify
group by 1
order by 2 desc

--Find the top 5 tracks with the highest energy values.
--"Rain and Thunderstorm, Pt. 7",
--"Rain and Thunderstorm, Pt. 33",
--"Rain and Thunderstorm, Pt. 4",
--"Rain and Thunderstorm, Pt. 6",
--"Gentle Piano Melodies" all these 5 have highest energy values
select track,
max(energy)
from spotify
group by 1
order by 2 desc
limit 5

--List all tracks along with their views and likes where official_video = TRUE.
--13650 records
select track,
sum(views) as total_views,
sum(likes) as total_likes
from spotify
where official_video = 'true'
group by 1
order by 2 desc

--For each album, calculate the total views of all associated tracks.
--18580 records
select 
album,
track,
sum(views) as total_views
from spotify
group by 1,2
order by 3 desc

--Retrieve the track names that have been streamed on Spotify more than YouTube.
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
streamed_on_youtube !=0

--Find the top 3 most-viewed tracks for each artist using window functions.
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
where rank <= 3

--Write a query to find tracks where the liveness score is above the average.
select track,
liveness
from spotify
where 
liveness > (select avg(liveness)
from spotify
)

--Use a WITH clause to calculate the difference between the highest and lowest energy values for tracks in each album.
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
order by 2 desc

--Find tracks where the energy-to-liveness ratio is greater than 1.2
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












