# drps-scraper

Made this on a rainy Saturday morning.

A scraper and extractor for all courses at the University of Edinburgh.

Requires bash, `ag`, GNU parallel, and an internet connection.

## File Structure

### Scraper

Currently, the project has a script to scrape every course on DRPS,
`/scrape.sh`, and sort them correctly by college, schedule, subject, and
course into a folder using the names of the files themselves.

Uses sed to generate scraping commands rapidly. Uses GNU Parallel to scrape
over 9,000 pages in a few minutes.

Since the commands each contain parameters at certain arguments, one can simply
use `cut` to get all parameters for all files.

### Extractor

In `/extract` there are 5 scripts that regex out the corequisites, credits,
level, prerequisites, and prohibited combinations (antirequisites) for every
course. Using `ag`, this is pretty fast, and is even precedence aware for
requisite boolean algebra.

### UI

No work has been done on the UI for this so far. Maybe I'll get around to this
someday, for now the joy of writing the scraper was enough.

## Roadmap

Simple task before getting my hands dirty with the frontend: Turn scraper.sh
into a Makefile, since this is a simple case of Makefile usage.

Find a way to handle errors in the data (lots of lecturers don't understand De
Morgan when defining antirequisites in their courses.)

Afterwards, design a proper simple UI for the insights extracted by ./extract.
