# From the Deep

In this problem, you'll write freeform responses to the questions provided in the specification.

## Random Partitioning

Distributing data randomly across three boats ensures load balance and accessibility, but it wastes storage space and makes queries slower since data may be spread across all boats. This method is simple but not space-efficient.

---

## Partitioning by Hour

Dividing data by time (e.g., hourly) lets each boat store only relevant data, improving efficiency and space use. It’s well-suited for time-series data but can slow down queries that span multiple time periods.

---

## Partitioning by Hash Value

Hash partitioning distributes data evenly across boats using a hash of attributes like `sensor_id`. It speeds up lookups and balances load but can separate related data and complicate maintenance if hash values change. Indexing can improve performance.

---

**Summary:**
Time-based and hash partitioning both improve efficiency compared to random distribution. A time-based approach fits AquaByte’s data pattern, while hashing offers balanced load and scalability.
