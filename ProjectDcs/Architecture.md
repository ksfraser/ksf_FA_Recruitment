# FA_Recruitment Technical Architecture

## Document Information
- **Module**: FA_Recruitment (Recruitment Management)
- **Version**: 1.0.0
- **Date**: 2024-04-26
- **Status**: Planned
- **Author**: KSFII Development Team

## 1. Architecture Overview

### 1.1 Design Principles
The FA_Recruitment module follows these architectural principles:

1. **Modularity**: Clean separation between UI, business logic, and data layers
2. **Extensibility**: Hooks and events for integration with other modules
3. **Compatibility**: WebERP-style functions for FA integration
4. **Type Safety**: PHP 8.0+ features with type declarations

### 1.2 Technology Stack
- **PHP**: 8.0+ with strict typing
- **Database**: MySQL 5.7+ / MariaDB 10.0+
- **Frontend**: Bootstrap 5.x (via FA)
- **Integration**: PSR-14 Event Dispatcher

## 2. Directory Structure

```
ksf_FA_Recruitment/
├── FA_Recruitment_Module.php  # Module registration & hooks
├── recruit.php             # Main module entry
├── hooks.php              # Install/activate/deactivate hooks
├── README.md             # Module documentation
├── includes/
│   ├── recruit_db.inc    # Database functions
│   └── recruit_ui.inc   # UI components
├── pages/
│   ├── dashboard.php    # Recruitment dashboard
│   ├── requisitions.php # Requisition management
│   ├── candidates.php   # Candidate management
│   ├── interviews.php  # Interview scheduling
│   ├── offers.php       # Offer management
│   ├── reports.php     # Analytics reports
│   └── settings.php    # Module settings
├── sql/
│   └── install.sql      # Database schema
├── src/                # Additional source files
├── tests/              # Unit and integration tests
└── ProjectDcs/
    ├── Functional Requirements.md
    ├── Architecture.md
    ├── Test Plan.md
    └── UAT Plan.md
```

## 3. Module Components

### 3.1 FA_Recruitment_Module.php
Main module class providing:
- Module metadata
- Permission definitions
- Menu items
- Lifecycle hooks (install, activate, deactivate, uninstall)

**Key Functions**:
```php
function fa_recruit_get_module_info()    // Returns module metadata
function fa_recruit_install()           // Creates database tables
function fa_recruit_activate()         // Activates module
function fa_recruit_deactivate()       // Deactivates module
function fa_recruit_uninstall()       // Cleanup on uninstall
function fa_recruit_get_menu_items()  // Returns navigation menu
```

### 3.2 hooks.php
Handles module lifecycle operations:
- Database installation
- Permission registration
- Menu registration
- Hook registration

### 3.3 recruit_db.inc
Database abstraction layer with functions for:
- Requisition CRUD operations
- Candidate management
- Interview scheduling
- Offer management
- Rating management
- Analytics calculations

### 3.4 recruit_ui.inc
UI helper functions:
- Form input generators
- Display components
- Dashboard widgets
- Navigation menus
- Selector helpers

## 4. Database Schema

### 4.1 Core Tables

#### fa_recruit_requisitions
```sql
CREATE TABLE fa_recruit_requisitions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    requisition_number VARCHAR(20) NOT NULL UNIQUE,
    title VARCHAR(100) NOT NULL,
    department_id INT,
    manager_id INT,
    requisition_type_id INT,
    description TEXT,
    requirements TEXT,
    experience_required INT,
    education_level VARCHAR(50),
    skills_required TEXT,
    status VARCHAR(20) DEFAULT 'open',
    priority VARCHAR(10) DEFAULT 'medium',
    location VARCHAR(100),
    employment_type VARCHAR(20) DEFAULT 'full_time',
    salary_min DECIMAL(15,2),
    salary_max DECIMAL(15,2),
    benefits TEXT,
    opened_date DATE,
    filled_date DATE,
    target_fill_date DATE,
    closed_reason TEXT,
    assigned_to INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_requisition_number (requisition_number),
    INDEX idx_status (status),
    INDEX idx_department (department_id),
    INDEX idx_priority (priority)
);
```

