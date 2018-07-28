CREATE SCHEMA spotify_data;

CREATE TABLE spotify_data.artists (
  id UUID CONSTRAINT artists_pk PRIMARY KEY,
  name TEXT NOT NULL
);

CREATE TABLE spotify_data.songs (
  id UUID CONSTRAINT songs_pk PRIMARY KEY,
  spotify_url TEXT UNIQUE,
  track_name TEXT,
  artist_id UUID REFERENCES spotify_data.artists (id)
);

CREATE TABLE spotify_data.regions (
  id UUID CONSTRAINT regions_pk PRIMARY KEY,
  spotify_id TEXT UNIQUE,
  spotify_display_name TEXT
);

CREATE TABLE spotify_data.TOP_RANKING_CONTROL (
  date DATE,
  region_id UUID REFERENCES spotify_data.regions (id),
  CONSTRAINT top_ranking_control_pk PRIMARY KEY (date, region_id)
);

CREATE TABLE spotify_data.TOP_RANKING_POSITIONS (
  song_id UUID REFERENCES spotify_data.songs (id),
  date DATE,
  region_id UUID,
  position INTEGER,
  streams BIGINT,
  FOREIGN KEY (date, region_id) REFERENCES spotify_data.TOP_RANKING_CONTROL (date, region_id),
  CONSTRAINT top_ranking_positions_pk PRIMARY KEY (song_id, date, region_id, position)
);

