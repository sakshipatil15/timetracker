ALTER TABLE `ticket_systems` ADD `ticketurl` VARCHAR(255) NOT NULL AFTER `private_key`;
ALTER TABLE `projects` ADD `additional_information_from_external` tinyint(1) NOT NULL AFTER `invoice`;
ALTER TABLE `projects` CHANGE `ticket_system` `ticket_system` INT(11) NULL DEFAULT NULL;

CREATE TABLE IF NOT EXISTS `users_ticket_systems` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` int(11) NOT NULL,
  `ticket_system_id` int(11) NOT NULL,
  `accesstoken` varchar(50) NOT NULL,
  `tokensecret` varchar(50) NOT NULL,
  `avoidconnection` TINYINT(1) unsigned DEFAULT '0' NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_user_id_idx` (`user_id`),
  KEY `fk_ticket_system_id_idx` (`ticket_system_id`),
  CONSTRAINT `fk_ticket_system_id` FOREIGN KEY (`ticket_system_id`) REFERENCES `ticket_systems` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

ALTER TABLE `users` CHANGE `abbr` `abbr` CHAR(3) CHARACTER SET utf8 COLLATE utf8_general_ci NULL DEFAULT NULL;

ALTER TABLE `ticket_systems` ADD `oauth_consumer_key` VARCHAR(100) NULL;
ALTER TABLE `ticket_systems` ADD `oauth_consumer_secret` VARCHAR(4000) NULL;


ALTER TABLE `teams_customers` DROP FOREIGN KEY `teams_customers_ifbk2`;
ALTER TABLE `teams_customers`
  ADD CONSTRAINT `teams_customers_ifbk2`
FOREIGN KEY (`customer_id`) REFERENCES `customers` (`id`) ON DELETE CASCADE;

ALTER TABLE `teams_users` DROP FOREIGN KEY `teams_users_ifbk2`;
ALTER TABLE `teams_users`
  ADD CONSTRAINT `teams_users_ifbk2`
FOREIGN KEY (`user_id`) REFERENCES `users` (`id`) ON DELETE CASCADE;


ALTER TABLE `entries` ADD `synced_to_ticketsystem` TINYINT(1) DEFAULT 0 NULL;
