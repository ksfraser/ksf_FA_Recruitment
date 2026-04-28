# FA_Recruitment Test Plan

## Document Information
- **Module**: FA_Recruitment (Recruitment Management)
- **Version**: 1.0.0
- **Date**: 2024-04-26
- **Status**: Planned
- **Author**: KSFII Development Team

## 1. Introduction

### 1.1 Purpose
This test plan defines the testing strategy and approach for the FA_Recruitment module, ensuring all functional requirements are met and the module functions correctly within the FrontAccounting framework.

### 1.2 Scope
- Unit testing of core functions
- Integration testing with FA framework
- UI component testing
- Interview scheduling testing
- Database operation testing

### 1.3 Test Environment
- **PHP Version**: 8.0+
- **Database**: MySQL 5.7+ / MariaDB 10.0+
- **FA Version**: 2.4.0+
- **Testing Framework**: PHPUnit

## 2. Testing Strategy

### 2.1 Test Levels

#### Unit Testing
Testing individual functions and methods in isolation.

#### Integration Testing
Testing the module's interaction with FA core components.

#### System Testing
End-to-end testing of complete workflows.

### 2.2 Test Types

| Type | Description | Coverage |
|------|-------------|----------|
| Functional | Verify features work as specified | 100% |
| Regression | Ensure no existing features broken | 100% |
| Performance | Verify acceptable response times | Selected |
| Security | Verify input validation | Critical paths |

## 3. Test Cases by Module

### 3.1 Requisition Management (TC-RQ)

#### TC-RQ-001: Create Requisition
**Preconditions**: 
- User has RECRUIT_MANAGE_REQUISITION permission

**Test Steps**:
1. Create new requisition with required fields
2. Verify requisition created
3. Check requisition number generated

**Expected Result**: Requisition created with unique number

**Priority**: High

#### TC-RQ-002: Update Requisition
**Preconditions**: 
- Requisition exists

**Test Steps**:
1. Update requisition title
2. Update priority to high
3. Update salary range

**Expected Result**: All fields updated correctly

**Priority**: High

#### TC-RQ-003: Close Requisition
**Preconditions**: Requisition exists

**Test Steps**:
1. Update status to filled
2. Set filled_date
3. Verify requisition closed

**Expected Result**: Requisition status updated to filled

**Priority**: High

#### TC-RQ-004: Requisition CRUD
**Preconditions**: User has RECRUIT_ADMIN permission

**Test Steps**:
1. Create new requisition type
2. List requisition types
3. Update requisition type
4. Delete requisition type

**Expected Result**: All operations succeed

**Priority**: Medium

#### TC-RQ-005: Requisition Search
**Preconditions**: Multiple requisitions exist

**Test Steps**:
1. Search by status
2. Search by department
3. Search by priority

**Expected Result**: Correctly filtered results

**Priority**: Medium

### 3.2 Candidate Management (TC-CD)

#### TC-CD-001: Add Candidate
**Preconditions**: Requisition exists

**Test Steps**:
1. Add candidate with all fields
2. Verify candidate created
3. Check requisition_id foreign key

**Expected Result**: Candidate created and linked

**Priority**: High

#### TC-CD-002: Move Candidate Stage
**Preconditions**: Candidate exists

**Test Steps**:
1. Move candidate from Applied to Phone Screen
2. Move to Technical Interview
3. Move to Manager Interview

**Expected Result**: Stage progression tracked

**Priority**: High

#### TC-CD-003: Reject Candidate
**Preconditions**: Candidate exists

**Test Steps**:
1. Mark candidate as rejected
2. Add rejection reason
3. Update status

**Expected Result**: Candidate marked as rejected

**Priority**: High

#### TC-CD-004: Candidate Search
**Preconditions**: Multiple candidates exist

**Test Steps**:
1. Search by name
2. Search by requisition
3. Search by stage

**Expected Result**: Correctly filtered results

**Priority**: Medium

#### TC-CD-005: Candidate Resume Upload
**Preconditions**: Requisition exists

**Test Steps**:
1. Add candidate with resume file
2. Verify upload succeeds
3. Check resume stored

**Expected Result**: Resume uploaded successfully

**Priority**: High

### 3.3 Interview Management (TC-IN)

