
# Notes
The translation benchmark was not converging with a BLEU of 25.  I ran ten jobs on Mustang for 96 hours that never converged.  Reduced the BLEU score to 20 in translation/tensorflow/run_and_time.sh to see if the jobs will converge in a reasonable time.

# References

 * [3. Benchmarks](https://github.com/mlperf/policies/blob/master/training_rules.adoc#3-benchmarks) - lists the benchmarks and quality targets.
