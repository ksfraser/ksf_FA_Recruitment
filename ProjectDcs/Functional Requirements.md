# FA_Recruitment Functional Requirements

## Document Information
- **Module**: FA_Recruitment (Recruitment Management)
- **Version**: 1.0.0
- **Date**: 2024-04-26
- **Status**: Planned
- **Author**: KSFII Development Team

## 1. Overview

### 1.1 Purpose
This document defines the functional requirements for the FA_Recruitment module, which extends FrontAccounting with comprehensive recruitment and hiring management capabilities.

### 1.2 Scope
The Recruitment module provides:
- Job requisition management
- Candidate pipeline tracking
- Interview scheduling and management
- Rating and feedback collection
- Offer generation and tracking
- Employee onboarding integration
- Analytics and reporting

## 2. Requisition Management

### 2.1 Create Requisition (FR-RQ-001)
**Requirement**: The system shall allow users to create job requisitions with detailed requirements.

**Fields**:
- `requisition_number` - Auto-generated unique identifier
- `title` - Job title
- `department_id` - Department reference
- `manager_id` - Hiring manager
- `requisition_type_id` - Type (new_position, replacement, temporary)
- `description` - Job description
- `requirements` - Required qualifications
- `experience_required` - Years of experience
- `education_level` - Required education
- `skills_required` - Required skills (comma-separated)
- `status` - Status (open, filled, cancelled, on_hold)
- `priority` - Priority (low, medium, high, urgent)
- `location` - Job location
- `employment_type` - Type (full_time, part_time, contract)
- `salary_min` - Minimum salary
- `salary_max` - Maximum salary
- `benefits` - Benefits description
- `opened_date` - Open date
- `filled_date` - Filled date (when filled)
- `target_fill_date` - Target fill date
- `closed_reason` - Reason if closed
- `assigned_to` - Recruiter assigned

**Priority**: High

### 2.2 Requisition Types (FR-RQ-002)
**Requirement**: The system shall support configurable requisition types.

**Default Types**:
- New Position
- Replacement
- Temporary/Contract
- Internal Transfer

**Priority**: Medium

### 2.3 Requisition Workflow (FR-RQ-003)
**Requirement**: The system shall manage requisition status workflow.

**Behavior**:
- Open -> Filled (when position filled)
- Open -> Cancelled (position cancelled)
- Open -> On Hold (temporarily paused)
- Filled -> Open (reopened)

**Priority**: High

### 2.4 Requisition Search (FR-RQ-004)
**Requirement**: The system shall allow searching and filtering requisitions.

**Features**:
- Filter by status
- Filter by department
- Filter by priority
- Filter by date range
- Sort by various fields

**Priority**: Medium

## 3. Candidate Management

### 3.1 Add Candidate (FR-CD-001)
**Requirement**: The system shall allow adding candidates to requisitions.

**Fields**:
- `requisition_id` - Requisition reference
- `first_name` - First name
- `last_name` - Last name
- `email` - Email address
- `phone` - Phone number
- `mobile` - Mobile number
- `current_company` - Current employer
- `current_title` - Current position
- `experience_years` - Years of experience
- `education` - Education level
- `skills` - Skills list
- `linkedin_url` - LinkedIn profile
- `resume_path` - Resume file path
- `stage` - Pipeline stage
- `source` - Source (indeed, linkedin, referral, direct, other)
- `applied_date` - Application date
- `status` - Status (active, hired, rejected, withdrawn)
- `rejection_reason` - Reason if rejected
- `notes` - Notes
- `assigned_to` - Assigned recruiter

**Priority**: High

### 3.2 Pipeline Stages (FR-CD-002)
**Requirement**: The system shall support configurable pipeline stages.

**Default Stages**:
1. Applied
2. Phone Screen
3. Technical Interview
4. Manager Interview
5. HR Interview
6. Offer Extended
7. Hired
8. Rejected

**Priority**: High

### 3.3 Stage Movement (FR-CD-003)
**Requirement**: The system shall track candidate stage progression.

**Behavior**:
- Move candidate forward through stages
- Move candidate backward (reject, hold)
- Track stage history with dates
- Record reason for stage change

**Priority**: High

### 3.4 Candidate Search (FR-CD-004)
**Requirement**: The system shall allow searching candidates.

**Features**:
- Search by name/email
- Filter by requisition
- Filter by stage
- Filter by source
- Filter by date range

**Priority**: Medium

## 4. Interview Management