#### fa_recruit_candidates
```sql
CREATE TABLE fa_recruit_candidates (
    id INT AUTO_INCREMENT PRIMARY KEY,
    requisition_id INT NOT NULL,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    email VARCHAR(100) NOT NULL,
    phone VARCHAR(20),
    mobile VARCHAR(20),
    current_company VARCHAR(100),
    current_title VARCHAR(100),
    experience_years INT,
    education VARCHAR(50),
    skills TEXT,
    linkedin_url VARCHAR(255),
    resume_path VARCHAR(500),
    stage VARCHAR(30) DEFAULT 'applied',
    source VARCHAR(30),
    applied_date DATE,
    status VARCHAR(20) DEFAULT 'active',
    rejection_reason TEXT,
    notes TEXT,
    assigned_to INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_requisition_id (requisition_id),
    INDEX idx_stage (stage),
    INDEX idx_status (status),
    INDEX idx_email (email)
);
```

#### fa_recruit_interviews
```sql
CREATE TABLE fa_recruit_interviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    requisition_id INT NOT NULL,
    interview_type VARCHAR(30) NOT NULL,
    interview_date DATETIME NOT NULL,
    duration_minutes INT DEFAULT 60,
    interviewer_id INT,
    location VARCHAR(100),
    meeting_url VARCHAR(255),
    status VARCHAR(20) DEFAULT 'scheduled',
    notes TEXT,
    feedback TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_candidate_id (candidate_id),
    INDEX idx_interviewer (interviewer_id),
    INDEX idx_date (interview_date),
    INDEX idx_status (status)
);
```

#### fa_recruit_interview_ratings
```sql
CREATE TABLE fa_recruit_interview_ratings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    interview_id INT NOT NULL,
    candidate_id INT NOT NULL,
    criteria VARCHAR(30) NOT NULL,
    rating INT NOT NULL,
    notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_interview (interview_id),
    INDEX idx_candidate (candidate_id)
);
```

#### fa_recruit_offers
```sql
CREATE TABLE fa_recruit_offers (
    id INT AUTO_INCREMENT PRIMARY KEY,
    candidate_id INT NOT NULL,
    requisition_id INT NOT NULL,
    salary_offered DECIMAL(15,2),
    salary_type VARCHAR(20) DEFAULT 'annual',
    start_date DATE,
    benefits TEXT,
    bonus_eligible TINYINT(1) DEFAULT 0,
    equity_eligible TINYINT(1) DEFAULT 0,
    status VARCHAR(20) DEFAULT 'draft',
    sent_date DATE,
    response_date DATE,
    response_notes TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    INDEX idx_candidate (candidate_id),
    INDEX idx_status (status)
);
```

### 4.2 Reference Tables

#### fa_recruit_requisition_types
```sql
CREATE TABLE fa_recruit_requisition_types (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    inactive TINYINT(1) DEFAULT 0,
    sort_order INT DEFAULT 0
);
```

#### fa_recruit_rating_criteria
```sql
CREATE TABLE fa_recruit_rating_criteria (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    description VARCHAR(255),
    sort_order INT DEFAULT 0,
    inactive TINYINT(1) DEFAULT 0
);
```

### 4.3 Activity Logging

#### fa_recruit_activity_log
```sql
CREATE TABLE fa_recruit_activity_log (
    id INT AUTO_INCREMENT PRIMARY KEY,
    activity_type VARCHAR(30) NOT NULL,
    entity_type VARCHAR(30) NOT NULL,
    entity_id INT NOT NULL,
    user_id INT,
    action VARCHAR(50) NOT NULL,
    details TEXT,
    old_values TEXT,
    new_values TEXT,
    ip_address VARCHAR(45),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_entity (entity_type, entity_id),
    INDEX idx_activity (activity_type)
);
```

## 5. Integration Architecture

### 5.1 FrontAccounting Integration
The module integrates with FA through:

1. **Hooks System**: Using FA's hook mechanism
```php
add_action('requisition_created', $callback);
add_action('candidate_hired', $callback);
add_hook('recruit.event', $callback);
```

2. **Database Table Prefix**: Using `TB_PREF` constant
```php
$sql = "SELECT * FROM " . TB_PREF . "fa_recruit_requisitions";
```

3. **Permission System**: Using FA's permission constants
```php
define('RECRUIT_VIEW_REQUISITION', 'RECRUIT_VIEW_REQUISITION');
define('RECRUIT_MANAGE_REQUISITION', 'RECRUIT_MANAGE_REQUISITION');
```

4. **UI Components**: Using FA's form helpers
```php
combo_input($name, $selected_id, $sql, $id_field, $name_field);
```

