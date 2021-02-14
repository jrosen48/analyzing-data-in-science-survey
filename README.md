# analyzing-data-in-science-survey

This analysis requires saving the following files in a `data` directory:

- `Analyzing+Data+in+Science_February+14,+2021_10.51.csv` # this is from mailing lists with the response options
- `Analyzing+Data+in+Science_February+14,+2021_10.52.csv`
- `Analyzing+Data+in+Science+-+Copy+for+Mailing+List+Posts_February+14,+2021_10.50 (1).csv`
- `Analyzing+Data+in+Science+-+Copy+for+Mailing+List+Posts_February+14,+2021_10.50.csv` # this is from social media with the response options

These are available here: https://osf.io/mzcuy/

Then, run:

- `targets::tar_make()`

To access content, use:

- `targets::tar_read()` with the name of the target