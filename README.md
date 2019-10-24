# ArchiLab Graylog

This is a basic configuration that helps running the ArchiLab Graylog instance with minimal effort.

## Installation

The initial configuration of Graylog requires a root password and the corresponding SHA-256 hash. Those are read from files in the secrets folder of this project but must not be pushed to the repository for security purposes.

Create the two files:

```bash
echo "<PASSWORD>" > ./secrets/GRAYLOG_PASSWORD_SECRET
echo "<HASH>" > ./secrets/GRAYLOG_ROOT_PASSWORD_SHA2
```

Then start the service:

```bash
./run
```
