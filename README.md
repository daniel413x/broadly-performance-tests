# Broadly JMeter Performance Testing
**Author:** Daniel Maramba

## Objective

Fulfill performance testing for the Broadly platform by carrying out **load testing**, **stress testing**, **soak testing**, and **spike testing** (the **"test procedures"**) and generating test reports thereof. 

## Prerequisites

### Apache JMeter

Apache JMeter must be installed and available via the CLI as `jmeter`. The project was developed using version 5.6.3.

### Secret credentials

A file `secrets.properties` must be made available that contains the following `key=value` pairs (note that values *cannot* be surrounded by quotation marks):

```bash
STRIPE_SECRET=VALUE # Found in the Stripe dashboard
STRIPE_ACCOUNT=VALUE # Found in the Stripe dashboard
INFLUX_DB_TOKEN=VALUE # Created in the Influx DB GUI
INFLUX_DB_URL=VALUE # For example: http://localhost:8086/api/v2/write?org=broadly&bucket=jmeter
```

in Jenkins, these pairs can be included in a `Credentials` file.

## Structure

Test plans (`.jmx`) are located in `./test-plans`. The parameters for executing the test plans according to the **test procedures** are located in `./scenarios`.

## Test plan & design

All **test procedures** are executed according to the test plan `./test-plans/test-plan-1.jmx`, which includes a base set of procedures implemented by `Concurrency Thread Groups`. Executing the **test procedures** is a matter of adjusting the parameters (target, ramp-up, etc.) of the thread groups, and the `.properties` files located in `./scenarios` contain parameters adjusted for each **test procedure**.

## Test execution  

### Running tests

Use the `jmeter` CLI command and pass in a `secrets.properties` and an operative scenario properties file. For example, to execute load tests, run:

```bash
jmeter -n \
  -t test-plans/test-plan-1.jmx \
  -q secrets.properties \
  -q scenarios/load.properties \
  -l results/load-test.jtl
```
## Test reports  & metrics

### Report output

Test reports can be generated with JMeter by passing in the parameter  `-l results/results.jtl` when executing tests.

### Grafana

Real-time test results can be viewed in on your Grafana dashboard.