### 4.1 Schedule Interview (FR-IN-001)
**Requirement**: The system shall allow scheduling interviews.

**Fields**:
- `candidate_id` - Candidate reference
- `requisition_id` - Requisition reference
- `interview_type` - Type (phone, video, in_person, technical, manager, hr)
- `interview_date` - Scheduled date/time
- `duration_minutes` - Duration
- `interviewer_id` - interviewer user
- `location` - Location (if in-person)
- `meeting_url` - Virtual meeting URL
- `status` - Status (scheduled, completed, cancelled, no_show)
- `notes` - Interview notes
- `feedback` - Interviewer feedback

**Priority**: High

### 4.2 Interview Types (FR-IN-002)
**Requirement**: The system shall support multiple interview types.

**Types**:
- Phone Screen
- Video Interview
- In-Person
- Technical Interview
- Manager Interview
- HR Interview
- Panel Interview

**Priority**: High

### 4.3 Interview Feedback (FR-IN-003)
**Requirement**: The system shall collect interview feedback.

**Fields**:
- `interview_id` - Interview reference
- `rating_overall` - Overall rating (1-5)
- `rating_technical` - Technical skills rating
- `rating_communication` - Communication rating
- `rating_culture_fit` - Culture fit rating
- `strengths` - Candidate strengths
- `weaknesses` - Areas of concern
- `recommendation` - Recommendation (hire, no_hire, uncertain)
- `comments` - Detailed comments

**Priority**: High

### 4.4 Interview Calendar (FR-IN-004)
**Requirement**: The system shall show interview schedule.

**Features**:
- Calendar view of interviews
- Day/week/month views
- Filter by interviewer
- Filter by status

**Priority**: Medium

## 5. Rating System

### 5.1 Rating Criteria (FR-RT-001)
**Requirement**: The system shall support configurable rating criteria.

**Default Criteria**:
- Technical Skills
- Communication Skills
- Problem Solving
- Culture Fit
- Experience Match
- Leadership Potential

**Priority**: High

### 5.2 Candidate Rating (FR-RT-002)
**Requirement**: The system shall calculate aggregate candidate ratings.

**Formula**: Average of all interview ratings per criteria

**Priority**: Medium

## 6. Offer Management

### 6.1 Create Offer (FR-OF-001)
**Requirement**: The system shall allow generating job offers.

**Fields**:
- `candidate_id` - Candidate reference
- `requisition_id` - Requisition reference
- `salary_offered` - Salary offer
- `salary_type` - Type (annual, monthly, hourly)
- `start_date` - Proposed start date
- `benefits` - Benefits package
- `bonus_eligible` - Bonus eligibility
- `equity_eligible` - Equity eligibility (if applicable)
- `status` - Status (draft, sent, accepted, rejected, expired)
- `sent_date` - Date offer sent
- `response_date` - Response date
- `response_notes` - Response notes

**Priority**: High

### 6.2 Offer Workflow (FR-OF-002)
**Requirement**: The system shall track offer status.

**Workflow**:
- Draft -> Sent (when sent to candidate)
- Sent -> Accepted (candidate accepts)
- Sent -> Rejected (candidate declines)
- Sent -> Expired (no response within deadline)

**Priority**: High

## 7. Employee Onboarding

### 7.1 Auto-Create Employee (FR-OB-001)
**Requirement**: The system shall auto-create employee record when candidate is hired.

**Behavior**:
- When candidate status = Hired
- Create employee in FA system
- Create onboarding tasks
- Trigger onboarding workflow

**Priority**: High

### 7.2 Onboarding Tasks (FR-OB-002)
**Requirement**: The system shall create onboarding tasks.

**Features**:
- IT setup tasks
- HR paperwork tasks
- Department orientation tasks
- Training tasks

**Priority**: Medium

## 8. Analytics & Reporting

### 8.1 Requisition Analytics (FR-AN-001)
**Requirement**: The system shall provide requisition analytics.

**Metrics**:
- `candidates_per_requisition` - Candidates count per requisition
- `time_to_fill` - Average days to fill position
- `source_effectiveness` - Candidates by source
- `stage_conversion` - Stage conversion rates

**Priority**: Medium

### 8.2 Pipeline Analytics (FR-AN-002)
**Requirement**: The system shall provide pipeline analytics.

**Metrics**:
- Candidates by stage
- Stage conversion rates
- Average time in stage
- Drop-off points

**Priority**: Medium

