# Business Requirements - ksf_FA_Recruitment

## Overview
ksf_FA_Recruitment is the FrontAccounting adapter for ksf_Recruitment (Applicant Tracking System).

## Relationship to Core Module

### Core Module
- **ksf_Recruitment**: Business logic
- Namespace: `Ksfraser\Recruitment`

### FA Adapter
- **ksf_FA_Recruitment**: FA presentation layer
- Namespace: `Ksfraser\FA\Recruitment`

## FA-Specific Features

### Database Integration
- FA-compliant tables: `fa_recruitment_positions`, `fa_applicants`, etc.
- Links to FA users for hiring managers

### HR Integration
- Links to ksf_FA_HRM for employee creation
- Job posting to company website

## Link to Core BR
This adapter implements: `/home/kevin/Documents/ksf_Recruitment/ProjectDcs/Business Requirements.md`

*Document Version: 1.0.0*
*Last Updated: 2026-05-11*