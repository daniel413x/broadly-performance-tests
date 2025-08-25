# Broadly JMeter Performance Testing
**Author:** Daniel Maramba  

## Test execution  

### Run tests

Use JMeter parameters to define test execution parameters and required credentials:

```bash
jmeter -n \
  -t test-plans/load-testing.jmx \
  -JTHREADS=100 \
  -JRAMPUP=60 \
  -JDURATION=300 \
  -JSTRIPE_ACCOUNT=... \
  -JSTRIPE_SECRET=... \
  -l results/load-testing-results.jtl
```
Alternatively, pass in a `secrets.properties` file to define credentials:

```bash
jmeter -n \
  -t test-plans/load-testing.jmx \
  -JTHREADS=100 \
  -JRAMPUP=60 \
  -JDURATION=300 \
  -q secrets.properties \
  -l results/load-test.jtl