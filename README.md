Here is an updated **README.md** tailored to **your enhanced SSL Governance Prototype**, highlighting all original contributions you implemented:

---

# 🔐 **SSL Governance & Expiry Monitoring – DevSecOps-Ready Prototype**

**A Complete DevSecOps Pipeline to Monitor, Alert, and Govern SSL Certificates**

<img src="docs/SSLCertificateGovernanceFramework.png" alt="SSL Governance Framework"/>

---

## 🚀 **Overview**

This prototype **evolved beyond a simple SSL expiry checker**. It integrates **monitoring**, **role-based governance**, **Slack alerts**, **GitHub issue automation**, and **Agile/DevSecOps alignment** into a single CI/CD pipeline.

It **not only detects expiring SSL certificates**, but also:

* **Assigns ownership** to responsible teams,
* **Creates incident tickets** automatically,
* **Publishes real-time HTML reports**, and
* **Aligns with Agile sprint cycles** for continuous governance.

---

## ✅ **Key Features**

### 🔹 **1. Advanced SSL Monitoring**

* PowerShell-based scanner retrieves:

  * Issuer
  * Expiry Date
  * Days Remaining
* Classifies certificates into:

  * 🟢 **Safe**
  * 🟡 **Low**
  * 🟠 **Medium**
  * 🔴 **High**
  * ❌ **Error** (expired)

---

### 🔹 **2. Role-Based Governance**

* `endpoints.json` now includes an **owner field** (team/email).
* Alerts and issues **tag the owner**, enabling **accountability and faster resolution**.

---

### 🔹 **3. Slack Notifications**

* Custom PowerShell notifier (`Send-SlackAlert.ps1`) sends grouped alerts with:

  * Hostname
  * Severity (color-coded in Slack)
  * Days Remaining
  * Owner
* ✅ Verified alerts appear in the `#ssl-alerts` channel.

---

### 🔹 **4. GitHub Issues Automation**

* Integrated into CI workflow:

  * Creates **issues** for **High** / **Error** severity.
  * Includes: Domain, Severity, Days Left, Environment, Owner.
  * ✅ Duplicate prevention avoids issue spamming.

---

### 🔹 **5. Real-Time HTML Reporting**

* Generates a color-coded **SSL Health Dashboard**.
* Displays all endpoints with Issuer, Days Left, Severity.
* ✅ Automatically deployed to **GitHub Pages**.

---

### 🔹 **6. CI/CD Pipeline Integration**

* **GitHub Actions Workflow**:

  1. SSL Scan →
  2. Slack Alerts →
  3. GitHub Issues →
  4. HTML Report Deployment
* Runs **daily at midnight UTC** (configurable).

---

### 🔹 **7. Agile & DevSecOps Alignment**

* SSL monitoring and remediation integrated into Agile sprints:

  * Alerts → backlog items
  * GitHub Issues → sprint tasks
  * Reports → sprint review artifacts
* ✅ Security becomes **continuous**, not reactive.

---

## 🏆 **What Makes This Prototype Unique**

Unlike standard SSL monitoring tools or cloud-native solutions:

* ✅ **Open-source** & **cost-effective**
* ✅ Integrated **Role-Based Governance**
* ✅ **Slack + GitHub** real-time incident management
* ✅ **DevSecOps-ready** CI/CD pipeline
* ✅ **HTML reporting** for stakeholders
* ✅ **Test Mode** for safe demo runs

---

## 📂 **Repository Structure**

```
/lib
 ├─ Get-RemoteCertificate.ps1      # Retrieves SSL details
 ├─ check-ssl-expiry.ps1           # Main scanner
 ├─ Send-SlackAlert.ps1            # Slack integration
 └─ Generate-HTMLReport.ps1        # Dashboard generator

.github/workflows
 └─ check-ssl-expiry.yml           # CI/CD pipeline (scan → alerts → issues → report)

/docs
 └─ SSLCertificateGovernanceFramework.png

endpoints.json                     # List of domains + owners
alertThresholds.json               # Severity thresholds
sslCertificateDetails.json         # Generated scan results
```

---

## ⚙️ **Usage**

1. **Fork/Clone** this repository.
2. Update `endpoints.json` with your domains & owners.
3. Configure GitHub Secrets:

   * `SLACK_WEBHOOK` → Slack integration
4. (Optional) Modify `alertThresholds.json` for custom severity thresholds.
5. Commit changes → Workflow runs automatically.

---

## 🔄 **How It Works (Pipeline Flow)**

```
[ GitHub Actions Trigger ]
       ↓
[ SSL Scan (check-ssl-expiry.ps1) ]
       ↓
[ JSON Report Generated ]
       ↓
 ┌──────────────┬──────────────┬───────────────┐
 │ Slack Alerts │ GitHub Issues│ HTML Report   │
 │   (Critical) │ (Auto-Tickets│ (Dashboard)   │
 └──────────────┴──────────────┴───────────────┘
```

---

## 📊 **Risk Management Features**

The prototype incorporates **risk analysis techniques**:

* **Fishbone Diagram** → Identifies root causes of SSL failures.
* **FMEA Table** → Quantifies risks using RPN.
* **Pareto Chart** → Highlights top causes contributing to most outages.

📌 *(These visuals are included in the documentation and dissertation.)*

---

## 🚀 **Planned Enhancements**

* 🔹 **Auto SSL Renewal** (Let’s Encrypt / Win-ACME integration)
* 🔹 **Historical Trend Dashboard** (Chart.js)
* 🔹 **JIRA Integration** for enterprise workflows
* 🔹 **Multi-Cloud Policy Enforcement**

---

## 🛠 **Built With**

* **PowerShell** (SSL Scanning & Alerting)
* **GitHub Actions** (CI/CD pipeline)
* **Slack Webhooks** (Real-Time Alerts)
* **Chart.js & HTML** (Dashboard Visualization)

---

## 📜 **License**

MIT Licensed.
You are free to use, modify, and extend this project.

---

## 🤝 **Contributions**

Contributions are welcome!

* Raise a Pull Request with enhancements.
* Report issues under **GitHub Issues**.

