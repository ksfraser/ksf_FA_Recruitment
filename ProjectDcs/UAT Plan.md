# FA_Recruitment UAT Plan

## Document Information
- **Module**: FA_Recruitment (Recruitment Management)
- **Version**: 1.0.0
- **Date**: 2024-04-26
- **Status**: Planned
- **Author**: KSFII Development Team

## 1. Introduction

### 1.1 Purpose
This UAT Plan defines the user acceptance test cases for the FA_Recruitment module. These tests verify that the module meets business requirements from an end-user perspective.

### 1.2 Scope
- Requisition management
- Candidate management
- Interview scheduling
- Rating and feedback
- Offer management
- Employee onboarding
- Analytics and reporting

### 1.3 Test Environment
- **Platform**: FrontAccounting 2.4.x
- **Browser**: Chrome/Firefox latest
- **PHP**: 8.0+
- **Database**: MySQL 5.7+

### 1.4 Stakeholders
- HR Managers
- Recruiters
- Hiring Managers
- Department Heads
- HR Administrators

## 2. UAT Test Cases

### 2.1 Requisition Management (UAT-RQ)

#### UAT-RQ-001: Create Job Requisition
**Objective**: Verify user can create a new job requisition

**Test Scenario**:
1. Navigate to Recruitment → Requisitions
2. Click Add New Requisition
3. Enter job title: "Senior Developer"
4. Select department: Engineering
5. Select hiring manager
6. Enter description and requirements
7. Set priority: High
8. Set employment type: Full Time
9. Set salary range
10. Set target fill date
11. Save

**Expected Result**: Requisition created with unique number

**Acceptance Criteria**:
- [ ] Requisition saved to database
- [ ] Unique requisition number generated
- [ ] Status defaults to Open
- [ ] Appears in requisition list

---

#### UAT-RQ-002: View Requisition Details
**Objective**: Verify user can view requisition details

**Test Scenario**:
1. Navigate to Requisitions
2. Select a requisition
3. View requisition details

**Expected Result**: All requisition information displays

**Acceptance Criteria**:
- [ ] Title displays correctly
- [ ] Department displays
- [ ] Manager displays
- [ ] Status displays
- [ ] Priority displays
- [ ] Salary range displays
- [ ] Candidate count shows

---

#### UAT-RQ-003: Update Requisition
**Objective**: Verify user can update requisition

**Test Scenario**:
1. Open requisition
2. Edit job title
3. Change priority
4. Update salary range
5. Save

**Expected Result**: All updates saved

**Acceptance Criteria**:
- [ ] Title updates successfully
- [ ] Priority updates successfully
- [ ] Salary range updates successfully
- [ ] Changes persist after reload

---

#### UAT-RQ-004: Close Requisition
**Objective**: Verify user can close a requisition

**Test Scenario**:
1. Open requisition
2. Click Close/Fill
3. Select reason: Position Filled
4. Set filled date
5. Confirm

**Expected Result**: Requisition closed

**Acceptance Criteria**:
- [ ] Status changes to Filled
- [ ] Filled date set
- [ ] Requisition marked as closed

---

#### UAT-RQ-005: Search Requisitions
**Objective**: Verify search functionality

**Test Scenario**:
1. Navigate to Requisitions
2. Filter by status: Open
3. Filter by department: Engineering
4. Filter by priority: High
5. Apply filters

**Expected Result**: Correctly filtered results

**Acceptance Criteria**:
- [ ] Results match filter criteria
- [ ] Multiple filters work together
- [ ] Clear filters resets list

---

### 2.2 Candidate Management (UAT-CD)

#### UAT-CD-001: Add Candidate to Requisition
**Objective**: Verify user can add candidates

**Test Scenario**:
1. Open requisition
2. Navigate to Candidates section
3. Click Add Candidate
4. Enter first name, last name, email
5. Enter phone number
6. Enter current company
7. Enter experience years
8. Upload resume
9. Set source: Indeed
10. Save

**Expected Result**: Candidate added to requisition

