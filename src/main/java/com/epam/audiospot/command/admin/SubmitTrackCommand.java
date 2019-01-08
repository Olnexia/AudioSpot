package com.epam.audiospot.command.admin;

import com.epam.audiospot.command.Command;
import com.epam.audiospot.command.CommandResult;
import com.epam.audiospot.command.Forward;
import com.epam.audiospot.command.Redirect;
import com.epam.audiospot.entity.AudioTrack;
import com.epam.audiospot.entity.Genre;
import com.epam.audiospot.exception.ServiceException;
import com.epam.audiospot.service.AudioTrackService;
import org.apache.logging.log4j.LogManager;
import org.apache.logging.log4j.Logger;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.math.BigDecimal;
import java.util.Optional;

public class SubmitTrackCommand implements Command {
    private static final String ARTIST_LABEL = "artist";
    private static final Logger logger = LogManager.getLogger(SubmitTrackCommand.class);

    @Override
    public CommandResult execute(HttpServletRequest request, HttpServletResponse response){
        String title = request.getParameter(AudioTrack.TITLE_LABEL);
        BigDecimal price = new BigDecimal(request.getParameter(AudioTrack.PRICE_LABEL));
        Genre genre = Genre.valueOf(request.getParameter(AudioTrack.GENRE_LABEL).toUpperCase());
        String artistName = request.getParameter(ARTIST_LABEL);
        String albumId = request.getParameter("albumId");

        AudioTrackService service = new AudioTrackService();
        CommandResult commandResult;
        try{
            AudioTrack track = service.buildTrack(title,price,genre,artistName,albumId);
            service.submitTrack(track);
            logger.info("New track with id "+track.getId()+" added.");
            if(albumId==null){
                commandResult = CommandResult.redirect(Redirect.ADD_TRACK.getPath());
            }else{
                commandResult = CommandResult.redirect(Redirect.VIEW_ALBUM.getPath()+"&albumId="+albumId);
            }
        }catch (ServiceException e){
            logger.error("An error occurred while adding track: ",e);
            commandResult = CommandResult.forward(Forward.ADD_TRACK.getPath()); //also set some text message?
        }

        //TODO here need some message for success

        return commandResult;
    }
}
