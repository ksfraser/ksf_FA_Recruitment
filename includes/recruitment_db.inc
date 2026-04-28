<?php
/**
 * Recruitment Database Functions
 */

function create_job_opening(string $title, string $type, string $description = '', string $requirements = '', string $department = ''): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "job_openings 
        (title, type, description, requirements, department, created_by)
        VALUES (" . $db->escape($title) . ", " . $db->escape($type) . ", " . $db->escape($description) . ", " . $db->escape($requirements) . ", " . $db->escape($department) . ", " . user_id() . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_job_opening(int $id): ?array
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "job_openings WHERE id = " . $id;
    $result = $db->query($sql);
    if ($result && $db->num_rows($result) > 0) {
        return $db->fetch($result);
    }
    return null;
}

function get_job_openings(array $filters = []): ?object
{
    global $db;
    $sql = "SELECT * FROM " . TB_PREF . "job_openings WHERE status = 'Open'";
    
    if (!empty($filters['type'])) {
        $sql .= " AND type = " . $db->escape($filters['type']);
    }
    if (!empty($filters['department'])) {
        $sql .= " AND department = " . $db->escape($filters['department']);
    }
    if (!empty($filters['status'])) {
        $sql .= " AND status = " . $db->escape($filters['status']);
    }
    
    $sql .= " ORDER BY created_at DESC";
    return $db->query($sql);
}

function create_application(int $job_id, string $first_name, string $last_name, string $email, string $phone = '', string $resume_path = '', string $cover_letter = '', string $source = ''): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "job_applications 
        (job_id, first_name, last_name, email, phone, resume_path, cover_letter, source)
        VALUES (" . $job_id . ", " . $db->escape($first_name) . ", " . $db->escape($last_name) . ", " . $db->escape($email) . ", " . $db->escape($phone) . ", " . $db->escape($resume_path) . ", " . $db->escape($cover_letter) . ", " . $db->escape($source) . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_application(int $id): ?array
{
    global $db;
    $sql = "SELECT a.*, j.title as job_title FROM " . TB_PREF . "job_applications a
        LEFT JOIN " . TB_PREF . "job_openings j ON a.job_id = j.id
        WHERE a.id = " . $id;
    $result = $db->query($sql);
    if ($result && $db->num_rows($result) > 0) {
        return $db->fetch($result);
    }
    return null;
}

function get_applications(array $filters = []): ?object
{
    global $db;
    $sql = "SELECT a.*, j.title as job_title FROM " . TB_PREF . "job_applications a
        LEFT JOIN " . TB_PREF . "job_openings j ON a.job_id = j.id WHERE 1=1";
    
    if (!empty($filters['job_id'])) {
        $sql .= " AND a.job_id = " . $filters['job_id'];
    }
    if (!empty($filters['status'])) {
        $sql .= " AND a.status = " . $db->escape($filters['status']);
    }
    if (!empty($filters['source'])) {
        $sql .= " AND a.source = " . $db->escape($filters['source']);
    }
    
    $sql .= " ORDER BY a.applied_at DESC";
    return $db->query($sql);
}

function update_application_status(int $id, string $status, string $notes = ''): bool
{
    global $db;
    $sql = "UPDATE " . TB_PREF . "job_applications SET status = " . $db->escape($status);
    if ($notes) {
        $sql .= ", notes = CONCAT(IFNULL(notes, ''), " . $db->escape("\n" . date('Y-m-d H:i') . ": " . $notes) . ")";
    }
    $sql .= " WHERE id = " . $id;
    return $db->query($sql);
}

function create_interview(int $application_id, string $type, string $interview_date = ''): int
{
    global $db;
    $sql = "INSERT INTO " . TB_PREF . "recruitment_interviews (application_id, round, interview_date, type)
        VALUES (" . $application_id . ", 1, " . ($interview_date ? $db->escape($interview_date) : 'NULL') . ", " . $db->escape($type) . ")";
    $db->query($sql);
    return $db->insert_id;
}

function get_interviews(int $application_id): ?object
{
    global $db;
    $sql = "SELECT i.*, e.name as interviewer_name FROM " . TB_PREF . "recruitment_interviews i
        LEFT JOIN " . TB_PREF . "users e ON i.interviewer = e.id
        WHERE i.application_id = " . $application_id . " ORDER BY i.round";
    return $db->query($sql);
}

function complete_interview(int $interview_id, int $rating, string $feedback): bool
{
    global $db;
    $sql = "UPDATE " . TB_PREF . "recruitment_interviews SET status = 'Completed', rating = " . $rating . ", feedback = " . $db->escape($feedback) . " WHERE id = " . $interview_id;
    return $db->query($sql);
}

function get_job_statistics(int $job_id): array
{
    global $db;
    $sql = "SELECT status, COUNT(*) as count FROM " . TB_PREF . "job_applications WHERE job_id = " . $job_id . " GROUP BY status";
    $result = $db->query($sql);
    $stats = [];
    while ($row = $db->fetch($result)) {
        $stats[$row['status']] = $row['count'];
    }
    return $stats;
}