**Acceptance Criteria**:
- [ ] Candidate saved to database
- [ ] Linked to requisition
- [ ] Stage defaults to Applied
- [ ] Status defaults to Active

---

#### UAT-CD-002: View Candidate Pipeline
**Objective**: Verify pipeline view

**Test Scenario**:
1. Open requisition
2. View Candidates section
3. See pipeline view

**Expected Result**: Candidates displayed in pipeline

**Acceptance Criteria**:
- [ ] Candidates grouped by stage
- [ ] Stage shows count
- [ ] Can click to view candidate

---

#### UAT-CD-003: Move Candidate to Next Stage
**Objective**: Verify stage progression

**Test Scenario**:
1. Select candidate
2. Click Move to Next Stage
3. Select next stage: Phone Screen
4. Add notes: Passed initial review
5. Confirm

**Expected Result**: Candidate moved to next stage

**Acceptance Criteria**:
- [ ] Stage changes to Phone Screen
- [ ] Previous stage date recorded
- [ ] Note added to history

---

#### UAT-CD-004: Reject Candidate
**Objective**: Verify candidate rejection

**Test Scenario**:
1. Select candidate
2. Click Reject
3. Select reason: Not qualified
4. Add additional notes
5. Confirm

**Expected Result**: Candidate marked as rejected

**Acceptance Criteria**:
- [ ] Status changes to Rejected
- [ ] Rejection reason saved
- [ ] Candidate removed from active pipeline

---

#### UAT-CD-005: Search Candidates
**Objective**: Verify candidate search

**Test Scenario**:
1. Navigate to Candidates
2. Search by name
3. Filter by requisition
4. Filter by stage: Technical Interview

**Expected Result**: Correctly filtered results

**Acceptance Criteria**:
- [ ] Name search works
- [ ] Requisition filter works
- [ ] Stage filter works

---

### 2.3 Interview Management (UAT-IN)

#### UAT-IN-001: Schedule Interview
**Objective**: Verify user can schedule interviews

**Test Scenario**:
1. Open candidate
2. Click Schedule Interview
3. Select type: Technical Interview
4. Set date and time
5. Select interviewer
6. Set duration: 60 minutes
7. Set location or meeting URL
8. Add notes
9. Save

**Expected Result**: Interview scheduled

**Acceptance Criteria**:
- [ ] Interview saved
- [ ] Interviewer assigned
- [ ] Shows in interview list
- [ ] Shows in calendar

---

#### UAT-IN-002: Complete Interview
**Objective**: Verify interview completion

**Test Scenario**:
1. Open scheduled interview
2. Click Mark Complete
3. Add feedback: Good technical skills
4. Set technical rating: 4
5. Set communication rating: 4
6. Set overall rating: 4
7. Add recommendation: Hire
8. Add strengths and concerns
9. Save

**Expected Result**: Interview marked complete

**Acceptance Criteria**:
- [ ] Status changes to Completed
- [ ] Ratings saved
- [ ] Feedback stored

---

#### UAT-IN-003: Schedule Follow-Up Interview
**Objective**: Verify follow-up scheduling

**Test Scenario**:
1. After interview, need follow-up
2. Click Schedule Follow-Up
3. Select interviewer
4. Set date/time
5. Save

**Expected Result**: Follow-up scheduled

**Acceptance Criteria**:
- [ ] Second interview links to first
- [ ] Shows in candidate timeline

---

#### UAT-IN-004: Cancel Interview
**Objective**: Verify interview cancellation

**Test Scenario**:
1. Open scheduled interview
2. Click Cancel
3. Select reason: Candidate request
4. Add notes
5. Confirm

**Expected Result**: Interview cancelled

**Acceptance Criteria**:
- [ ] Status changes to Cancelled
- [ ] Reason saved

---

#### UAT-IN-005: View Interview Calendar
**Objective**: Verify calendar view

**Test Scenario**:
1. Navigate to Calendar
2. View by day
3. View by week

**Expected Result**: Interviews display on calendar

**Acceptance Criteria**:
- [ ] Interviews show on correct dates
- [ ] Interviewer name shows
- [ ] Candidate name shows

