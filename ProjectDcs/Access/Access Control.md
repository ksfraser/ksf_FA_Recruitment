# FA Recruitment Module - Access Control Specification

## Document Information

| Field | Value |
|-------|-------|
| Document Title | Access Control Specification |
| Module | ksf_FA_Recruitment |
| Version | 1.0.0 |
| Author | KSF Development Team |
| Last Updated | May 2026 |

---

## 1. Access Control Overview

### 1.1 Purpose

Access control for ksf_FA_Recruitment:
- **Recruiters** manage job postings and candidates
- **Hiring Managers** review candidates for their departments
- **Interviewers** access candidate data for assigned reviews
- **HR Admin** has full recruitment access

### 1.2 Key Principles

| Principle | Description |
|-----------|-------------|
| Need-to-Know | Users only see relevant candidate data |
| Candidate Privacy | PII protected throughout process |
| Hiring Manager Input | Department heads have review authority |
| Audit Trail | All recruitment actions logged |

---

## 2. Role Definitions

| Role | Access Level |
|------|--------------|
| Recruiter | All jobs, all candidates |
| Hiring Manager | Own department positions + candidates |
| Interviewer | Assigned candidates only |
| HR Admin | Full access + configuration |

---

## 3. Record-Level Access

### 3.1 Job Requisition

| Field | Recruiter | Hiring Manager | HR Admin |
|-------|-----------|----------------|----------|
| Job Title | Read/Write | Read | Read/Write |
| Department | Read/Write | Read | Read/Write |
| Salary Range | Read/Write | Read (range) | Read/Write |
| Requirements | Read/Write | Read/Write (own reqs) | Read/Write |
| Status | Read/Write | Read | Read/Write |

### 3.2 Candidate Records

| Field | Recruiter | Hiring Manager | Interviewer | HR Admin |
|-------|-----------|----------------|-------------|----------|
| Contact Info | Read/Write | Hidden | Hidden | Read/Write |
| Resume | Read | Read (assigned) | Read (assigned) | Read/Write |
| Application Status | Read/Write | Read (own reqs) | Hidden | Read/Write |
| Interview Notes | Read/Write | Read/Write (assigned) | Read/Write (own) | Read/Write |
| Ratings | Read | Read (assigned) | Read/Write (own) | Read/Write |
| Salary Expectation | Read | Hidden | Hidden | Read/Write |
| Background Check | Hidden | Hidden | Hidden | Read/Write |

---

## 4. Hiring Manager Visibility

### 4.1 Scope

Hiring Managers see candidates for:
1. Job requisitions they own or are assigned to
2. Their department's open positions
3. Specific candidates assigned to them for interview

### 4.2 Collaboration

Hiring Managers can:
- Add interview notes
- Provide hiring recommendation
- Request additional interview rounds
- Cannot: Extend offers, modify salary (HR Admin only)

---

## 5. Interviewer Access

### 5.1 Limited View

Interviewers only access:
- Candidates assigned to them
- Position details for context
- Scorecard/rating forms
- Their own interview notes

### 5.2 Conflict of Interest

Interviewers cannot view candidates if:
- Family member is candidate
- Personal conflict declared
- Previous employment relationship

---

## 6. Family Company Considerations

### 6.1 Family Members

| Scenario | Access |
|----------|--------|
| Family member as candidate | Normal candidate access |
| Family member as recruiter | Full recruitment access |
| Family member as hiring manager | Normal department access |
| Family member as interviewer | Normal assigned access |

### 6.2 Gift Flag

Referral bonuses and hiring rewards:
- Normal access for eligibility
- With `gift_flag=true`: Only HR Admin可见 amount and details

---

## 7. Candidate Privacy

### 7.1 PII Protection

| Data Type | Access |
|-----------|--------|
| SSN/ID Numbers | HR Admin only |
| Bank Details | Never stored until onboarding |
| Medical Info | HR Admin only (if disclosed) |
| Salary History | HR Admin + Hiring Manager (after offer) |

### 7.2 Data Retention

- Active candidates: Duration of process + 1 year
- Rejected candidates: Anonymized after 6 months (GDPR)
- Hired candidates: Moved to employee record

---

## 8. Revision History

| Version | Date | Author | Changes |
|---------|------|--------|---------|
| 1.0.0 | May 2026 | KSF Development Team | Initial specification |