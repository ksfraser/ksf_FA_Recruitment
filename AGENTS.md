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
