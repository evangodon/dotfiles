---
name: mycli-cli
description: Use mycli to run MySQL queries against local development databases. Use when you need to query or update data in a local MySQL container, inspect table schemas, or run SQL as part of a runbook or debugging session.
---

# mycli-cli Skill

## Description

mycli is a MySQL CLI with syntax highlighting and autocomplete. Use it to run queries
against the local MySQL container in the dev environment.

## Connection strings

Credentials are found in each service's `config/dbconf.yml`.

| Service | Connection |
|---|---|
| jaws | `mysql://root:$VEND_DB_PASSWORD@127.0.0.1:3306/jaws` |

To find credentials for other services:
```bash
cat /path/to/service/config/dbconf.yml
```

## Running a query

```bash
mycli mysql://root:$VEND_DB_PASSWORD@127.0.0.1:3306/jaws -e "SELECT id, job_status_id FROM jobs WHERE retailer_id = '00000000-0001-0001-0001-000000000001' LIMIT 5;"
```

## Running a multi-statement query

```bash
mycli mysql://root:$VEND_DB_PASSWORD@127.0.0.1:3306/jaws -e "
  UPDATE jobs SET job_status_id = 123 WHERE retailer_id = '00000000-0001-0001-0001-000000000001' LIMIT 1;
  SELECT id, job_status_id FROM jobs WHERE retailer_id = '00000000-0001-0001-0001-000000000001' LIMIT 1;
"
```

## Inspecting a table schema

```bash
mycli mysql://root:$VEND_DB_PASSWORD@127.0.0.1:3306/jaws -e "DESCRIBE jobs;"
```

## Tips

- Always follow a write query with a SELECT to verify the change
- Use `LIMIT 1` on UPDATEs unless you intentionally want to affect all rows
- Credentials live in `config/dbconf.yml` in each service repo — never hardcode them elsewhere
