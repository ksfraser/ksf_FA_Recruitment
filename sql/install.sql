-- Recruitment module database schema for FrontAccounting

-- Job openings
CREATE TABLE IF NOT EXISTS `fa_job_openings` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `department` VARCHAR(100) DEFAULT NULL,
    `location` VARCHAR(255) DEFAULT NULL,
    `type` ENUM('Full-time','Part-time','Contract','Intern') NOT NULL DEFAULT 'Full-time',
    `experience` VARCHAR(100) DEFAULT NULL,
    `salary_min` DECIMAL(12,2) DEFAULT NULL,
    `salary_max` DECIMAL(12,2) DEFAULT NULL,
    `description` TEXT,
    `requirements` TEXT,
    `status` ENUM('Open','Closed','On Hold') NOT NULL DEFAULT 'Open',
    `hiring_manager` INT(11) DEFAULT NULL,
    `created_by` INT(11) DEFAULT NULL,
    `created_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `closes_at` DATE DEFAULT NULL,
    PRIMARY KEY (`id`),
    KEY `status` (`status`),
    KEY `department` (`department`),
    KEY `type` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Job applications
CREATE TABLE IF NOT EXISTS `fa_job_applications` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `job_id` INT(11) NOT NULL,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(50) DEFAULT NULL,
    `resume_path` VARCHAR(500) DEFAULT NULL,
    `cover_letter` TEXT,
    `status` ENUM('Applied','Screening','Interview','Offer','Rejected','Withdrawn') NOT NULL DEFAULT 'Applied',
    `source` VARCHAR(100) DEFAULT NULL,
    `rating` INT(1) DEFAULT NULL,
    `notes` TEXT,
    `applied_at` DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    `updated_at` DATETIME DEFAULT NULL ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    KEY `job_id` (`job_id`),
    KEY `status` (`status`),
    KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Interview rounds
CREATE TABLE IF NOT EXISTS `fa_recruitment_interviews` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `application_id` INT(11) NOT NULL,
    `round` INT(2) NOT NULL DEFAULT 1,
    `interview_date` DATETIME DEFAULT NULL,
    `interviewer` INT(11) DEFAULT NULL,
    `type` ENUM('Phone','Video','In-person','Technical') NOT NULL DEFAULT 'Phone',
    `status` ENUM('Scheduled','Completed','No Show','Rescheduled') NOT NULL DEFAULT 'Scheduled',
    `rating` INT(1) DEFAULT NULL,
    `feedback` TEXT,
    PRIMARY KEY (`id`),
    KEY `application_id` (`application_id`),
    KEY `interview_date` (`interview_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Module version
INSERT INTO `fa_modules` (`name`, `version`, `enabled`, `installed`) VALUES
('Recruitment', '1.0.0', 1, NOW())
ON DUPLICATE KEY UPDATE `version` = '1.0.0', `installed` = NOW();