# FA_Recruitment - FrontAccounting Recruitment Module

![Version](https://img.shields.io/badge/version-1.0.0-blue)
![PHP](https://img.shields.io/badge/PHP-8.0+-777bb6)
![FA](https://img.shields.io/badge/FrontAccounting-2.4.x-green)
![License](https://img.shields.io/badge/license-GPL--3.0-orange)

## Overview

FA_Recruitment is a comprehensive Recruitment module for FrontAccounting that manages the entire hiring process from requisition to onboarding with modern PHP architecture.

### Features

- **Job Requisitions** - Create and manage job openings with requirements
- **Candidate Management** - Track candidates through pipeline stages
- **Interview Scheduling** - Schedule and manage interviews
- **Rating System** - Score candidates on interview criteria
- **Offer Management** - Generate offers and track acceptance
- **Pipeline Tracking** - Visual candidate pipeline with stage progression
- **Employee Onboarding** - Auto-create employees on hire
- **Integration** - HR workflow and employee management integration

### Status

**PLANNED** - In Development

- Requisition management with priority levels
- Candidate pipeline with configurable stages
- Interview scheduling and feedback collection
- Offer generation with compensation tracking
- Auto-onboarding workflow integration

## Quick Start

### Installation

1. **Copy module files**:
```bash
cp -r ksf_FA_Recruitment /path/to/frontaccounting/modules/
```

2. **Install via FrontAccounting**:
- Go to Administrator > Modules > Install Modules
- Find FA_Recruitment and click Install

3. **Database tables** are created automatically on install

4. **Assign permissions** to users via Administrator > User Roles

### Using the Module

Access via the Recruitment menu after installation:

- **Recruitment Dashboard**: Overview and statistics
- **Requisitions**: Job openings management
- **Candidates**: Candidate pipeline
- **Interviews**: Interview scheduling
- **Offers**: Offer management
- **Reports**: Analytics and reporting

## Database Tables

### Core Tables

| Table | Description |
|-------|-------------|
| `fa_recruit_requisitions` | Job requisitions |
| `fa_recruit_candidates` | Candidate profiles |
| `fa_recruit_interviews` | Interview schedules |
| `fa_recruit_interview_ratings` | Interview ratings/scores |
| `fa_recruit_offers` | Job offers |
| `fa_recruit_requisition_types` | Requisition type definitions |
| `fa_recruit_activity_log` | Audit trail |

### Pipeline Stages

Default candidate stages:
1. Applied
2. Phone Screen
3. Technical Interview
4. Manager Interview
5. HR Interview
6. Offer Extended
7. Hired / Rejected

### Requisition Status

Default status:
- Open
- Filled
- Cancelled
- On Hold

## Permissions

| Permission | Description |
|------------|-------------|
| `RECRUIT_VIEW_REQUISITION` | View job requisitions |
| `RECRUIT_MANAGE_REQUISITION` | Manage requisitions |
| `RECRUIT_VIEW_CANDIDATE` | View candidates |
| `RECRUIT_MANAGE_CANDIDATE` | Manage candidates |
| `RECRUIT_VIEW_INTERVIEW` | View interviews |
| `RECRUIT_MANAGE_INTERVIEW` | Manage interviews |
| `RECRUIT_VIEW_OFFER` | View offers |
| `RECRUIT_MANAGE_OFFER` | Manage offers |
| `RECRUIT_VIEW_ANALYTICS` | View analytics |
| `RECRUIT_ADMIN` | Full administrative access |

## API Reference

### Database Functions

```php
// Requisition management
add_requisition($requisition_data);
update_requisition($requisition_id, $data);
delete_requisition($requisition_id);
get_requisitions($status);
get_requisition_by_id($id);

// Candidate management
add_candidate($candidate_data);
update_candidate($candidate_id, $data);
delete_candidate($candidate_id);
get_candidates_by_requisition($requisition_id);
move_candidate_stage($candidate_id, $stage);

// Interview management
schedule_interview($interview_data);
update_interview($interview_id, $data);
cancel_interview($interview_id);
get_interviews_by_candidate($candidate_id);
get_interviews_by_requisition($requisition_id);

// Ratings
add_interview_rating($rating_data);
get_candidate_ratings($candidate_id);

// Offers
create_offer($offer_data);
update_offer($offer_id, $data);
accept_offer($offer_id);
reject_offer($offer_id);
get_offers_by_candidate($candidate_id);

// Analytics
get_requisition_analytics($requisition_id);
get_pipeline_summary();
get_hiring_metrics();
```

### UI Functions

```php
// Display components
requisition_summary($requisition_id);
candidate_pipeline($requisition_id);
interview_schedule_widget();
candidate_card($candidate_id);

// Form helpers
requisition_types_list_row($label, $name, $value);
priority_list_row($label, $name, $value);
interview_stage_list_row($label, $name, $value);
```

## Events

The module dispatches events for integration:

- `recruit.requisition.created` - New requisition
- `recruit.requisition.updated` - Requisition updated
- `recruit.requisition.filled` - Position filled
- `recruit.candidate.created` - New candidate
- `recruit.candidate.stage_changed` - Candidate moved stages
- `recruit.candidate.hired` - Candidate hired
- `recruit.interview.scheduled` - Interview scheduled
- `recruit.interview.completed` - Interview completed
- `recruit.offer.created` - Offer generated
- `recruit.offer.accepted` - Offer accepted
- `recruit.onboarding.started` - Onboarding initiated

## Development

### Testing

```bash
# Run unit tests
./vendor/bin/phpunit tests/

# Run specific test file
./vendor/bin/phpunit tests/RecruitmentModuleTest.php
```

### File Structure

```
ksf_FA_Recruitment/
├── FA_Recruitment_Module.php  # Module registration
├── recruit.php          # Main module
├── hooks.php           # Installation hooks
├── includes/
│   ├── recruit_db.inc # Database functions
│   └── recruit_ui.inc # UI components
├── pages/             # Page handlers
├── sql/
│   └── install.sql    # Schema
└── tests/            # Unit tests
```

## Troubleshooting

### Common Issues

1. **Candidates not showing in pipeline**
   - Verify requisition is active
   - Check candidate status

2. **Interview scheduling issues**
   - Check interviewer availability
   - Verify date/time format

3. **Permissions errors**
   - Assign Recruitment permissions to user role

4. **Offer not generating**
   - Verify all interview stages completed
   - Check candidate status

## Version History

| Version | Changes |
|---------|---------|
| 1.0.0 | Initial release with complete recruitment features |

## Requirements

- FrontAccounting 2.4.0+
- PHP 8.0+
- MySQL 5.7+ / MariaDB 10.0+

## License

Copyright (C) 2024 KSFII Development Team

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
GNU General Public License for more details.

## Support

For issues and feature requests, please open an issue on the project repository.

## Documentation

Full documentation is available in `ProjectDcs/`:

- [Functional Requirements](ProjectDcs/Functional%20Requirements.md)
- [Architecture](ProjectDcs/Architecture.md)
- [Test Plan](ProjectDcs/Test%20Plan.md)
- [UAT Plan](ProjectDcs/UAT%20Plan.md)

---
*FA_Recruitment Module v1.0.0*
*For FrontAccounting 2.4.x*
