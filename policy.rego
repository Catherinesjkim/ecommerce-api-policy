package shopify.api.access

# Default deny
default allow := false

# Allow all users for versioned APIs if version is "v1"
allow if {
    segments := split(trim(input.path, "/"), "/")
    segments[0] == "v1"
    not restricted_path(segments)
}

# Admin-only rule
allow if {
    segments := split(trim(input.path, "/"), "/")
    segments[0] == "v1"
    segments[1] == "admin"
    input.user.role == "admin"
}

# Restrict sales team to orders only
allow if {
    segments := split(trim(input.path, "/"), "/")
    segments[0] == "v1"
    segments[1] == "orders"
    input.user.role == "sales"
}

# Helper: Restric access if path starts with admin and user is not admin
restricted_path(segments) if {
    segments[1] == "admin"
    input.user.role != "admin"
}