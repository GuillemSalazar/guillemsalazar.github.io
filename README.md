Personal website repository forked and modified from [academicpages](https://github.com/academicpages/academicpages.github.io)

How to update publications and CV:

1. Add DOIs to `_update_cv_and_pubs/doi_list.txt`
2. Update the publication list: run `_update_cv_and_pubs/update_pubs.R` which will retrieve the publication's data, save it in `_update_cv_and_pubs/pubs_data.rds` and add the publications to the *Publications* site (`_pages/publications.md`)
3. Update the CV: knit `_update_cv_and_pubs/cv.Rmd` which will re-build the CV with the new publications.
4. Test it locally: Execute `bundle exec jekyll serve` and open [http://localhost:4000](http://localhost:4000) with a browser.
5. Git add, commit and push if satisfied.