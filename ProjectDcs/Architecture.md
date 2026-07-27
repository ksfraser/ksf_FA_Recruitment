# Architecture - ksf_FA_Recruitment

## Overview

Technical architecture of the Recruitment Management module for FrontAccounting.

## Module Type

- **Type**: FA Module
- **Namespace**: `ksfraser\FrontAccounting\Recruitment\`
- **Tables**: `0_recruit_*` prefix

## Database Schema

### Entity Relationship Diagram

```
┌───────────────────────────┐
│ 0_recruit_job_openings    │
│ opening_id PK             │
│ title                     │
│ department_id FK ─────────┤──> 0_hrm_departments
│ position_id FK ───────────┤──> 0_hrm_positions
│ employment_type           │
│ salary_min / salary_max   │
│ status (Open/Closed/Hold) │
│ hiring_manager_person_id  │
└─────────┬─────────────────┘
          │ opening_id FK
          ├──────────────────────────────────┐
          v                                  v
┌───────────────────────────┐  ┌──────────────────────────┐
│0_recruit_job_applications │  │0_recruit_job_descriptions │
│ application_id PK         │  │ description_id PK         │
│ opening_id FK             │  │ opening_id FK             │
│ first_name / last_name    │  │ job_summary               │
│ email / phone             │  │ responsibilities          │
│ status                    │  │ qualifications            │
│ rating                    │  │ benefits                  │
└─────────┬─────────────────┘  └──────────────────────────┘
          │ application_id FK
          ├──────────────────────────────────┐
          v                                  v
┌───────────────────────────┐  ┌──────────────────────────┐
│ 0_recruit_interviews      │  │ 0_recruit_offers         │
│ interview_id PK           │  │ offer_id PK              │
│ application_id FK         │  │ application_id FK        │
│ round                     │  │ position_id FK ──────────┤──> 0_hrm_positions
│ interview_date            │  │ grade_id FK ─────────────┤──> 0_hrm_grades
│ interviewer_person_id FK  │  │ offered_salary           │
│ type / status / rating    │  │ status                   │
│ feedback                  │  │ expiry_date              │
└───────────────────────────┘  └──────────────────────────┘

┌───────────────────────────┐
│0_recruit_role_grades      │   Links roles to typical pay grades
│ role_id FK ───────────────┤──> 0_hrm_roles
│ grade_id FK ──────────────┤──> 0_hrm_grades
└───────────────────────────┘

┌───────────────────────────┐
│0_recruit_position_grades  │   Links positions to authorized pay grades
│ position_id FK ───────────┤──> 0_hrm_positions
│ grade_id FK ──────────────┤──> 0_hrm_grades
└───────────────────────────┘

┌───────────────────────────┐
│0_recruit_grade_approvals  │   Workflow when salary exceeds grade range
│ entity_type (Position/    │
│   Hiring/Offer)           │
│ entity_id FK              │
│ violation_type            │
│ status (Pending/Approved/ │
│   Rejected)               │
│ approved_by_person_id     │
└───────────────────────────┘
```

## Integration Points

### HRM Integration
- Job openings reference HRM departments and positions
- Offers link to HRM positions and grades
- Grade approval workflow checks role/position grade ranges
- Hired candidates convert to employees via ksf_FA_HRM

### CRM Integration
- Applicants can become CRM contacts
- Hiring managers are CRM persons

## Technology Stack

| Component | Technology |
|-----------|------------|
| Platform | FrontAccounting 2.4+ |
| Language | PHP 7.3+ |
| Database | MySQL/MariaDB |
| Testing | PHPUnit |

## Security

- FA access areas: SA_HRM_RECRUITMENT
- Candidate PII protection (resume, email, phone)
- Hiring manager permission checks

*Document Version: 2.0.0*
*Last Updated: 2026-07-27*
