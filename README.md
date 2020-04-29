# Personal website repository

Forked and simplified from [academicpages](https://github.com/academicpages/academicpages.github.io).

### How to update:

1. Add DOIs to `_update_cv_and_pubs/cv_input_data/doi_list.txt` and any CV info to `_update_cv_and_pubs/cv_input_data/*info.tsv`
2. Update the publication list and CV by running `_update_cv_and_pubs/update_pubs_and_cv.R`, which will:

  - Retrieve the publication's data and save it in `_update_cv_and_pubs/pubs_data.rds` and as a *.bib* file in `_update_cv_and_pubs/cv_input_data/my_pubs.bib`.
  - Update the *Publications* site (`_pages/publications.md`).
  - Update the CV by rendering `_update_cv_and_pubs/cv.Rmd`.
3. Test it locally: Execute `bundle exec jekyll serve` and open [http://localhost:4000](http://localhost:4000) with a browser.
4. Git add, commit and push if satisfied.