#### TC-IN-001: Schedule Interview
**Preconditions**: 
- Candidate exists
- Interviewer user exists

**Test Steps**:
1. Schedule interview with date/time
2. Select interview type
3. Select interviewer
4. Save

**Expected Result**: Interview scheduled

**Priority**: High

#### TC-IN-002: Complete Interview
**Preconditions**: Interview exists

**Test Steps**:
1. Mark interview as completed
2. Add feedback
3. Update status

**Expected Result**: Interview marked completed

**Priority**: High

#### TC-IN-003: Cancel Interview
**Preconditions**: Interview exists

**Test Steps**:
1. Cancel interview
2. Add cancellation reason
3. Verify status updated

**Expected Result**: Interview cancelled

**Priority**: High

#### TC-IN-004: Interview Feedback
**Preconditions**: Interview exists

**Test Steps**:
1. Add technical rating
2. Add communication rating
3. Add recommendation

**Expected Result**: Ratings saved

**Priority**: High

#### TC-IN-005: Interview Calendar
**Preconditions**: Multiple interviews scheduled

**Test Steps**:
1. View calendar
2. Check date display
3. Check interviewer assignment

**Expected Result**: Calendar displays correctly

**Priority**: Medium

### 3.4 Rating System (TC-RT)

#### TC-RT-001: Rate Candidate
**Preconditions**: Interview exists

**Test Steps**:
1. Add rating for each criteria
2. Add notes
3. Submit rating

**Expected Result**: Ratings saved

**Priority**: High

#### TC-RT-002: Aggregate Ratings
**Preconditions**: Multiple interviews with ratings

**Test Steps**:
1. Query aggregate ratings
2. Calculate averages per criteria

**Expected Result**: Correct averages calculated

**Priority**: Medium

#### TC-RT-003: Rating Criteria CRUD
**Preconditions**: User has RECRUIT_ADMIN permission

**Test Steps**:
1. Create custom criteria
2. Use in interview
3. Delete criteria (if not in use)

**Expected Result**: All operations succeed

**Priority**: Medium

### 3.5 Offer Management (TC-OF)

#### TC-OF-001: Create Offer
**Preconditions**: 
- Candidate exists at final stage
- All interviews completed

**Test Steps**:
1. Create offer with salary
2. Set start date
3. Set benefits
4. Save as draft

**Expected Result**: Offer created

**Priority**: High

#### TC-OF-002: Send Offer
**Preconditions**: Offer exists as draft

**Test Steps**:
1. Send offer to candidate
2. Update status to sent
3. Set sent_date

**Expected Result**: Offer sent

**Priority**: High

#### TC-OF-003: Accept Offer
**Preconditions**: Offer sent

**Test Steps**:
1. Accept offer
2. Update status to accepted
3. Set response_date

**Expected Result**: Offer accepted

**Priority**: High

#### TC-OF-004: Reject Offer
**Preconditions**: Offer sent

**Test Steps**:
1. Reject offer
2. Update status to rejected
3. Add response notes

**Expected Result**: Offer rejected

**Priority**: High

### 3.6 Employee Onboarding (TC-OB)

#### TC-OB-001: Auto-Create Employee
**Preconditions**: 
- Offer accepted
- Employee module available

**Test Steps**:
1. Mark candidate as hired
2. Verify employee created

**Expected Result**: Employee record created

**Priority**: High

#### TC-OB-002: Onboarding Tasks
**Preconditions**: Candidate hired

**Test Steps**:
1. Verify onboarding tasks created
2. Check task assignment

**Expected Result**: Tasks generated

**Priority**: Medium

### 3.7 Analytics (TC-AN)

#### TC-AN-001: Requisition Analytics
**Preconditions**: Requisition with candidates exists

**Test Steps**:
1. View requisition analytics
2. Check candidate count
3. Check stage distribution

**Expected Result**: Metrics calculated correctly

**Priority**: Medium

#### TC-AN-002: Pipeline Summary
**Preconditions**: Multiple candidates exist

**Test Steps**:
1. Get pipeline summary
2. Calculate by stage
3. Verify conversion rates

**Expected Result**: Correct pipeline metrics

**Priority**: Medium

#### TC-AN-003: Hiring Metrics
**Preconditions**: Multiple hires exist

