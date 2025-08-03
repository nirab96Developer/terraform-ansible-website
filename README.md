# מסמך הגשה - פרויקט גמר DevOps

---

## פרטי הסטודנט

**שם:** ניר אביטבול  
**מייל:** avitbulnir@gmail.com  
**מכללה:** המכללה למנהל ראשון לציון הנדסאים.

**תאריך הגשה:** 03.08.2025

---

## תיאור הפרויקט

בפרויקט זה בניתי תשתית מלאה להעלאת אתר בצורה אוטומטית באמצעות **Terraform** ו-**Ansible** על גבי שרת **AWS**. מטרת הפרויקט היא להדגים הבנה מעשית ב-Infrastructure as Code, ניהול קונפיגורציה, אבטחה, ותהליך deployment מלא.

---

## 🧱 חלק ראשון - תשתית (Terraform)

### קבצי Terraform:

- **`main.tf`**: יוצר שרת EC2 (Ubuntu 22.04), מגדיר מפתח SSH, מקצה Elastic IP, ויוצר אבטחה מתקדמת עם Security Group ו-provisioner להפעלת Ansible אוטומטית.

- **`variables.tf`**: משתנים עיקריים כמו project_name, מפתחות SSH, region, instance_type ועוד.

- **`terraform.tfvars`**: קובץ ערכים אמיתיים למשתנים (לא נכלל ב-Git מסיבות אבטחה).

- **`outputs.tf`**: מציג פלטים חשובים - Elastic IP, פקודת SSH, כתובת האתר.

- **`ansible.cfg`**: מגדיר איך Ansible ירוץ מול inventory בלי לבדוק host key.

---

## ⚙️ חלק שני - קונפיגורציית שרת (Ansible)

### קבצי Ansible:

- **`playbook.yml`**: 
  - התקנת nginx
  - הגדרת האתר
  - יצירת תיקיות
  - הפעלת UFW firewall
  - העתקת תמונה ודפי אתר
  - הפעלת בדיקות אוטומטיות

- **`vars/main.yml`**: תוכן מותאם אישית - פרטי התלמיד, צבעים, כותרות.

- **`templates/index.html.j2`**: תבנית האתר המותאמת אישית עם כל הפרטים.

- **`templates/nginx-site.j2`**: הגדרות אבטחה, headers, cache, gzip, שגיאות מותאמות.

- **`files/profile.jpg`**: תמונה אישית לאתר.

- **`inventory/hosts`**: נבנה אוטומטית עם כתובת ה-IP של השרת.

---

## 📁 מבנה תיקיות

```
terraform-ansible-website/
├── terraform/
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   ├── terraform.tfvars
│   └── ansible.cfg
├── ansible/
│   ├── playbook.yml
│   ├── vars/main.yml
│   ├── templates/
│   │   ├── index.html.j2
│   │   └── nginx-site.j2
│   ├── files/
│   │   └── profile.jpg
│   └── inventory/
│       └── hosts
└── README.md
```

---

## 📄 תיעוד

כולל הסבר מלא על:
- מטרות הפרויקט
- שלבי התקנה (init, plan, apply)
- הפעלת Ansible אוטומטית
- מה נפרס בדיוק
- פרטי השרת והגישה
- קישורים ופרטים אישיים

---

## 🔐 אבטחה

### ברמת AWS:
- **Security Group** פתוח רק לפורטים 22, 80, 443
- הגבלת SSH לפי IP מורשה בלבד
- Elastic IP לכתובת קבועה

### ברמת השרת:
- הפעלת UFW firewall
- הגדרות אבטחה ב-nginx:

  - `X-Frame-Options: SAMEORIGIN`
  - `X-Content-Type-Options: nosniff`
  - `X-XSS-Protection: 1; mode=block`
- מניעת גישה לקבצים מוסתרים
- gzip ו-cache לאופטימיזציה וביצועים

---

## ✅ בדיקות שבוצעו

1. **בדיקת nginx**: `nginx -t` - עבר בהצלחה
2. **בדיקת localhost**: `curl http://localhost` - מחזיר 200 OK
3. **בדיקת דפדפן**: פתיחת האתר בדפדפן - עובד מצוין
4. **כתובת האתר**: http://34.203.229.249 - פעיל ונגיש

---

## 📊 תכונות האתר

- עיצוב responsive
- פרופיל אישי עם תמונה
- רשימת כישורים (Python, Java, C++, C#, JavaScript, Bash)
- טכנולוגיות DevOps (Terraform, Ansible, AWS, Docker)
- מידע על הפרויקט
- קישורים לרשתות חברתיות

---

## 🏁 סטטוס סופי

✅ **האתר באוויר ופעיל**  
✅ **כל הבדיקות עברו בהצלחה**  
✅ **תיעוד מלא קיים**  
✅ **פריסה אוטומטית מלאה**  
✅ **אבטחה מקיפה**  
✅ **קוד ב-GitHub**  

---

## 🔗 קישורים

- **אתר חי**: http://34.203.229.249
- **GitHub**: https://github.com/niravitbul/terraform-ansible-website
- **LinkedIn**: https://www.linkedin.com/in/nir-avitbul

---

## 📝 הערות נוספות

הפרויקט מדגים:
- שליטה ב-Infrastructure as Code
- יכולת אוטומציה מלאה
- הבנת עקרונות DevOps
- ניהול קונפיגורציה מתקדם
- יישום best practices באבטחה
- תיעוד מקצועי



