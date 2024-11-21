-- Create WordPress tables if not exists
CREATE TABLE IF NOT EXISTS `wp_users` (
  `ID` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `user_login` varchar(60) NOT NULL DEFAULT '',
  `user_pass` varchar(255) NOT NULL DEFAULT '',
  `user_email` varchar(100) NOT NULL DEFAULT '',
  `user_registered` datetime NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `display_name` varchar(250) NOT NULL DEFAULT '',
  PRIMARY KEY (`ID`),
  KEY `user_login_key` (`user_login`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

CREATE TABLE IF NOT EXISTS `wp_options` (
  `option_id` bigint(20) UNSIGNED NOT NULL AUTO_INCREMENT,
  `option_name` varchar(191) NOT NULL DEFAULT '',
  `option_value` longtext NOT NULL,
  `autoload` varchar(20) NOT NULL DEFAULT 'yes',
  PRIMARY KEY (`option_id`),
  UNIQUE KEY `option_name` (`option_name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Insert minimum required data
INSERT INTO `wp_options` (`option_name`, `option_value`, `autoload`) VALUES
('siteurl', 'https://ykawakit.42.fr', 'yes'),
('home', 'https://ykawakit.42.fr', 'yes'),
('blogname', 'Inception', 'yes'),
('blogdescription', 'Just another WordPress site', 'yes'),
('admin_email', 'test@test.com', 'yes'),
('default_role', 'subscriber', 'yes'),
('WPLANG', 'ja', 'yes');

-- Insert two users: one superuser and one regular user
INSERT INTO `wp_users` (`user_login`, `user_pass`, `user_email`, `display_name`) VALUES
('superuser', MD5('superuser_password'), 'test@test.com', 'Super User'),
('regular_user', MD5('user_password'), 'user@test.com', 'Regular User');