**Test Steps**:
1. Get hiring metrics
2. Calculate acceptance rate
3. Calculate time to hire

**Expected Result**: Correct metrics

**Priority**: Medium

### 3.8 Activity Logging (TC-AL)

#### TC-AL-001: Activity Log Creation
**Preconditions**: User actions performed

**Test Steps**:
1. Create requisition
2. Add candidate
3. Schedule interview

**Expected Result**: Activities logged with details

**Priority**: High

### 3.9 Permissions (TC-AC)

#### TC-AC-001: Permission Enforcement
**Preconditions**: Multiple users with different roles

**Test Steps**:
1. Test with RECRUIT_VIEW_REQUISITION only
2. Test with RECRUIT_MANAGE_REQUISITION

**Expected Result**: Access correctly enforced

**Priority**: High

#### TC-AC-002: Menu Visibility
**Preconditions**: User with limited permissions

**Test Steps**:
1. Check menu items visible
2. Test page access

**Expected Result**: Menu visibility correct

**Priority**: High

### 3.10 Integration (TC-INT)

#### TC-INT-001: Event Dispatching
**Preconditions**: None

**Test Steps**:
1. Create requisition
2. Check events triggered

**Expected Result**: Events dispatch correctly

**Priority**: High

#### TC-INT-002: Employee Module Integration
**Preconditions**: Employee module installed

**Test Steps**:
1. Hire candidate
2. Verify employee created in FA

**Expected Result**: Integration works

**Priority**: High

## 4. Performance Tests

### 4.1 Large Dataset Tests
- Test with 100 requisitions
- Test with 1000 candidates
- Test with 500 interviews

### 4.2 Response Time Requirements
- Dashboard load: < 3 seconds
- Requisition list (100 records): < 1 second
- Search results: < 2 seconds

## 5. Security Tests

### 5.1 Input Validation Tests
- SQL injection attempts
- XSS in description fields
- Invalid email formats

### 5.2 Access Control Tests
- Unauthorized access attempts
- Cross-user data access
- Privilege escalation

### 5.3 File Upload Tests
- Invalid file types
- Large file handling
- File path traversal

## 6. Test Data Management

### 6.1 Test Data Requirements
- Sample requisitions (minimum 10)
- Sample candidates (minimum 20)
- Sample interviews (minimum 10)
- Sample offers (minimum 5)

### 6.2 Test Data Cleanup
- Use database transactions for rollback
- Clean up after test suites
- Reset auto-increment counters

## 7. Test Execution

### 7.1 Test Run Matrix

| Environment | Browser | FA Version | PHP Version |
|-------------|---------|------------|--------------|
| Local | Chrome | 2.4.x | 8.1 |
| Dev | Firefox | 2.4.x | 8.0 |
| CI | Headless | 2.4.x | 8.1 |

### 7.2 Test Schedule
- Unit tests: Every commit
- Integration tests: Daily
- Full regression: Before release

### 7.3 Pass/Fail Criteria
- Unit tests: 100% pass required
- Integration tests: 95% pass required
- Critical functional tests: 100% pass required

## 8. Defect Reporting

### 8.1 Severity Levels
- **Critical**: System crash, data loss
- **High**: Core feature not working
- **Medium**: Feature partially working
- **Low**: Cosmetic issue

### 8.2 Priority Levels
- **P0**: Must fix before release
- **P1**: Should fix before release
- **P2**: Can fix in next release
- **P3**: Backlog

## 9. Risk Assessment

### 9.1 High-Risk Areas

| Risk | Likelihood | Impact | Mitigation |
|------|------------|--------|------------|
| Pipeline stage bugs | Medium | High | Extensive test cases |
| Employee integration | Medium | High | Integration tests |
| Performance with large data | High | Medium | Query optimization |
| File upload handling | Medium | Medium | File validation |

### 9.2 Mitigation Strategies
- Comprehensive test coverage
- Regular compatibility testing
- Performance profiling
- Security audits

## 10. Test Deliverables

- [x] Test Plan Document
- [x] Test Cases (this document)
- [x] Test Scripts (tests/ directory)
- [x] Test Data Setup
- [x] Test Results Reports
- [x] Defect Reports

---
*Document Version: 1.0.0*
*Last Updated: 2024-04-26*
