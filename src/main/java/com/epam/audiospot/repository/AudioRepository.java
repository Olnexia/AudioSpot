package com.epam.audiospot.repository;

import com.epam.audiospot.builder.AudioBuilder;
import com.epam.audiospot.builder.Builder;
import com.epam.audiospot.connection.ConnectionWrapper;
import com.epam.audiospot.entity.AudioTrack;

import java.util.LinkedHashMap;
import java.util.Map;

public class AudioRepository extends AbstractRepository <AudioTrack> {
    private static final String TABLE_NAME = "audiotrack";

    public AudioRepository(ConnectionWrapper connection) {
        super(connection);
    }

    @Override
    public Builder <AudioTrack> getBuilder() {
        return new AudioBuilder();
    }

    @Override
    public String getTableName() {
        return TABLE_NAME;
    }

    @Override
    public Map <String, Object> getFields(AudioTrack track) {
        Map <String, Object> fields = new LinkedHashMap <>();
        fields.put(AudioTrack.AUTHOR_ID_LABEL, track.getArtist().getId());
        fields.put(AudioTrack.ALBUM_ID_LABEL, track.getAlbumId());
        fields.put(AudioTrack.TITLE_LABEL, track.getTitle());
        fields.put(AudioTrack.GENRE_LABEL, track.getGenre().getValue());
        fields.put(AudioTrack.PRICE_LABEL, track.getPrice());
        return fields;
    }
}
