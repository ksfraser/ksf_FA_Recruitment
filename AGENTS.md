# AGENTS.md - ksf_FA_Recruitment

## Overview

FA Module for Recruitment Management - job openings, applications, interviews, offers, grade linkage, and hiring workflow.

### Core Principles
- SOLID, DRY, TDD, DI, SRP

## Namespace Convention

- **FA Platform modules**: `ksfraser\FrontAccounting\<ModuleName>\`
- **Current**: `ksfraser\FrontAccounting\Recruitment\`

## Table Ownership

### Recruitment Tables (`0_recruit_*`)
| Table | Purpose |
|-------|---------|
| `0_recruit_job_openings` | Job postings (FK to departments, positions) |
| `0_recruit_job_applications` | Applicant records |
| `0_recruit_job_descriptions` | Detailed job descriptions |
| `0_recruit_interviews` | Interview scheduling and feedback |
| `0_recruit_offers` | Offer letters with salary/grade |
| `0_recruit_role_grades` | Role -> Grade linkage (typical pay grades) |
| `0_recruit_position_grades` | Position -> Grade linkage (authorized pay grades) |
| `0_recruit_grade_approvals` | Grade/salary range violation workflow |

### NOT Owned by Recruitment
- **Employee records** -> `ksf_FA_HRM` (`0_hrm_contacts_employment`)
- **Positions, Roles, Grades** -> `ksf_FA_HRM` (`0_hrm_positions`, `0_hrm_roles`, `0_hrm_grades`)
- **Access control roles** -> FA core / `ksf_RBAC`

## Dependencies

- FrontAccounting 2.4+ (core)
- ksf_FA_HRM (employee records, org hierarchy)
- ksf_FA_CRM (person records, contact system)
- PHP >=7.3

## Repository Structure

```
ksf_FA_Recruitment/
├── sql/
│   └── install.sql          # All Recruitment tables (0_ prefix)
├── includes/
│   └── recruitment_db.inc   # Recruitment DB queries
├── pages/                   # (future: recruitment pages)
├── hooks.php                # FA module hooks
├── composer.json
└── ProjectDcs/
```

## Development Workflow

All development is done in the **devel tree** (`~/Documents/ksf_FA_Recruitment`). Do **not** edit files in the UAT bind point directly.

### Workflow Steps
1. **Develop** in this repo (feature branches preferred)
2. **Test**: run repo-appropriate tests
3. **Lint**: `php -l` on modified PHP files (no syntax errors)
4. **Commit** and **Push** branch to GitHub
5. **Merge** to `main` when ready
6. **Push** `main` to GitHub
7. **Deploy** to UAT:

   ```
   cd ~/ksf_Infrastructure/fa_modules/ksf_FA_Recruitment
   git stash -u
   git pull origin main
   git stash pop
   ```

### UAT Bind Point
| Path | Purpose |
|------|---------|
| `~/Documents/ksf_FA_Recruitment` | Devel tree |
| `~/ksf_Infrastructure/fa_modules/ksf_FA_Recruitment` | UAT bind point |
