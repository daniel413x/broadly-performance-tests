# Broadly JMeter Performance Testing
**Author:** Daniel Maramba

## Objective

Fulfill performance testing for the Broadly platform by carrying out **smoke testing**, **load testing**, **stress testing**, **soak testing**, and **spike testing** (the **"test procedures"**) and generating test reports thereof. 

## Prerequisites

### BlazeMeter Taurus

BlazeMeter Taurus must be installed and available via the CLI as `bzt`. The project was developed using version 1.16.34.

### Environment variables

Environment variables must be defined matching those expected by the file `scenarios/properties.yaml`.

```bash
export STRIPE_SECRET_KEY=VALUE     # Found in the Stripe dashboard
export STRIPE_ACCOUNT=VALUE  # Found in the Stripe dashboard
export INFLUX_DB_TOKEN=VALUE # Created in the Influx DB GUI
export INFLUX_DB_URL=VALUE      # For example: http://localhost:8086/api/v2/write?org=broadly&bucket=jmeter
```

### JMeter agents

The main branch is configured for a distributed workload in order to execute tests at high-volume concurrency. A list of JMeter server-agent endpoints must be passed into the scenario `.yaml` `distributed` blocks. In the main branch, a helper script `add_distributed_hosts.sh` can do this automatically if `kubectl` is available in the orchestrating client.

## Structure

Test plans (`.jmx`) are located in `./test-plans`. The `.yaml` configurations for executing the test plans according to the **test procedures** are located in `./scenarios`.

## Test plan & design

All **test procedures** are executed according to the test plan `./test-plans/test-plan-1.jmx`, which includes a base set of procedures implemented by `Concurrency Thread Groups`. Executing the **test procedures** is a matter of adjusting the parameters (target, ramp-up, etc.) of the thread groups, and the `.yaml` files located in `./scenarios` contain parameters adjusted for each **test procedure**.

## Test execution

### Compiling endpoints

Use the `add_distributed_hosts.sh` script to automatically compile a list of JMeter server-agent endpoints:

```bash
./add_distributed_hosts.sh
```

### Running tests

Use the `bzt` CLI command and pass in a `secrets.properties` and an operative scenario properties file. For example, to execute load tests, run:

```bash
bzt properties.yaml scenarios/load.yaml
```

## Test reports  & metrics

### Report output

Test reports are generated when executing tests and output to timestamped folders.

### Grafana

Real-time test results can be viewed in on the team's Grafana dashboard.