### 5.2 Event System
PSR-14 compatible event system for:
- Cross-module communication
- Real-time notifications
- Workflow automation

### 5.3 Employee Integration Pipeline
```
Candidate Hired → Create Employee Record → Trigger Onboarding
                                              ↓
                                      Create Onboarding Tasks
```

## 6. Security Architecture

### 6.1 Input Validation
- All user inputs validated before database operations
- SQL injection prevention via `db_escape()`
- Type casting for numeric inputs

### 6.2 Output Escaping
- HTML output escaped via `htmlspecialchars()`
- JavaScript sanitization for dynamic content

### 6.3 Access Control
- Permission checks on all CRUD operations
- Role-based menu visibility
- Audit logging for sensitive operations

### 6.4 File Security
- Resume file uploads stored securely
- No direct URL access to uploaded files
- File type validation for uploads

## 7. Extension Points

### 7.1 Custom Hooks
Modules can register hooks for:
- Requisition lifecycle events
- Candidate stage changes
- Interview completion events
- Offer status changes

### 7.2 Custom Fields
The schema supports:
- Notes fields (TEXT) for custom data
- JSON columns for flexible attributes (future)

### 7.3 Pipeline Customization
The pipeline can be extended to:
- Add custom stages
- Add custom criteria
- Add custom offer templates

## 8. Performance Considerations

### 8.1 Database Indexes
Key indexes on:
- `requisition_id` - Candidate lookups by requisition
- `stage` - Pipeline filtering
- `interview_date` - Interview scheduling
- `candidate_id` - Candidate-based queries
- `created_at` - Date range queries

### 8.2 Query Optimization
- Pagination for large datasets
- Efficient JOINs with proper indexes
- Prepared statements for repeated queries

### 8.3 Caching (Future)
Potential caching for:
- Requisition type lists
- Pipeline stage lists
- Dashboard statistics

## 9. API Design

### 9.1 Service Layer Pattern
```php
class RecruitmentService {
    // Requisition operations
    public function createRequisition(array $data): Requisition
    public function getRequisition(int $id): Requisition
    public function updateRequisitionStatus(int $id, string $status): bool
    
    // Candidate operations
    public function addCandidate(array $data): Candidate
    public function moveCandidateStage(int $candidateId, string $stage): bool
    public function getCandidatesByRequisition(int $requisitionId): array
    
    // Interview operations
    public function scheduleInterview(array $data): Interview
    public function completeInterview(int $interviewId, array $feedback): bool
    
    // Offer operations
    public function createOffer(array $data): Offer
    public function acceptOffer(int $offerId): bool
}
```

### 9.2 Factory Pattern
```php
class RecruitmentEntityFactory {
    public static function createRequisition(array $data): Requisition
    public static function createCandidate(array $data): Candidate
    public static function createInterview(array $data): Interview
}
```

### 9.3 Repository Pattern
```php
class RecruitmentRepository {
    public function findRequisitionById(int $id): ?Requisition
    public function findCandidatesByRequisition(int $requisitionId): array
    public function findInterviewsByDateRange(DateTime $start, DateTime $end): array
}
```

## 10. Error Handling

### 10.1 Exception Hierarchy
```php
class RecruitmentException extends Exception
class RecruitmentDatabaseException extends RecruitmentException
class RecruitmentNotFoundException extends RecruitmentException
class RecruitmentValidationException extends RecruitmentException
class RecruitmentPermissionException extends RecruitmentException
```

### 10.2 Error Logging
- Database errors logged with query details
- Validation errors logged separately
- Activity log for audit trail

## 11. Testing Strategy

### 11.1 Unit Tests
- Database function tests
- UI component tests
- Service layer tests

### 11.2 Integration Tests
- FA module integration
- Database operations
- Event dispatching

### 11.3 Test Coverage
- Core CRUD operations
- Analytics calculations
- Pipeline workflow tests

## 12. Deployment

### 12.1 Installation Process
1. Copy module files to FA modules directory
2. Install via FA module manager
3. Database tables created automatically
4. Permissions assigned to admin
5. Menu items registered

### 12.2 Upgrade Process
1. Backup database
2. Deactivate module
3. Replace files
4. Activate module
5. Run migration scripts (if any)

### 12.3 Uninstall Process
1. Deactivate module
2. Optionally remove data
3. Delete module files

---
*Document Version: 1.0.0*
*Last Updated: 2024-04-26*