---

### 2.4 Rating System (UAT-RT)

#### UAT-RT-001: Rate Interview
**Objective**: Verify rating collection

**Test Scenario**:
1. Complete interview
2. Add ratings: Technical 4, Communication 5
3. Add criteria ratings
4. Add recommendation: Hire
5. Add strengths
6. Add concerns
7. Submit rating

**Expected Result**: Ratings saved

**Acceptance Criteria**:
- [ ] Rating values saved
- [ ] Recommendation saved
- [ ] Comments saved

---

#### UAT-RT-002: View Aggregate Ratings
**Objective**: Verify aggregate view

**Test Scenario**:
1. Open candidate with multiple interviews
2. View Rating Summary

**Expected Result**: Aggregate ratings display

**Acceptance Criteria**:
- [ ] Average ratings per criteria shown
- [ ] Overall rating calculated
- [ ] All interviews included

---

### 2.5 Offer Management (UAT-OF)

#### UAT-OF-001: Create Offer
**Objective**: Verify offer creation

**Test Scenario**:
1. Candidate at final stage
2. Click Create Offer
3. Enter salary: $100,000
4. Select salary type: Annual
5. Set start date
6. Add benefits package
7. Set bonus eligible: Yes
8. Save as Draft

**Expected Result**: Offer created

**Acceptance Criteria**:
- [ ] Offer saved
- [ ] Status is Draft
- [ ] Shows in Offers list

---

#### UAT-OF-002: Send Offer
**Objective**: Verify sending offer to candidate

**Test Scenario**:
1. Open draft offer
2. Click Send to Candidate
3. Confirm

**Expected Result**: Offer sent

**Acceptance Criteria**:
- [ ] Status changes to Sent
- [ ] Sent date recorded

---

#### UAT-OF-003: Accept Offer
**Objective**: Verify offer acceptance

**Test Scenario**:
1. Candidate accepts offer
2. Mark offer as Accepted
3. Set response date
4. Add notes

**Expected Result**: Offer accepted

**Acceptance Criteria**:
- [ ] Status changes to Accepted
- [ ] Response date saved

---

#### UAT-OF-004: Hire Candidate
**Objective**: Verify candidate hired

**Test Scenario**:
1. After offer accepted
2. Click Hire Candidate
3. Confirm hiring

**Expected Result**: Candidate hired

**Acceptance Criteria**:
- [ ] Candidate status is Hired
- [ ] Employee created
- [ ] Onboarding triggered

---

### 2.6 Employee Onboarding (UAT-OB)

#### UAT-OB-001: Employee Created
**Objective**: Verify employee record created

**Test Scenario**:
1. Candidate hired
2. Check FA employee module

**Expected Result**: Employee record exists

**Acceptance Criteria**:
- [ ] Employee created in FA
- [ ] Name and info transferred

---

#### UAT-OB-002: Onboarding Tasks
**Objective**: Verify onboarding task creation

**Test Scenario**:
1. Candidate hired
2. Navigate to onboarding tasks
3. View tasks

**Expected Result**: Tasks created

**Acceptance Criteria**:
- [ ] IT setup task created
- [ ] HR paperwork task created
- [ ] Department task created
- [ ] Tasks assigned

---

### 2.7 Analytics & Reports (UAT-AN)

#### UAT-AN-001: Requisition Report
**Objective**: Verify requisition reporting

**Test Scenario**:
1. Navigate to Reports
2. Select Requisition Report
3. View open requisitions

**Expected Result**: Report displays

**Acceptance Criteria**:
- [ ] All requisitions shown
- [ ] Candidate counts accurate
- [ ] Status correct

---

#### UAT-AN-002: Pipeline Report
**Objective**: Verify pipeline reporting

**Test Scenario**:
1. Navigate to Reports
2. Select Pipeline Report
3. View by stage

**Expected Result**: Pipeline metrics display

**Acceptance Criteria**:
- [ ] Candidates by stage shows
- [ ] Conversion rates accurate

---

#### UAT-AN-003: Hiring Metrics
**Objective**: Verify hiring metrics

