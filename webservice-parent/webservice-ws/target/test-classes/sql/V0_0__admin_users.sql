
/*!40101 SET NAMES utf8 */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40101 SET character_set_client = utf8 */;


CREATE TABLE jhi_authority (
  name varchar(50) NOT NULL,
  PRIMARY KEY (name)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO jhi_authority VALUES
    ('ROLE_ADMIN'),
    ('ROLE_USER');


CREATE TABLE jhi_persistent_audit_event (
  event_id bigint(20) NOT NULL AUTO_INCREMENT,
  principal varchar(255) NOT NULL,
  event_date timestamp NULL DEFAULT NULL,
  event_type varchar(255) DEFAULT NULL,
  PRIMARY KEY (event_id),
  ) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX idx_persistent_audit_event 
    ON jhi_persistent_audit_event(principal, event_date);


CREATE TABLE jhi_persistent_audit_evt_data (
  event_id bigint(20) NOT NULL,
  name varchar(255) NOT NULL,
  value varchar(255) DEFAULT NULL,
  PRIMARY KEY (event_id,name),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE INDEX idx_persistent_audit_evt_data
    ON jhi_persistent_audit_evt_data(event_id);


CREATE TABLE jhi_user (
  id bigint(20) NOT NULL AUTO_INCREMENT,
  login varchar(50) NOT NULL,
  password_hash varchar(60) DEFAULT NULL,
  first_name varchar(50) DEFAULT NULL,
  last_name varchar(50) DEFAULT NULL,
  email varchar(100) DEFAULT NULL,
  activated bit(1) NOT NULL,
  lang_key varchar(5) DEFAULT NULL,
  activation_key varchar(20) DEFAULT NULL,
  reset_key varchar(20) DEFAULT NULL,
  created_by varchar(50) NOT NULL,
  created_date timestamp NOT NULL,
  reset_date timestamp NULL DEFAULT NULL,
  last_modified_by varchar(50) DEFAULT NULL,
  last_modified_date timestamp NULL DEFAULT NULL,
  PRIMARY KEY (id),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;
CREATE UNIQUE INDEX idx_user_email
    ON jhi_user(email);
CREATE UNIQUE INDEX idx_user_login
    ON jhi_user(login);


INSERT INTO jhi_user VALUES
    (1,'system','$2a$10$mE.qmcV0mFU5NcKh73TZx.z4ueI/.bDWbj0T1BYyqP481kGGarKLG','System','System','system@localhost',1,'fr',NULL,NULL,'system','2016-05-30 08:51:26',NULL,NULL,NULL),
    (2,'anonymoususer','$2a$10$j8S5d7Sr7.8VTOYNviDPOeWX8KcYILUVJBsYV83Y5NtECayypx9lO','Anonymous','User','anonymous@localhost',1,'fr',NULL,NULL,'system','2016-05-30 08:51:26',NULL,NULL,NULL),
    (3,'admin','$2a$10$gSAhZrxMllrbgj/kkK9UceBPpChGWJA7SYIb1Mqo.n5aNLq1/oRrC','Administrator','Administrator','admin@localhost',1,'fr',NULL,NULL,'system','2016-05-30 08:51:26',NULL,NULL,NULL),
    (4,'user','$2a$10$VEjxo0jq2YG9Rbk2HmX9S.k1uZBGYUHdUcid3g/vfiEl7lwWgOH/K','User','User','user@localhost',1,'fr',NULL,NULL,'system','2016-05-30 08:51:26',NULL,NULL,NULL);


CREATE TABLE jhi_user_authority (
  user_id bigint(20) NOT NULL,
  authority_name varchar(50) NOT NULL,
  PRIMARY KEY (user_id,authority_name),
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

INSERT INTO jhi_user_authority VALUES
    (1,'ROLE_ADMIN'),
    (3,'ROLE_ADMIN'),
    (1,'ROLE_USER'),
    (3,'ROLE_USER'),
    (4,'ROLE_USER');


ALTER TABLE jhi_user_authority
    ADD CONSTRAINT fk_authority_name FOREIGN KEY (authority_name) REFERENCES jhi_authority(name);

ALTER TABLE jhi_persistent_audit_evt_data
    ADD CONSTRAINT fk_evt_pers_audit_evt_data FOREIGN KEY (event_id) REFERENCES jhi_persistent_audit_event(event_id);

ALTER TABLE jhi_user_authority
    ADD CONSTRAINT fk_user_id FOREIGN KEY (user_id) REFERENCES jhi_user(id);
