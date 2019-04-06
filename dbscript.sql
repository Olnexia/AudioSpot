-- -----------------------------------------------------
-- Schema audiospot
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `audiospot` DEFAULT CHARACTER SET utf8 ;
USE `audiospot` ;

-- -----------------------------------------------------
-- Table `audiospot`.`artist`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`artist` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NOT NULL,
  `country` VARCHAR(32) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 23
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`album`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`album` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(32) NOT NULL,
  `photo` VARCHAR(42) NULL DEFAULT NULL,
  `artist_id` INT(11) NOT NULL,
  `release_year` YEAR(4) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Album_Author1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_Album_Author1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `audiospot`.`artist` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 7
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`user`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`user` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `name` VARCHAR(32) NULL DEFAULT NULL,
  `surname` VARCHAR(32) NULL DEFAULT NULL,
  `login` VARCHAR(32) NOT NULL,
  `password` VARCHAR(32) NOT NULL,
  `role` ENUM('admin', 'client') NOT NULL,
  `discount` FLOAT NULL DEFAULT '0',
  `active` TINYINT(1) NULL DEFAULT '1',
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 13
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`audio_order`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`audio_order` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `user_id` INT(11) NOT NULL,
  `date` DATE NOT NULL,
  `paid` TINYINT(1) NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  INDEX `fk_Order_User_idx` (`user_id` ASC) VISIBLE,
  CONSTRAINT `fk_Order_User`
    FOREIGN KEY (`user_id`)
    REFERENCES `audiospot`.`user` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 62
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`audioset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`audioset` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(45) NOT NULL,
  `description` VARCHAR(200) NULL DEFAULT NULL,
  `photo` VARCHAR(42) NULL DEFAULT NULL,
  PRIMARY KEY (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 6
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`audiotrack`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`audiotrack` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `title` VARCHAR(42) NOT NULL,
  `path` VARCHAR(42) NOT NULL,
  `price` DECIMAL(6,2) NOT NULL,
  `album_id` INT(11) NULL DEFAULT NULL,
  `artist_id` INT(11) NOT NULL,
  `genre` ENUM('classic', 'pop', 'rap', 'rock') NULL DEFAULT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Audio Track_Album1_idx` (`album_id` ASC) VISIBLE,
  INDEX `fk_Audio Track_Author1_idx` (`artist_id` ASC) VISIBLE,
  CONSTRAINT `fk_Audio Track_Album1`
    FOREIGN KEY (`album_id`)
    REFERENCES `audiospot`.`album` (`id`),
  CONSTRAINT `fk_Audio Track_Author1`
    FOREIGN KEY (`artist_id`)
    REFERENCES `audiospot`.`artist` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 70
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`comment`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`comment` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `text` VARCHAR(100) NOT NULL,
  `date_time` DATETIME NOT NULL,
  `user_id` INT(11) NOT NULL,
  `audiotrack_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Comment_User1_idx` (`user_id` ASC) VISIBLE,
  INDEX `fk_comment_audiotrack1_idx` (`audiotrack_id` ASC) VISIBLE,
  CONSTRAINT `fk_Comment_User1`
    FOREIGN KEY (`user_id`)
    REFERENCES `audiospot`.`user` (`id`),
  CONSTRAINT `fk_comment_audiotrack1`
    FOREIGN KEY (`audiotrack_id`)
    REFERENCES `audiospot`.`audiotrack` (`id`))
ENGINE = InnoDB
AUTO_INCREMENT = 14
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`ordered_track`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`ordered_track` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `audio_order_id` INT(11) NOT NULL,
  `audiotrack_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Ordered Tracks_Audio Track1_idx` (`audiotrack_id` ASC) VISIBLE,
  INDEX `fk_Ordered Tracks_Order1` (`audio_order_id` ASC) VISIBLE,
  CONSTRAINT `fk_Ordered Tracks_Audio Track1`
    FOREIGN KEY (`audiotrack_id`)
    REFERENCES `audiospot`.`audiotrack` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_Ordered Tracks_Order1`
    FOREIGN KEY (`audio_order_id`)
    REFERENCES `audiospot`.`audio_order` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 198
DEFAULT CHARACTER SET = utf8;


-- -----------------------------------------------------
-- Table `audiospot`.`track_at_audioset`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `audiospot`.`track_at_audioset` (
  `id` INT(11) NOT NULL AUTO_INCREMENT,
  `audioset_id` INT(11) NOT NULL,
  `audiotrack_id` INT(11) NOT NULL,
  PRIMARY KEY (`id`),
  INDEX `fk_Audio at playlist_Playlist1_idx` (`audioset_id` ASC) VISIBLE,
  INDEX `fk_track_at_playlist_audiotrack1_idx` (`audiotrack_id` ASC) VISIBLE,
  CONSTRAINT `fk_Audio at audioset_Playlist1`
    FOREIGN KEY (`audioset_id`)
    REFERENCES `audiospot`.`audioset` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT `fk_track_at_audioset_audiotrack1`
    FOREIGN KEY (`audiotrack_id`)
    REFERENCES `audiospot`.`audiotrack` (`id`)
    ON DELETE CASCADE
    ON UPDATE CASCADE)
ENGINE = InnoDB
AUTO_INCREMENT = 28
DEFAULT CHARACTER SET = utf8;