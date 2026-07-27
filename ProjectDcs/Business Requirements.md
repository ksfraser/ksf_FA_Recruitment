# Business Requirements - ksf_FA_Recruitment

## Overview
ksf_FA_Recruitment is the FrontAccounting module for Recruitment Management. It provides job posting, applicant tracking, interview scheduling, offer management, and grade/salary workflow.

## Module Responsibilities

### What Recruitment Owns
- Job opening management (post, close, hold)
- Applicant tracking (applied -> screening -> interview -> offer -> hired/rejected)
- Interview scheduling and feedback
- Offer management with salary/grade
- Grade linkage (role->grade, position->grade)
- Grade approval workflow (when salary exceeds authorized range)

### What Recruitment Does NOT Own
- Employee records -> `ksf_FA_HRM` (0_hrm_contacts_employment)
- Positions, Roles, Grades -> `ksf_FA_HRM`
- Leave tracking -> `ksf_FA_Leave`

## FA-Specific Features

### Database
- FA-compliant table naming: `0_recruit_*` prefix
- FKs to HRM: `0_hrm_departments`, `0_hrm_positions`, `0_hrm_roles`, `0_hrm_grades`
- FKs to CRM: `0_crm_persons` (applicants, hiring managers, interviewers)

### Hiring Pipeline
```
Job Opening -> Applications -> Screening -> Interviews -> Offer -> Hire
                                                              |
                                                    Create Employee (HRM)
```

### Grade Approval Workflow
When an offer salary exceeds the position's authorized grade range, the system creates a grade approval record requiring management approval before the offer can be finalized.

## Dependencies
- FrontAccounting 2.4+
- ksf_FA_HRM (org hierarchy, employee creation)
- ksf_FA_CRM (person records, contact system)
- PHP >=7.3

*Document Version: 2.0.0*
*Last Updated: 2026-07-27*
