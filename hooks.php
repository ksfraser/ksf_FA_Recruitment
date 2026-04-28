<?php
/**
 * Recruitment Module for FrontAccounting
 */

$module_id = 'Recruitment';
$module_version = '1.0.0';
$module_name = 'Recruitment';
$module_description = 'Job opening and applicant tracking system';

$module_tables = [
    'fa_job_openings',
    'fa_job_applications',
    'fa_recruitment_interviews',
];

$module_capabilities = [
    'SA_RECRUITMENTVIEW' => 'View Job Openings',
    'SA_RECRUITMENTCREATE' => 'Create Job Openings',
    'SA_RECRUITMENTMANAGE' => 'Manage Applications',
    'SA_RECRUITMENTREPORTS' => 'View Recruitment Reports',
];

function recruitment_install(): bool
{
    global $db, $db_multi_sql;
    $sql_file = dirname(__FILE__) . '/../sql/install.sql';
    if (!file_exists($sql_file)) return false;
    $sql = file_get_contents($sql_file);
    return $db_multi_sql($sql);
}

function recruitment_enable(): bool
{
    global $db;
    return $db->query("UPDATE " . TB_PREF . "modules SET enabled = 1 WHERE name = 'Recruitment'");
}

function recruitment_disable(): bool
{
    global $db;
    return $db->query("UPDATE " . TB_PREF . "modules SET enabled = 0 WHERE name = 'Recruitment'");
}

function recruitment_remove(): bool
{
    global $db, $db_multi_sql;
    $sql = "DROP TABLE IF EXISTS " . TB_PREF . "recruitment_interviews;
           DROP TABLE IF EXISTS " . TB_PREF . "job_applications;
           DROP TABLE IF EXISTS " . TB_PREF . "job_openings;
           DELETE FROM " . TB_PREF . "modules WHERE name = 'Recruitment';";
    return $db_multi_sql($sql);
}

add_module($module_name, $module_version, $module_description);