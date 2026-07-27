-- ============================================================================
-- ksf_FA_Recruitment Module Installation SQL
-- ============================================================================
-- Recruitment management: job openings, applications, interviews, offers.
-- Uses 0_ prefix for FA db_import(). Links to HRM via person_id/position_id.
-- ============================================================================

-- Job openings (linked to HRM positions when filling a role)
CREATE TABLE IF NOT EXISTS `0_recruit_job_openings` (
    `opening_id` INT(11) NOT NULL AUTO_INCREMENT,
    `title` VARCHAR(255) NOT NULL,
    `department_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_hrm_departments.department_id',
    `position_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_hrm_positions.position_id (if filling existing role)',
    `location` VARCHAR(255) DEFAULT NULL,
    `employment_type` VARCHAR(20) DEFAULT 'Full-time' COMMENT 'Full-time|Part-time|Contract|Intern',
    `experience` VARCHAR(100) DEFAULT NULL,
    `salary_min` DECIMAL(12,2) DEFAULT NULL,
    `salary_max` DECIMAL(12,2) DEFAULT NULL,
    `description` TEXT,
    `requirements` TEXT,
    `status` VARCHAR(20) DEFAULT 'Open' COMMENT 'Open|Closed|On Hold',
    `hiring_manager_person_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_crm_persons.id',
    `created_by_person_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_crm_persons.id',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `closes_at` DATE DEFAULT NULL,
    PRIMARY KEY (`opening_id`),
    KEY `idx_status` (`status`),
    KEY `idx_department` (`department_id`),
    KEY `idx_position` (`position_id`),
    KEY `idx_hiring_manager` (`hiring_manager_person_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Job applications (link to CRM person when hired)
CREATE TABLE IF NOT EXISTS `0_recruit_job_applications` (
    `application_id` INT(11) NOT NULL AUTO_INCREMENT,
    `opening_id` INT(11) NOT NULL,
    `first_name` VARCHAR(100) NOT NULL,
    `last_name` VARCHAR(100) NOT NULL,
    `email` VARCHAR(255) NOT NULL,
    `phone` VARCHAR(50) DEFAULT NULL,
    `resume_path` VARCHAR(500) DEFAULT NULL,
    `cover_letter` TEXT,
    `status` VARCHAR(20) DEFAULT 'Applied' COMMENT 'Applied|Screening|Interview|Offer|Rejected|Withdrawn',
    `source` VARCHAR(100) DEFAULT NULL COMMENT 'Job board, referral, etc.',
    `rating` INT(1) DEFAULT NULL,
    `notes` TEXT,
    `applied_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`application_id`),
    KEY `idx_opening` (`opening_id`),
    KEY `idx_status` (`status`),
    KEY `idx_email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Job descriptions (detailed role specification)
CREATE TABLE IF NOT EXISTS `0_recruit_job_descriptions` (
    `description_id` INT(11) NOT NULL AUTO_INCREMENT,
    `opening_id` INT(11) NOT NULL,
    `job_summary` TEXT,
    `responsibilities` TEXT,
    `qualifications` TEXT,
    `nice_to_have` TEXT,
    `benefits` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`description_id`),
    KEY `idx_opening` (`opening_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Interview rounds
CREATE TABLE IF NOT EXISTS `0_recruit_interviews` (
    `interview_id` INT(11) NOT NULL AUTO_INCREMENT,
    `application_id` INT(11) NOT NULL,
    `round` INT(2) NOT NULL DEFAULT 1,
    `interview_date` DATETIME DEFAULT NULL,
    `interviewer_person_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_crm_persons.id',
    `type` VARCHAR(20) DEFAULT 'Phone' COMMENT 'Phone|Video|In-person|Technical',
    `status` VARCHAR(20) DEFAULT 'Scheduled' COMMENT 'Scheduled|Completed|No Show|Rescheduled',
    `rating` INT(1) DEFAULT NULL,
    `feedback` TEXT,
    PRIMARY KEY (`interview_id`),
    KEY `idx_application` (`application_id`),
    KEY `idx_date` (`interview_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Role -> Grade linkage (typical pay grades for a role from HRM dictionary)
CREATE TABLE IF NOT EXISTS `0_recruit_role_grades` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `role_id` INT(11) NOT NULL COMMENT 'FK to 0_hrm_roles.role_id',
    `grade_id` INT(11) NOT NULL COMMENT 'FK to 0_hrm_grades.grade_id',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_role_grade` (`role_id`, `grade_id`),
    KEY `idx_role` (`role_id`),
    KEY `idx_grade` (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Position -> Grade linkage (authorized pay grades for hiring into a position)
CREATE TABLE IF NOT EXISTS `0_recruit_position_grades` (
    `id` INT(11) NOT NULL AUTO_INCREMENT,
    `position_id` INT(11) NOT NULL COMMENT 'FK to 0_hrm_positions.position_id',
    `grade_id` INT(11) NOT NULL COMMENT 'FK to 0_hrm_grades.grade_id',
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (`id`),
    UNIQUE KEY `idx_position_grade` (`position_id`, `grade_id`),
    KEY `idx_position` (`position_id`),
    KEY `idx_grade` (`grade_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Grade approval workflow (when ranges are exceeded during hiring)
CREATE TABLE IF NOT EXISTS `0_recruit_grade_approvals` (
    `approval_id` INT(11) NOT NULL AUTO_INCREMENT,
    `entity_type` VARCHAR(30) NOT NULL COMMENT 'Position|Hiring|Offer',
    `entity_id` INT(11) NOT NULL COMMENT 'FK to position_id or application_id',
    `employment_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_hrm_contacts_employment.employment_id',
    `current_grade_id` INT(11) DEFAULT NULL,
    `requested_grade_id` INT(11) DEFAULT NULL,
    `current_salary` DECIMAL(15,2) DEFAULT 0,
    `requested_salary` DECIMAL(15,2) DEFAULT 0,
    `range_source` VARCHAR(30) DEFAULT NULL COMMENT 'Role|Position',
    `range_min` DECIMAL(15,2) DEFAULT 0,
    `range_max` DECIMAL(15,2) DEFAULT 0,
    `violation_type` VARCHAR(50) NOT NULL COMMENT 'GradeAboveMax|GradeBelowMin|SalaryAboveMax|SalaryBelowMin',
    `status` VARCHAR(20) DEFAULT 'Pending' COMMENT 'Pending|Approved|Rejected',
    `requested_by_person_id` INT(11) DEFAULT NULL,
    `approved_by_person_id` INT(11) DEFAULT NULL,
    `approval_date` DATE DEFAULT NULL,
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`approval_id`),
    KEY `idx_entity` (`entity_type`, `entity_id`),
    KEY `idx_status` (`status`),
    KEY `idx_employment` (`employment_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- Hiring offers (extends application with offer details)
CREATE TABLE IF NOT EXISTS `0_recruit_offers` (
    `offer_id` INT(11) NOT NULL AUTO_INCREMENT,
    `application_id` INT(11) NOT NULL,
    `position_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_hrm_positions.position_id',
    `grade_id` INT(11) DEFAULT NULL COMMENT 'FK to 0_hrm_grades.grade_id',
    `offered_salary` DECIMAL(15,2) DEFAULT 0,
    `offered_hourly_rate` DECIMAL(10,4) DEFAULT 0,
    `pay_frequency` VARCHAR(20) DEFAULT 'Monthly',
    `offer_date` DATE NOT NULL,
    `expiry_date` DATE DEFAULT NULL,
    `status` VARCHAR(20) DEFAULT 'Draft' COMMENT 'Draft|Sent|Accepted|Rejected|Withdrawn',
    `hiring_manager_person_id` INT(11) DEFAULT NULL,
    `notes` TEXT,
    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    PRIMARY KEY (`offer_id`),
    KEY `idx_application` (`application_id`),
    KEY `idx_position` (`position_id`),
    KEY `idx_status` (`status`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;
