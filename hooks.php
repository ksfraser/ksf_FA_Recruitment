<?php
/**
 * FA_Recruitment Module Hooks for FrontAccounting
 */

define('SS_RECRUITMENT', 132 << 8);

class hooks_fa_recruitment extends hooks {
    var $module_name = 'fa_recruitment';
    var $version = '1.0.0';

    function install_options($app) {
        global $path_to_root;

        switch($app->id) {
            case 'HR':
                $app->add_lapp_function(0, _("Job Openings"),
                    $path_to_root."/modules/".$this->module_name."/openings.php", 'SA_RECRUITMENTVIEW', MENU_ENTRY);
                $app->add_lapp_function(1, _("Create Opening"),
                    $path_to_root."/modules/".$this->module_name."/create.php", 'SA_RECRUITMENTCREATE', MENU_ENTRY);
                $app->add_lapp_function(2, _("Applications"),
                    $path_to_root."/modules/".$this->module_name."/applications.php", 'SA_RECRUITMENTMANAGE', MENU_ENTRY);
                $app->add_rapp_function(3, _("Recruitment Reports"),
                    $path_to_root."/modules/".$this->module_name."/reports.php", 'SA_RECRUITMENTREPORTS', MENU_REPORT);
                break;
        }
    }

    function install_access() {
        $security_sections[SS_RECRUITMENT] = _("Recruitment Management");
        $security_areas['SA_RECRUITMENTVIEW'] = array(SS_RECRUITMENT | 1, _("View Job Openings"));
        $security_areas['SA_RECRUITMENTCREATE'] = array(SS_RECRUITMENT | 2, _("Create Job Openings"));
        $security_areas['SA_RECRUITMENTMANAGE'] = array(SS_RECRUITMENT | 3, _("Manage Applications"));
        $security_areas['SA_RECRUITMENTREPORTS'] = array(SS_RECRUITMENT | 4, _("View Recruitment Reports"));
        return array($security_areas, $security_sections);
    }

    function activate_extension($company, $check_only=true) {
        $updates = array('sql/update.sql' => array($this->module_name));
        $ok = $this->update_databases($company, $updates, $check_only);
        if ($check_only || !$ok) {
            return $ok;
        }
        $this->ensure_recruitment_schema();
        return $ok;
    }

    private function table_exists($table) {
        $sql = "SHOW TABLES LIKE " . db_escape($table);
        $res = db_query($sql, 'Failed checking table existence');
        return db_num_rows($res) > 0;
    }

    private function ensure_recruitment_schema() {
        $tables = array(
            TB_PREF . "fa_job_openings" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_job_openings` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `title` VARCHAR(100) NOT NULL,
                    `description` TEXT,
                    `department` VARCHAR(50) DEFAULT NULL,
                    `location` VARCHAR(100) DEFAULT NULL,
                    `salary_range` VARCHAR(50) DEFAULT NULL,
                    `status` VARCHAR(20) DEFAULT 'Open',
                    `posted_date` DATE DEFAULT NULL,
                    `closing_date` DATE DEFAULT NULL,
                    `created_by` VARCHAR(100) DEFAULT NULL,
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    `updated_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_status` (`status`),
                    KEY `idx_dates` (`posted_date`, `closing_date`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci",

            TB_PREF . "fa_job_applications" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_job_applications` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `job_id` INT(11) NOT NULL,
                    `applicant_name` VARCHAR(100) NOT NULL,
                    `email` VARCHAR(100) DEFAULT NULL,
                    `phone` VARCHAR(20) DEFAULT NULL,
                    `resume_path` VARCHAR(500) DEFAULT NULL,
                    `cover_letter` TEXT,
                    `status` VARCHAR(20) DEFAULT 'Applied',
                    `interview_date` DATETIME DEFAULT NULL,
                    `notes` TEXT,
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_job` (`job_id`),
                    KEY `idx_status` (`status`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci",

            TB_PREF . "fa_recruitment_interviews" => "
                CREATE TABLE IF NOT EXISTS `" . TB_PREF . "fa_recruitment_interviews` (
                    `id` INT(11) NOT NULL AUTO_INCREMENT,
                    `application_id` INT(11) NOT NULL,
                    `interviewer_id` VARCHAR(100) DEFAULT NULL,
                    `scheduled_date` DATETIME NOT NULL,
                    `interview_type` VARCHAR(20) DEFAULT 'In-Person',
                    `notes` TEXT,
                    `result` VARCHAR(20) DEFAULT 'Pending',
                    `created_at` TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
                    PRIMARY KEY (`id`),
                    KEY `idx_application` (`application_id`),
                    KEY `idx_scheduled` (`scheduled_date`)
                ) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci"
        );

        foreach ($tables as $table_name => $sql) {
            db_query($sql, "Could not create Recruitment table: $table_name");
        }
    }

    function db_prevoid($trans_type, $trans_no) {
        // Handle voiding if needed
    }
}
?>
