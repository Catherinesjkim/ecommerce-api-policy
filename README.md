# Shopify API Access Control with OPA
## PCI DSS requirements related to access control, specifically in Requirement 7 & 8

This policy enforces:
- API version check (`v1`)
- Role-based access:
    - Admins can access `/v1/admin/...`
    - Sales team can access `/v1/orders/...`

# ✅ Test with OPA CLI
```bash
opa eval -i input.json -d policy.rego "data.shopify.api.access.allow"

Expected output for a sales user accessing /v1/orders/123: true


✅ input.json (Example Request)
{
  "path": "/v1/orders/123",
  "user": {
    "name": "Dwight",
    "role": "sales"
  }
}
✅ Returns true


Admin trying /v1/admin/users:

{
  "path": "/v1/admin/users",
  "user": {
    "name": "Michael",
    "role": "admin"
  }
}
✅ Returns true


Sales trying /v1/admin/users:
{
  "path": "/v1/admin/users",
  "user": {
    "name": "Dwight",
    "role": "sales"
  }
}
✅ Returns false





✅ Key Features
- Uses split() to parse path segments.
- Uses array.slice for dynamic route validation if needed.
- Role-based logic implemented in pure Rego.

✅ Why This is Shopify-Style
- Shopify uses API versioning (/v1/, /2025-01/).
- Shopify has role-based access for internal tools (e.g., admin panels).
- This policy enforces both.