**Test Scenario**:
1. Navigate to Reports
2. Select Hiring Metrics
3. View time to hire

**Expected Result**: Metrics display

**Acceptance Criteria**:
- [ ] Hires count accurate
- [ ] Time to hire calculated
- [ ] Acceptance rate shown

---

### 2.8 Administration (UAT-AD)

#### UAT-AD-001: Permissions
**Objective**: Verify permission assignment

**Test Scenario**:
1. As admin, navigate to user roles
2. Assign RECRUIT_MANAGE_REQUISITION
3. Test as that user

**Expected Result**: Permissions enforced

**Acceptance Criteria**:
- [ ] Menu items show based on permissions
- [ ] CRUD operations restricted
- [ ] Cannot access unpermitted areas

---

#### UAT-AD-002: Activity Log
**Objective**: Verify audit trail

**Test Scenario**:
1. Navigate to Settings → Activity Log
2. View recent activities

**Expected Result**: Activities logged

**Acceptance Criteria**:
- [ ] User actions logged
- [ ] Timestamps accurate
- [ ] Details show

---

### 2.9 Integration Tests (UAT-INT)

#### UAT-INT-001: Event Notifications
**Objective**: Verify events fire

**Test Scenario**:
1. Create requisition
2. Add candidate
3. Schedule interview

**Expected Result**: Events dispatch

**Acceptance Criteria**:
- [ ] Internal events work
- [ ] External modules can listen

---

#### UAT-INT-002: Employee Module
**Objective**: Verify employee integration

**Test Scenario**:
1. Hire candidate
2. Verify employee created
3. Check employee data

**Expected Result**: Integration works

**Acceptance Criteria**:
- [ ] Employee created
- [ ] Data transferred correctly

---

## 3. Sign-Off Criteria

### 3.1 Test Completion Metrics
- **Total UAT Test Cases**: 30+
- **Passed**: [ ]
- **Failed**: [ ]
- **Blocked**: [ ]
- **Pass Rate**: [ ]%

### 3.2 Sign-Off Requirements
All critical (P0) test cases must pass:
- [ ] Requisition management
- [ ] Candidate management
- [ ] Interview scheduling
- [ ] Offer management
- [ ] Permission enforcement

### 3.3 Sign-Off Table

| Test Area | Tester | Date | Result |
|----------|--------|------|--------|
| Requisition Management | | | Pass/Fail |
| Candidate Management | | | Pass/Fail |
| Interview Scheduling | | | Pass/Fail |
| Offer Management | | | Pass/Fail |
| Onboarding | | | Pass/Fail |
| Reports | | | Pass/Fail |
| Administration | | | Pass/Fail |

---

## 4. Defect Reporting

### 4.1 Defect Categories
- **Critical**: System crash, data loss
- **Major**: Core feature not working
- **Minor**: Feature partially working
- **Cosmetic**: UI issue

### 4.2 Defect Report Template

```
ID: 
Test Case: 
Environment: 
Expected: 
Actual: 
Severity: 
Priority: 
Tester: 
Date: 
```

---

## 5. Success Criteria

### 5.1 Go/No-Go Decision
The module passes UAT when:
1. 100% critical test cases pass
2. 95% overall test cases pass
3. No Critical or Major defects open
4. Business sign-off obtained

### 5.2 Issue Resolution
- **Critical**: Must fix before release
- **Major**: Must fix before release
- **Minor**: Release OK with known issues
- **Cosmetic**: Can defer to next release

---

## 6. UAT Environment Setup

### 6.1 Required Test Data
- 3 Active Requisitions (different departments)
- 5 Candidates per requisition (various stages)
- 10 Completed interviews with ratings
- 2 Hired candidates
- 3 Test users (Recruiter, Hiring Manager, Admin)

### 6.2 Test Accounts
- HR Admin: Full access
- Recruiter: Manage requisitions, candidates, interviews
- Hiring Manager: View requisitions, manage interviews for their requisitions

---

*Document Version: 1.0.0*
*Last Updated: 2024-04-26*
