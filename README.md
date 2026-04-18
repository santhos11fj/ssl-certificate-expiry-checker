# 🔐 SSL Certificate Governance & Monitoring System

A complete **DevSecOps-ready solution** to monitor SSL certificate expiry, generate reports, trigger alerts, and enforce governance using **Docker, GitHub Actions, Slack, and Agile workflows**.

---

## 🚀 Overview

This project goes beyond a simple SSL checker. It provides an **end-to-end automated pipeline** that:

* Scans SSL certificates for multiple domains
* Detects expiry risks and classifies severity
* Generates HTML reports
* Sends real-time Slack alerts
* Automatically creates GitHub Issues
* Tracks incidents in an Agile sprint board
  
<img width="541" height="420" alt="image" src="https://github.com/user-attachments/assets/027864e7-9371-4b5a-af77-dea2c0c349a0" />

👉 The goal is to **eliminate unexpected SSL failures** and enable **proactive governance**.

---

## 🏗️ Architecture (End-to-End Flow)

```
SSL Scan (PowerShell)
        ↓
Docker Execution
        ↓
JSON Output + HTML Report
        ↓
GitHub Actions (CI/CD)
        ↓
 ┌───────────────┬───────────────┐
 │               │               │
Slack Alerts   GitHub Issues   GitHub Pages
 │               │               │
Real-time     Incident        Live Dashboard
Notifications Tracking
```

---

## ✅ Key Features

### 🔍 1. SSL Monitoring

* Scans multiple domains from `endpoints.json`
* Retrieves:

  * Issuer
  * Expiry Date
  * Days Remaining

---

### 🚨 2. Severity Classification

Certificates are categorized as:

| Severity  | Condition  |
| --------- | ---------- |
| 🟢 Safe   | > 90 days  |
| 🟡 Low    | 60–90 days |
| 🟠 Medium | 30–60 days |
| 🔴 High   | < 30 days  |
| ❌ Error   | Expired    |

---

### 👤 3. Ownership Mapping

Each domain has an **owner (team/email)**:

```json
{
  "hostname": "www.facebook.com",
  "owner": "fb-meta@facebook.com"
}
```

👉 Alerts include responsible owner for accountability.

---

### 📊 4. HTML Dashboard (GitHub Pages)

* Auto-generated report
* Displays all domains with severity
* Hosted via GitHub Pages

<img width="1365" height="610" alt="image" src="https://github.com/user-attachments/assets/053afec2-b1b6-40b3-84c0-c6b46ed9dbff" />

👉 Example:

```
output/index.html
```

---

### 🔔 5. Slack Notifications

* Real-time alerts using webhook
* Includes:

  * Domain
  * Severity
  * Days left
  * Owner
  
<img width="1920" height="874" alt="image" src="https://github.com/user-attachments/assets/f25a57c5-42f3-41b4-9e19-859d5a9652d4" />

Example:

```
⚠️ SSL Expiry Alert Detected!
www.facebook.com - Severity: High - Days Left: 8 - Owner: fb-meta@facebook.com
```

---

### 🐙 6. GitHub Issue Automation

* Automatically creates issues for high-risk certificates
* Adds labels:

  * High
  * Error
  * SSL Certificate

Example:

```
SSL Alert: www.facebook.com (High severity)
```
<img width="1920" height="868" alt="image" src="https://github.com/user-attachments/assets/af80464e-30d4-4cd3-b47f-ba8c7c875256" />

---

### 📌 7. Agile Governance (Sprint Board)

* Issues tracked in GitHub Project board
* Workflow:

  * Backlog → Ready → In Progress → Done

👉 Converts alerts into actionable tasks
<img width="1920" height="871" alt="image" src="https://github.com/user-attachments/assets/3227d98b-4d58-476f-9698-dd60df0fdfb8" />

---

### ⚙️ 8. CI/CD Automation (GitHub Actions)

* Runs scan automatically (daily or manual)
* Builds Docker container
* Generates reports
* Triggers alerts
  
<img width="1920" height="865" alt="image" src="https://github.com/user-attachments/assets/748c1f0d-7308-451f-aaf6-09e8f7aad122" />

---

### 🐳 9. Dockerized Execution

* Consistent environment
* No local dependency issues
* Easy to run anywhere

---

## 🖥️ How to Run Locally (Simple)

### Step 1: Clone the Repository

```
git clone https://github.com/santhos11fj/ssl-certificate-expiry-checker.git
cd ssl-certificate-expiry-checker
```

---

### Step 2: Build Docker Image

```
docker build -t ssl-governance .
```

---

### Step 3: Run the Container

```
docker run --rm -v %cd%\reports:/app/reports -v %cd%\output:/app/_site ssl-governance
```

---

### Step 4: View Report

Open:

```
output/index.html
```

---

## 🧪 Testing

Modify domains in:

```
endpoints.json
```

Example:

```json
{
  "hostname": "expired.badssl.com",
  "owner": "test@example.com"
}
```

Then rerun Docker command.

## ⏱️ Automation Setup

Workflow file:

```
.github/workflows/check-ssl-expiry.yml
```
---

## 🎯 Real-World Use Case

* Prevent website downtime due to expired SSL
* Enable proactive security monitoring
* Automate DevOps workflows
* Improve team accountability
---

## 📜 License

MIT License

---

## 🙌 Author

Developed by **Santhosh**

---

## ⭐ Final Note

This project demonstrates:

✔ DevOps
✔ Security Monitoring
✔ Automation
✔ CI/CD
✔ Agile Integration

👉 A complete **production-style solution**
