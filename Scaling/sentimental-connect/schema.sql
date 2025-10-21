CREATE TABLE `users`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `first_name` VARCHAR(20) NOT NULL,
    `last_name` VARCHAR(20) NOT NULL,
    `username` VARCHAR(20) NOT NULL UNIQUE,
    `password` TEXT NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `school_uni`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `type` ENUM('Primary', 'Secondary', 'Higher Education') NOT NULL,
    `location` TEXT NOT NULL,
    `year_founded` YEAR NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `companies`(
    `id` INT UNSIGNED AUTO_INCREMENT,
    `indusrty` ENUM('Technology', 'Education', 'Business') NOT NULL,
    `location` NOT NULL,
    PRIMARY KEY (`id`)
);

CREATE TABLE `connections`(
    `id` BIGINT USINGED AUTO_INCREMENT,
    `user_id` INT UNSIGNED NOT NULL,
    `user_connection_id` INT USINGED,
    `id_school` INT UNSIGNED,
    `start_school` DATE,
    `end_school` DATE,
    `degree_school` ENUM('BA', 'BE', 'PhD'),
    `id_company` INT UNSIGNED,
    `satrt_company` DATE,
    `end_company` DATE,
    PRIMARY KEY (`id`),
    FOREIGN KEY (`user_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`user_connect_id`) REFERENCES `users`(`id`),
    FOREIGN KEY (`id_school`) REFERENCES `school_uni`(`id`),
    FOREIGN KEY (`id_company`) REFERENCES `companies`(`id`)
);
