# AGENTS.md - ksf_FA_Recruitment#

## Architecture Overview#

**FA Module** for Recruitment Management - job openings, applications, interviews, and hiring.

### Core Principles#
- **SOLID**, **DRY**, **TDD**, **DI**, **SRP**#

## Repository Structure#

```
ksf_FA_Recruitment/
├── sql/#
│   ├── fa_job_openings.sql#
│   ├── fa_job_applications.sql#
│   ├── fa_recruitment_interviews.sql#
│   └── fa_recruitment_offers.sql#
├── includes/#
│   ├── openings_db.inc#
│   ├── applications_db.inc#
│   ├── interviews_db.inc#
│   └── offers_db.inc#
├── pages/#
├── hooks.php#
├── composer.json#
└── ProjectDocs/#
```

## Dependencies#

- **ksf_FA_Recruitment_Core** (business logic)#
- **ksf_FA_CRM** (link applications to leads/contacts)#
- **ksf_FA_HRM** (convert hires to employees)#
- **ksf_FA_Onboarding** (onboard new hires)#
- **FrontAccounting 2.4+**#

## Development Workflow

All development is done in the **devel tree** (`~/Documents/ksf_FA_Recruitment`). Do **not** edit files in the UAT bind point directly.

### Workflow Steps
1. **Develop** in this repo (feature branches preferred)
2. **Test**: run repo-appropriate tests
3. **Lint**: `php -l` on modified PHP files (no syntax errors)
4. **Commit** and **Push** branch to GitHub
5. **Merge** to `master` when ready
6. **Push** `master` to GitHub
7. **Deploy** to UAT by pulling in the Infrastructure bind point:

   ```
   cd ~/ksf_Infrastructure/fa_modules/ksf_FA_Recruitment
   git stash -u
   git pull origin master
   git stash pop
   ```

### UAT Bind Point
| Path | Purpose |
|------|---------|
| `~/Documents/ksf_FA_Recruitment` | Devel tree — all development, testing, commits |
| `~/ksf_Infrastructure/fa_modules/ksf_FA_Recruitment` | UAT bind point — deployment target, integration testing (if mirrored) |