### 8.3 Hiring Metrics (FR-AN-003)
**Requirement**: The system shall provide hiring metrics.

**Metrics**:
- Total hires
- Hire by source
- Hire by department
- Offer acceptance rate

**Priority**: Medium

## 9. Activity Logging

### 9.1 Audit Trail (FR-AL-001)
**Requirement**: The system shall log recruitment activities.

**Logged Events**:
- Requisition created/updated/deleted
- Candidate added/updated/moved/stage_changed
- Interview scheduled/completed
- Offer created/sent/accepted/rejected
- Candidate hired

**Priority**: High

## 10. Integration

### 10.1 Event System (FR-IN-001)
**Requirement**: The system shall dispatch events for integration.

**Events**:
- Recruitment requisition events
- Candidate events
- Interview events
- Offer events

**Priority**: High

### 10.2 Employee Integration (FR-IN-002)
**Requirement**: The system shall integrate with employee module.

**Features**:
- Create employee on hire
- Transfer candidate data
- Trigger onboarding workflow

**Priority**: High

## 11. Permissions

### 11.1 Access Control (FR-AC-001)
**Requirement**: The system shall enforce role-based access control.

**Permission Constants**:
- `RECRUIT_VIEW_REQUISITION` - View requisitions
- `RECRUIT_MANAGE_REQUISITION` - Manage requisitions
- `RECRUIT_VIEW_CANDIDATE` - View candidates
- `RECRUIT_MANAGE_CANDIDATE` - Manage candidates
- `RECRUIT_VIEW_INTERVIEW` - View interviews
- `RECRUIT_MANAGE_INTERVIEW` - Manage interviews
- `RECRUIT_VIEW_OFFER` - View offers
- `RECRUIT_MANAGE_OFFER` - Manage offers
- `RECRUIT_VIEW_ANALYTICS` - View analytics
- `RECRUIT_ADMIN` - Full administrative access

**Priority**: High

## 12. Non-Functional Requirements

### 12.1 Performance
- Page load time < 3 seconds
- Database queries optimized with indexes
- Efficient pagination for large datasets

### 12.2 Security
- SQL injection prevention via prepared statements
- XSS prevention via output escaping
- CSRF protection on forms
- Resume file security

### 12.3 Compatibility
- FrontAccounting 2.4.0+
- PHP 8.0+
- MySQL 5.7+ / MariaDB 10.0+

### 12.4 Maintainability
- Modular code structure
- Clear separation of concerns
- Database abstraction layer
- Comprehensive comments

## 13. Appendix: Default Values

### Requisition Types
| ID | Name | Description |
|----|------|-------------|
| 1 | New Position | New headcount |
| 2 | Replacement | Backfill position |
| 3 | Temporary | Contract position |
| 4 | Internal Transfer | Internal move |

### Requisition Status
| ID | Name | Description |
|----|------|-------------|
| 1 | Open | Position open |
| 2 | Filled | Position filled |
| 3 | Cancelled | Position cancelled |
| 4 | On Hold | Temporarily paused |

### Priority Levels
| ID | Name | Description |
|----|------|-------------|
| 1 | Low | Low priority |
| 2 | Medium | Medium priority |
| 3 | High | High priority |
| 4 | Urgent | Urgent/Critical |

### Employment Type
| ID | Name | Description |
|----|------|-------------|
| 1 | Full Time | Permanent full-time |
| 2 | Part Time | Permanent part-time |
| 3 | Contract | Contract/Temporary |

### Candidate Source
| ID | Name | Description |
|----|------|-------------|
| 1 | Indeed | Indeed.com |
| 2 | LinkedIn | LinkedIn |
| 3 | Referral | Employee referral |
| 4 | Direct | Direct application |
| 5 | Agency | Recruitment agency |
| 6 | Other | Other source |

### Rating Scale
| Value | Label |
|-------|-------|
| 1 | Poor |
| 2 | Below Average |
| 3 | Average |
| 4 | Good |
| 5 | Excellent |

### Interview Types
| ID | Name | Description |
|----|------|-------------|
| 1 | Phone Screen | Initial phone screen |
| 2 | Video | Video interview |
| 3 | In Person | Face-to-face |
| 4 | Technical | Technical interview |
| 5 | Manager | Hiring manager interview |
| 6 | HR | HR interview |
| 7 | Panel | Panel interview |

---
*Document Version: 1.0.0*
*Last Updated: 2024-04-26*
