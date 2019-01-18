package com.epam.audiospot.command.factory;

import com.epam.audiospot.command.*;
import com.epam.audiospot.command.admin.*;
import com.epam.audiospot.command.client.*;
import com.epam.audiospot.command.common.*;
import com.epam.audiospot.entity.Role;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

public enum CommandType {
    LOGIN("login", new LoginCommand()),
    REGISTER("register", new RegisterCommand()),
    HOME("home", new HomeCommand(),Role.ADMIN,Role.CLIENT),
    ADD_TRACK("addTrack",new AddTrackCommand(),Role.ADMIN),
    SUBMIT_TRACK("submitTrack",new SubmitTrackCommand(),Role.ADMIN),
    ADD_ALBUM("addAlbum",new AddAlbumCommand(),Role.ADMIN),
    SUBMIT_ALBUM("submitAlbum",new SubmitAlbumCommand(),Role.ADMIN),
    SHOW_ALBUMS("showAlbums",new ShowAlbumsCommand(),Role.ADMIN,Role.CLIENT),
    VIEW_ALBUM("viewAlbum",new ViewAlbumCommand(),Role.ADMIN,Role.CLIENT),
    ORDER_ALBUM("orderAlbum",new OrderAlbumCommand(),Role.CLIENT),
    SHOW_CLIENTS("showClients",new ShowClientsCommand(),Role.ADMIN),
    CHANGE_DISCOUNT("changeDiscount",new ChangeDiscountCommand(),Role.ADMIN),
    SHOW_COMMENTS("showComments",new ShowCommentsCommand(),Role.ADMIN,Role.CLIENT),
    CHANGE_CLIENT_STATUS("changeClientStatus",new ChangeClientStatusCommand(),Role.ADMIN),
    SHOW_PLAYLIST("showPlaylist",new ShowPlaylistCommand(),Role.CLIENT),
    SHOW_COMMENT("submitComment",new SubmitCommentCommand(),Role.ADMIN,Role.CLIENT),
    SHOW_TRACKS("showTracks",new ShowTracksCommand(),Role.ADMIN,Role.CLIENT),
    ORDER_TRACK("orderTrack",new OrderTrackCommand(),Role.CLIENT),
    DELETE_ORDER("cancelOrder",new CancelOrderCommand(),Role.ADMIN),
    PAY_ORDER("payOrder",new PayForOrderCommand(),Role.CLIENT),
    SUBMIT_PAYMENT("submitPayment",new SubmitPaymentCommand(),Role.CLIENT),
    SHOW_AUDIOSETS("showAudioSets",new ShowAudioSetsCommand(),Role.ADMIN,Role.CLIENT),
    ADD_AUDIOSET("addAudioSet",new AddAudioSetCommand(),Role.ADMIN),
    SUBMIT_AUDIOSET("submitAudioSet",new SubmitAudioSetCommand(),Role.ADMIN),
    VIEW_AUDIOSET("viewAudioSet",new ViewAudioSetCommand(),Role.ADMIN,Role.CLIENT),
    SELECT_TO_SET("addTracks",new SelectTracksToSetCommand(),Role.ADMIN),
    ADD_TO_SET("addToSet",new AddTrackToSetCommand(),Role.ADMIN),
    LOGOUT("logout",new LogoutCommand(),Role.ADMIN,Role.CLIENT);

    private Command command;
    private String commandText;
    private List<Role> permissions = new ArrayList <>();

    CommandType(String commandText, Command command, Role...permissions) {
        this.commandText = commandText;
        this.command = command;
        this.permissions.addAll(Arrays.asList(permissions));
    }

    public Command getCommand() {
        return command;
    }

    public String getText() {
        return commandText;
    }

    public boolean isAuthorized(Role role){
        return permissions.contains(role);
    }

    public static CommandType getCurrentCommand(String command) {
        for (CommandType commandType : CommandType.values()) {
            String commandText = commandType.getText();
            if (commandText.equals(command)) {
                return commandType;
            }
        }
        throw new IllegalArgumentException("An attempt to use illegal command ");
    }
}
